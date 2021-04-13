// 十三哥 QQ350722326
//官网 https://iosgods.cn

#import <Foundation/Foundation.h>

@interface NSString (Base64Addition)
+(NSString *)__attribute__((optnone))stringFromBase64String:(NSString *)base64String;
+(NSString *)__attribute__((optnone))stringFromBase64UrlEncodedString:(NSString *)base64UrlEncodedString;
-(NSString *)__attribute__((optnone))base64String;
-(NSString *)__attribute__((optnone))base64UrlEncodedString;
@end

@interface NSData (Base64Addition)
+(NSData *)__attribute__((optnone))dataWithBase64String:(NSString *)base64String;
+(NSData *)__attribute__((optnone))dataWithBase64UrlEncodedString:(NSString *)base64UrlEncodedString;
-(NSString *)__attribute__((optnone))base64String;
-(NSString *)__attribute__((optnone))base64UrlEncodedString;
@end

@interface MF_Base64Codec : NSObject 
+(NSData *)__attribute__((optnone))dataFromBase64String:(NSString *)base64String;
+(NSString *)__attribute__((optnone))base64StringFromData:(NSData *)data;
+(NSString *)__attribute__((optnone))base64UrlEncodedStringFromBase64String:(NSString *)base64String;
+(NSString *)__attribute__((optnone))base64StringFromBase64UrlEncodedString:(NSString *)base64UrlEncodedString;
@end
