//
//  mem.c
//  mem
//
//  Created by Liu Junqi on 3/23/18.
//  Copyright © 2018 DeviLeo. All rights reserved.
//

#include "mem.h"
#include "mem_utils.h"
#include <time.h>
#include "lz4.h"
#include <pthread.h>

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR // Imports from /usr/lib/system/libsystem_kernel.dylib
// xnu-4570.1.46/osfmk/vm/vm_user.c

/*
 * Do NOT use mach_vm_read, it will cause memory leak.
 * Use mach_vm_read_overwrite instead.
 */
extern kern_return_t
mach_vm_read(
             vm_map_t               map,
             mach_vm_address_t      addr,
             mach_vm_size_t         size,
             pointer_t              *data,
             mach_msg_type_number_t *data_size);

extern kern_return_t
mach_vm_read_overwrite(
                       vm_map_t           target_task,
                       mach_vm_address_t  address,
                       mach_vm_size_t     size,
                       mach_vm_address_t  data,
                       mach_vm_size_t     *outsize);

extern kern_return_t
mach_vm_write(
              vm_map_t                          map,
              mach_vm_address_t                 address,
              pointer_t                         data,
              __unused mach_msg_type_number_t   size);

extern kern_return_t
mach_vm_region(
               vm_map_t                 map,
               mach_vm_offset_t         *address,       /* IN/OUT */
               mach_vm_size_t           *size,          /* OUT */
               vm_region_flavor_t       flavor,         /* IN */
               vm_region_info_t         info,           /* OUT */
               mach_msg_type_number_t   *count,         /* IN/OUT */
               mach_port_t              *object_name);  /* OUT */

extern kern_return_t
mach_vm_region_recurse(
                       vm_map_t                 map,
                       mach_vm_address_t        *address,
                       mach_vm_size_t           *size,
                       uint32_t                 *depth,
                       vm_region_recurse_info_t info,
                       mach_msg_type_number_t   *infoCnt);

extern kern_return_t
mach_vm_protect(
                vm_map_t            map,
                mach_vm_offset_t    start,
                mach_vm_size_t      size,
                boolean_t           set_maximum,
                vm_prot_t           new_protection);

#else
#include <mach/mach_vm.h>
#endif

void *read_range_mem(mach_port_t task, mach_vm_address_t address, int forward, int backward, mach_vm_address_t *ret_address, mach_vm_size_t *ret_data_size) {
    mach_vm_offset_t region_address = address < forward ? address : address - forward;
    mach_vm_size_t region_size = 0;
    vm_region_flavor_t flavor = VM_REGION_BASIC_INFO_64;
    mach_port_t object_name = 0;
    vm_region_basic_info_data_64_t info;
    mach_msg_type_number_t info_count = VM_REGION_BASIC_INFO_COUNT_64;
    kern_return_t kret = mach_vm_region(task, &region_address, &region_size, flavor, (vm_region_info_t)&info, &info_count, &object_name);
    if (kret == KERN_SUCCESS) {
        mach_vm_address_t a = 0;
        mach_vm_size_t f = 0;
        mach_vm_size_t b = 0;
        if ((address < region_address) ||
            (address > region_address + region_size) ||
            (forward == 0 && backward == 0)) {
            f = 0;
            b = (region_size < backward || backward == 0) ? region_size : backward;
            a = region_address;
        } else {
            f = address - region_address;
            if (f > forward) f = forward;
            b = region_address + region_size - address;
            if (b > backward) b = backward;
            a = address - f;
        }
        mach_vm_size_t size = f + b;
        void *data = malloc(size);
        mach_vm_size_t data_size = 0;
        kern_return_t kret_read = mach_vm_read_overwrite(task, a, size, (mach_vm_address_t)data, &data_size);
        if (kret_read == KERN_SUCCESS) {
            if (ret_address) *ret_address = a;
            if (ret_data_size) *ret_data_size = data_size;
            return data;
        }
    }
    return NULL;
}

int read_region(mach_port_t task, mach_vm_address_t address, vm_region_basic_info_data_64_t *region_info) {
    mach_vm_size_t region_size = 0;
    vm_region_flavor_t flavor = VM_REGION_BASIC_INFO_64;
    mach_port_t object_name = 0;
    vm_region_basic_info_data_64_t info;
    mach_msg_type_number_t info_count = VM_REGION_BASIC_INFO_COUNT_64;
    
    kern_return_t kret = mach_vm_region(task, &address, &region_size, flavor, (vm_region_info_t)&info, &info_count, &object_name);
    if (kret != KERN_SUCCESS) return -1;
    if (region_info) *region_info = info;
    return 1;
}

