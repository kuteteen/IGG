

#import <Foundation/Foundation.h>

@interface URLProtocol : NSURLProtocol

/// 开始监听
+ (void)startMonitor;

/// 停止监听
+ (void)stopMonitor;

@end
