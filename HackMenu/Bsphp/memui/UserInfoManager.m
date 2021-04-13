// 十三哥 QQ350722326
//官网 https://iosgods.cn

#import "UserInfoManager.h"
static UserInfoManager *manager = nil;
@implementation UserInfoManager
+ (UserInfoManager *)__attribute__((optnone))shareUserInfoManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserInfoManager alloc]init];
    });
    return manager;
}
@end
