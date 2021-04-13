//
//  UtilDefines.h
//  WXDebugger
//
//  Created by WXDebugger on 29/07/2017.
//
//


#import <sys/sysctl.h>
#include<mach/mach_traps.h>
#include <mach/mach_init.h>
#include <mach/task.h>
#include <sys/ioctl.h>
#import <sys/stat.h>
#import <mach-o/dyld.h>

#import <objc/runtime.h>
#include <sys/utsname.h>

#ifndef UtilDefines_h
#define UtilDefines_h


#define DisPatchGetMainQueueBegin()\
dispatch_async(dispatch_get_main_queue(), ^{    \

#define DisPatchGetMainQueueEnd() \
})\

#define DisPatchGetGlobalQueueBegin()\
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);\
dispatch_async(queue, ^{\

#define DisPatchGetGlobalQueueEnd()\
})\


#define LCWeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define LCStrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

////DEBUG版本才有日志，release版本无日志
#ifdef DEBUG
#define pNSLog(format, ...) NSLog(@"[xlhk] m:[%d] %@", [[NSThread currentThread] isMainThread], [NSString stringWithFormat:format, ## __VA_ARGS__])
#else
#define pNSLog(format, ...) nil
#endif


#endif /* UtilDefines_h */
