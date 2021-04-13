

#import <Foundation/Foundation.h>

@interface SessionConfiguration : NSObject

@property (nonatomic,assign) BOOL isSwizzle;

+ (SessionConfiguration *)defaultConfiguration;
- (void)load;//加载
- (void)unload;//不加载

@end
