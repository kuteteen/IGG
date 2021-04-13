#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^JHCJDrawDataFactoryFetchDataBlock)(NSArray *data, NSArray *hpData, NSArray *disData);

@interface HZ : NSObject

+ (instancetype)factory;

- (void)fetchData:(JHCJDrawDataFactoryFetchDataBlock)block;

@end

NS_ASSUME_NONNULL_END