int write_mem(mach_port_t task, mach_vm_address_t address, void *value, int size) {
    vm_region_basic_info_data_64_t info;
    int ret = read_region(task, address, &info);
    if (ret != 1) return -1;
    //    kern_return_t kret = task_suspend(task);
    //    if (kret != KERN_SUCCESS) return -2;
    kern_return_t kret = mach_vm_protect(task, address, size, FALSE, VM_PROT_WRITE | VM_PROT_READ | VM_PROT_COPY);
    if (kret != KERN_SUCCESS) { task_resume(task); return -3; }
    kret = mach_vm_write(task, address, (pointer_t)value, size);
    if (kret != KERN_SUCCESS) { task_resume(task); return -4; }
    kret = mach_vm_protect(task, address, size, FALSE, info.protection);
    if (kret != KERN_SUCCESS) { task_resume(task); return -5; }
    //    kret = task_resume(task);
    //    if (kret != KERN_SUCCESS) return -6;
    return 1;
}
static long get_timestamp() {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_sec * 1000 + tv.tv_usec / 1000;
}
search_result_chain_t search_mem_first(mach_port_t task, void *value, int size, int type, int comparison, int *length) {
    long begin_time  = get_timestamp();
    search_result_chain_t head_chain = NULL;
    search_result_chain_t chain = NULL;
    mach_vm_offset_t address = 0;
    mach_vm_size_t region_size = 0;
    vm_region_flavor_t flavor = VM_REGION_BASIC_INFO_64;
    mach_port_t object_name = 0;
    vm_region_basic_info_data_64_t info;
    mach_msg_type_number_t info_count = VM_REGION_BASIC_INFO_COUNT_64;
    int count = 0;
    kern_return_t kret = KERN_FAILURE;
    for(;;){
        address += region_size;
        printf("region---------------------%016llx\n",region_size);
        kret = mach_vm_region(task, &address, &region_size, flavor, (vm_region_info_t)&info, &info_count, &object_name);
        if (kret != KERN_SUCCESS) break;
        void *data = malloc(region_size);
        mach_vm_size_t data_size = 0;
        kern_return_t kret_read = mach_vm_read_overwrite(task, address, region_size, (mach_vm_address_t)data, &data_size);
        if (kret_read != KERN_SUCCESS) {
            free(data);
            continue;
        }
        void *big = data;
        int64_t big_size = data_size;
        void *result = NULL;
        do {
            result = search_mem_value(big, big_size, value, size, type, comparison);
            if (result == NULL) break;
            mach_vm_address_t result_address_slide = (mach_vm_address_t)result - (mach_vm_address_t)data;
            mach_vm_address_t result_address = address + result_address_slide;
            printf("resultaddress---------------------%016llx\n",result_address);
            big = result + size;
            big_size = data_size - result_address_slide - size;
            ++count;
            search_result_chain_t c = create_search_result_chain(result_address, value, size, type, info.protection);
            if (head_chain == NULL) { head_chain = c; }
            if (chain) { chain->next = c; }
            chain = c;
        } while (big_size >= size);
        free(data);
    }
    if (length) *length = count;
    long end_time = get_timestamp();
    printf(" ------time used: %.3f(s)------\n",
           (float)(end_time - begin_time)/1000.0f);
    return head_chain;
}

