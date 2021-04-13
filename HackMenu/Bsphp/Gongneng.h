//
//  NSObject.h
//  Toushibtn
//
//  Created by xuy_VM on 2019/4/5.
//  Copyright © 2019 xuy_VM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Metal/Metal.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (hook)
- (BOOL)VPNtishitiao;//代理提示检测条
- (BOOL)VPNzhijiesantui;//代理直接闪退不提示
- (BOOL)Banben321;//版本检测
- (BOOL)Bsphp;//版本检测

@end
@interface DLGMemEntry : NSObject

@end
@interface VerifyEntry : NSObject

+ (instancetype)MySharedInstance;

- (NSString*)getIDFA;

- (void)showAlertMsg:(NSString *)show error:(BOOL)error;


@end

NS_ASSUME_NONNULL_END
