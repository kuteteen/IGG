//
//  AESUtility.h
//  qq
//
//  Created by Yi on 2018/7/15.
//

#import <Foundation/Foundation.h>

@interface AESUtility : NSObject

+ (NSString *)EncryptString:(NSString *)sourceStr;

+ (NSString *)DecryptString:(NSString *)secretStr;

@end