search_result_chain_t search_mem_in_chain(mach_port_t task, void *value, int size, int type, int comparison, search_result_chain_t chain, int *length) {
    int count = 0;
    search_result_chain_t head_chain = chain;
    search_result_chain_t prev_chain = NULL;
    void *data = malloc(size);
    while (chain) {
        int destroy_chain = 1;
        if (chain->result) {
            mach_vm_offset_t address = chain->result->address;
            mach_vm_size_t data_size = 0;
            kern_return_t kret_read = mach_vm_read_overwrite(task, address, size, (mach_vm_address_t)data, &data_size);
            if (kret_read == KERN_SUCCESS) {
                int r = compare_value(data, (int)data_size, value, size, type);
                int match = (comparison == SearchResultComparisonLT && r == -1) ||
                (comparison == SearchResultComparisonLE && (r == -1 || r == 0)) ||
                (comparison == SearchResultComparisonEQ && r == 0) ||
                (comparison == SearchResultComparisonGE && (r == 0 || r == 1)) ||
                (comparison == SearchResultComparisonGT && r == 1);
                if (match) {
                    destroy_chain = 0;
                    memcpy(chain->result->value, data, data_size);
                    ++count;
                }
            }
        }
        
        if (destroy_chain == 1) {
            if (prev_chain == NULL) {
                head_chain = chain->next;
                destroy_search_result_chain(chain);
                chain = head_chain;
            } else {
                prev_chain->next = chain->next;
                destroy_search_result_chain(chain);
                chain = prev_chain->next;
            }
        } else {
            prev_chain = chain;
            chain = chain->next;
        }
    }
    free(data);
    if (length) *length = count;
    return head_chain;
}

void review_mem_in_chain(mach_port_t task, search_result_chain_t chain) {
    while (chain) {
        if (chain->result) {
            mach_vm_offset_t address = chain->result->address;
            void *data = malloc(chain->result->size);
            mach_vm_size_t data_size = 0;
            
            kern_return_t kret_read = mach_vm_read_overwrite(task, address, chain->result->size, (mach_vm_address_t)data, &data_size);
            if (kret_read == KERN_SUCCESS) {
                memcpy(chain->result->value, data, data_size);
            }
            free(data);
        }
        chain = chain->next;
    }
}

search_result_chain_t search_mem(mach_port_t task, void *value, int size, int type, int comparison, search_result_chain_t chain, int *length) {
    search_result_chain_t result = NULL;
    if (chain == NULL) result = search_mem_first(task, value, size, type, comparison, length);
    else result = search_mem_in_chain(task, value, size, type, comparison, chain, length);
    return result;
}

void print_mem(void *data, mach_vm_size_t data_size) {
    for (mach_vm_size_t i = 0; i < data_size; ++i) {
        if (i % 16 == 0) {
            printf("\n%016llX ", (pointer_t)data + i);
        }
        printf("%02X ", *(unsigned char *)(data+i));
    }
}

search_result_chain_t near_mem_search_func(void *value,size_t size,int type,search_result_chain_t chain,int *length,int range){
    int haveresult = 0;
    int count = 0;
    search_result_chain_t head_chain = NULL;
    search_result_chain_t new_chain = NULL;
    while(chain){
    loop1: if(chain->result){
        mach_vm_address_t addr = chain->result->address;
        printf("----nearaddress:%016llx--------\n",chain->result->address);
        mach_vm_size_t data_size = 0;
        mach_vm_address_t data_addr = 0;
        vm_region_basic_info_data_64_t info;
        int ret = read_region(mach_task_self(),chain->result->address,&info);
        if (ret !=1){
            chain = chain->next;
            goto loop1;
        }
        
        void *data = read_range_mem(mach_task_self(),addr,range,range+size,&data_addr,&data_size);
        if(data ==NULL||data_size == 0){
            chain = chain->next;
            goto loop1;
        }
        void * result = NULL;
        void * big = data;
        int64_t big_size = data_size;
        do{
            
            result = search_mem_value(big,big_size,value,size,type,SearchResultComparisonEQ);
            if(result == NULL) {
                
                break;
            }
            haveresult = 1;
            mach_vm_address_t result_address_slide = (mach_vm_address_t)result - (mach_vm_address_t)data;
            mach_vm_address_t result_realaddress = data_addr + result_address_slide;
            big = result + size;
            big_size = data_size - result_address_slide - size;
            ++count;
            search_result_chain_t c = create_search_result_chain(result_realaddress,value,size,type,info.protection);
            if(head_chain == NULL){head_chain = c;}
            
            if(new_chain){new_chain->next = c;}
            new_chain = c;
        }while(big_size >= size);
        if (haveresult == 1) {
            haveresult = 0;
            search_result_chain_t c2 = create_search_result_chain(chain->result->address,chain->result->value,chain->result->size,chain->result->type,chain->result->protection);
            new_chain->next = c2;
            new_chain = c2;
            ++count;
        }
        chain = chain->next;
        free(data);
    }
    }
    
    destroy_all_search_result_chain(chain);
    if(length) *length = count;
    return head_chain;
    
}
