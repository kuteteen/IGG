//
//  JHCJDrawView.h
//  JHCJDraw
//
//  Created by 佚名 on 2021/1/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HZKG : UIView

+ (instancetype)cjDrawView;
+ (void)kaiguanToushis: (UISwitch*) zhuangtai ;
- (void)clear;
- (void)show;
- (void)hide;
- (void)configWithData:(NSArray *)rects hpData:(NSArray *)hpData disData:(NSArray *)disData;

@end


NS_ASSUME_NONNULL_END
