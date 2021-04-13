// 十三哥 QQ350722326
//官网 https://iosgods.cn
//
#import <Foundation/Foundation.h>
@interface DES3Utill : NSObject {
}
// 加密方法
+ (NSString*)__attribute__((optnone))encrypt:(NSString*)plainText gkey:(NSString *)gkey;
// 解密方法
+ (NSString*)__attribute__((optnone))decrypt:(NSString*)encryptText gkey:(NSString *)gkey;

@end

#import <Foundation/Foundation.h>

//@interface DES3Utill : NSObject

//@end
