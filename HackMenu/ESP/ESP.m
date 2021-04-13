
#import "ESP.h"
#import <UIKit/UIKit.h>
#import <stdio.h>
#import <mach-o/dyld.h>
#import <mach/vm_region.h>
#import <malloc/malloc.h>
#import <objc/runtime.h>
#import <mach/mach.h>

#define kLogOpen 0

float juzhenshuju[16];

typedef struct Vector{
    float X;
    float Y;
    float Z;
}Vector;

@interface HZ()
@property (nonatomic,  assign) CGFloat  scale;
@property (nonatomic,  assign) CGFloat  theWidth;
@property (nonatomic,  assign) CGFloat  theHeight;
@end

@implementation HZ

+ (instancetype)factory
{
    static HZ *fact;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fact = [[HZ alloc] init];
    });
    return fact;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIScreen *screen = [UIScreen mainScreen];
        CGFloat width  = screen.bounds.size.width;
        CGFloat height = screen.bounds.size.height;
        
        _scale = screen.scale;
        _theWidth = width * [UIScreen mainScreen].scale;
        _theHeight = height * [UIScreen mainScreen].scale;
    }
    return self;
}

#pragma mark - private

- (BOOL)vmreadData:(void *)buf address:(long)address length:(long)length
{
    vm_size_t size = 0;
    kern_return_t error = vm_read_overwrite(mach_task_self(), (vm_address_t)address, length, (vm_address_t)buf, &size);
    if(error != KERN_SUCCESS || size != length){
        return NO;
    }
    return YES;
}

- (Vector)word2Screen:(Vector)vector matrix:(float *)matrix
{
    struct Vector outVec = {3100,3100};
    
    float viewW = matrix[3] * vector.X + matrix[7] * vector.Y + matrix[11] * vector.Z + matrix[15];
    if (viewW < 0.01) {
        return outVec;
    }
    
    float x = _theWidth + (matrix[0]*vector.X + matrix[4]*vector.Y + matrix[8]*vector.Z + matrix[12]) / viewW * _theWidth;
    float y = _theHeight  - (matrix[1]*vector.X + matrix[5]*vector.Y + matrix[9]*vector.Z + matrix[13]) / viewW * _theHeight;
    
    outVec.X = x/2;
    outVec.Y = y/2;
    
    return outVec;
}

#pragma mark - public


- (void)fetchData:(JHCJDrawDataFactoryFetchDataBlock)block
{
    
    
    // 获取基址
    long mh_addr = (long)_dyld_get_image_header(0);
    long GWorld = *(long*)(mh_addr + 0x0876AEC0);
    if(!GWorld) {       return;   }
    long PLevel = *(long*)(GWorld + 0x30);
    if(!PLevel) {        return;    }
    int max = *(int*)(PLevel + 0xAC);
    int count = *(int*)(PLevel + 0xA8);
    long Actors = *(long*)(PLevel + 0xA0);
    if(!(Actors && count > 0 && count < max)) {        return;   }
    long ziji = *(long*)(PLevel + 0xB0);
    if(!ziji) {        return;    }
    ziji = *(long*)(ziji + 0x48);
    if(!ziji) {        return;    }
    Vector myzb = {0};
    if(ziji){        [self vmreadData:&myzb address:ziji + 0x1F08 length:12];
        
    }
    
    if(!ziji) {        return;    }
    //矩阵数据
    long juzhen = *(long*)(mh_addr + 0x8522000+0xB8);//
    if(!juzhen) {        return;    }
    long juzhen2 = *(long*)(juzhen+0x98);
    if(!juzhen2) {       return;    }
    float* yxjz = (float*)(juzhen2+0x750);
    [self vmreadData:juzhenshuju address:(long)yxjz length:16*4];
    //复制数组
    NSMutableArray *data = @[].mutableCopy;
    NSMutableArray *hpData = @[].mutableCopy;
    NSMutableArray *disData = @[].mutableCopy;
    
    for (int i = 0; i < count; i++) {
        
        long man = ((long*)Actors)[i];
        
        if(!man || man == ziji) {            continue;   }
        
        Vector zb = {0};
        [self vmreadData:&zb address:(man + 0x1F08) length:12];
        
        //血量
        float xue = 0;
        [self vmreadData:&xue address:(man + 0xBC0) length:4];
        
        // 距离
        CGFloat distX = (zb.X - myzb.X) / 100;
        CGFloat distY = (zb.Y - myzb.Y) / 100;
        CGFloat distance = (distX * distX) + (distY * distY);
        CGFloat distZ = (zb.Z - myzb.Z)/100;
        distance = sqrt((distZ * distZ) + distance);
        
        if(distance > 0 && distance <= 400 && xue>0 &&xue <= 100) {
            
            Vector zb1 = zb;
            zb1.Z += 80;
            
            Vector zb2 = zb;
            zb2.Z -= 80;
            
            Vector fkzb1 = [self word2Screen:zb1 matrix:yxjz];
            Vector fkzb2 = [self word2Screen:zb2 matrix:yxjz];
            
            float height = fkzb2.Y - fkzb1.Y;
            float width  = height / 2;
            
            float originX = fkzb1.X - width / 2;
            float originY = fkzb1.Y;
            
            // 方框
            CGRect rect = CGRectMake(originX/_scale, originY/_scale, width/_scale, height/_scale);
            CGFloat w = rect.size.width;
            CGFloat h = rect.size.height;
            // 血条
            CGFloat hpY = xue * w / 50;
            CGFloat hpX = xue * h / 100;
            
            
            [data addObject:[NSValue valueWithCGRect:rect]];
            [hpData addObject:@(xue)];
            [disData addObject:@(distance)];
        }
    }
    
    if (block) {
        block(data, hpData, disData);
    }
}

@end
