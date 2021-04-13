#import "ESPView.h"
#import "ESP.h"
#import <CoreText/CoreText.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIAlertView.h>
#import "SCLAlertView.h"



#define kTest   0
#define g 0.86602540378444
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@interface HZKG()
@property (nonatomic,  strong) UILabel *numberLabel;
@property (nonatomic,  strong) CAShapeLayer *drawLayer;
@property (nonatomic,  strong) CAShapeLayer *hpLayer;
@property (nonatomic,  strong) CAShapeLayer *wjLayer;

@property (nonatomic) CATextLayer * textLayer;
@property (nonatomic,  strong) NSArray *rects;
@property (nonatomic,  strong) NSArray *hpData;
@property (nonatomic,  strong) NSArray *disData;
@property (nonatomic,  weak) NSTimer *timer;
@end
static CATextLayer *tsLabel[100];
static CAShapeLayer *drawLayer[100];
NSMutableDictionary *newActions;
static UIBezierPath *Path[100];
CGRect rect ;
CGFloat xue;
CGFloat dis ;
UIButton *closeButton;
UIView *menuView;

@implementation HZKG
BOOL kaiguan=NO;
BOOL kaiguan1=NO;
BOOL kaiguan3=NO;
BOOL kaiguan2=NO;
BOOL kaiguan4=NO;
#pragma mark -------------------------------------视图-------------------------------------------

+ (void)load11
{

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //SW1
        UISwitch*_swit = [[UISwitch alloc] init];
        
        _swit.frame = CGRectMake(10, 20, 20, 20);
        _swit.thumbTintColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
        _swit.transform = CGAffineTransformMakeScale(0.75,0.75);
        [_swit addTarget:self action:@selector(ts:) forControlEvents:UIControlEventValueChanged];
        [[[[UIApplication sharedApplication] windows]lastObject] addSubview:_swit];
        
        //UILabel 1
        UILabel* AL1 = [[UILabel alloc] initWithFrame:CGRectMake(20, -10, 60, 40)];
        [AL1 setText:@"距离"];
        [AL1 setTextColor:[UIColor redColor]];
        [AL1 setBackgroundColor:[UIColor clearColor]];
        AL1.font = [UIFont systemFontOfSize:9];
        [[[[UIApplication sharedApplication] windows]lastObject] addSubview:AL1];
        HZKG *view = [HZKG cjDrawView];
        [view show];
        [[[[UIApplication sharedApplication]windows]lastObject]addSubview:view];
        //SW2
        UISwitch*_swit1 = [[UISwitch alloc] init];
        _swit1.frame = CGRectMake(10, 70, 20, 20);
        _swit1.thumbTintColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
        _swit1.transform = CGAffineTransformMakeScale(0.75,0.75);
        [_swit1 addTarget:self action:@selector(ts1:) forControlEvents:UIControlEventValueChanged];
        [[[[UIApplication sharedApplication] windows]lastObject] addSubview:_swit1];
        //UILabel 2
        UILabel* AL2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 60, 40)];
        [AL2 setText:@"方框"];
        [AL2 setTextColor:[UIColor redColor]];
        [AL2 setBackgroundColor:[UIColor clearColor]];
        AL2.font = [UIFont systemFontOfSize:9];
        [[[[UIApplication sharedApplication] windows]lastObject] addSubview:AL2];
        HZKG *view2 = [HZKG cjDrawView];
        [view2 show];
        [[[[UIApplication sharedApplication]windows]lastObject]addSubview:view2];
        //SW3
        UISwitch* _swit2 = [[UISwitch alloc] initWithFrame:CGRectMake(10, 120, 20, 20)];
        _swit2.thumbTintColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
        _swit2.transform = CGAffineTransformMakeScale(0.75,0.75);
        [_swit2 addTarget:self action:@selector(ts2:) forControlEvents:UIControlEventValueChanged];
        [[[[UIApplication sharedApplication] windows]lastObject] addSubview:_swit2];
        
        //AL3
        UILabel* AL3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 60, 40)];
        [AL3 setText:@"射线"];
        [AL3 setTextColor:[UIColor redColor]];
        [AL3 setBackgroundColor:[UIColor clearColor]];
        AL3.font = [UIFont systemFontOfSize:9];
        [[[[UIApplication sharedApplication] windows]lastObject] addSubview:AL3];
        HZKG *view3 = [HZKG cjDrawView];
        [view3 show];
        [[[[UIApplication sharedApplication]windows]lastObject]addSubview:view3];
        
        //SW4
        
        UISwitch*_swit3 = [[UISwitch alloc] init];
        
        _swit3.frame = CGRectMake(10, 170, 20, 20);
        _swit3.thumbTintColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
        _swit3.transform = CGAffineTransformMakeScale(0.75,0.75);
        [_swit3 addTarget:self action:@selector(ts3:) forControlEvents:UIControlEventValueChanged];
        [[[[UIApplication sharedApplication] windows]lastObject] addSubview:_swit3];
        //AL4
        UILabel* AL4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 60, 40)];
        [AL4 setText:@"血量"];
        [AL4 setTextColor:[UIColor redColor]];
        [AL4 setBackgroundColor:[UIColor clearColor]];
        AL4.font = [UIFont systemFontOfSize:9];
        [[[[UIApplication sharedApplication] windows]lastObject] addSubview:AL4];
        HZKG *view4 = [HZKG cjDrawView];
        [view4 show];
        [[[[UIApplication sharedApplication]windows]lastObject]addSubview:view4];
        
        UISwitch*_swit4 = [[UISwitch alloc] init];
        
        _swit4.frame = CGRectMake(10, 220, 20, 20);
        _swit4.thumbTintColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
        _swit4.transform = CGAffineTransformMakeScale(0.75,0.75);
        [_swit4 addTarget:self action:@selector(ts4:) forControlEvents:UIControlEventValueChanged];
        [[[[UIApplication sharedApplication] windows]lastObject] addSubview:_swit4];
        
        UILabel* AL5 = [[UILabel alloc] initWithFrame:CGRectMake(20, 190, 60, 40)];
        [AL5 setText:@"人数"];
        [AL5 setTextColor:[UIColor redColor]];
        [AL5 setBackgroundColor:[UIColor clearColor]];
        AL5.font = [UIFont systemFontOfSize:9];
        [[[[UIApplication sharedApplication] windows]lastObject] addSubview:AL5];
        HZKG *view5 = [HZKG cjDrawView];
        [view5 show];
        [[[[UIApplication sharedApplication]windows]lastObject]addSubview:view5];
        for(NSInteger i = 0; i < 100; i++){
            newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"position", [NSNull null], @"bounds", nil];
            
            
            tsLabel[i] = [CATextLayer layer];
            tsLabel[i].actions = newActions;
            tsLabel[i].string = @"";
            tsLabel[i].bounds = CGRectMake(0, 0, 160, 30);
            tsLabel[i].fontSize = 9;//字体的大小
            tsLabel[i].wrapped = YES;//默认为No.  当Yes时，字符串自动适应layer的bounds大小
            tsLabel[i].alignmentMode = kCAAlignmentCenter;//字体的对齐方式
            tsLabel[i].position = CGPointMake(-100, -100);//layer在view的位置 适用于跟随摸一个不固定长的的控件后面需要的
            tsLabel[i].contentsScale = [UIScreen mainScreen].scale;//解决文字模糊
            tsLabel[i].foregroundColor =[UIColor colorWithRed: 1 green: 1 blue: 0 alpha: 1].CGColor;//字体的颜色
            [[[[UIApplication sharedApplication] windows]lastObject].layer addSublayer:tsLabel[i]];
        }
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert addTimerToButtonIndex:0 reverse:YES];
        alert.horizontalButtons = YES;
        // 拒绝按钮
        [alert addButton:@"退出游戏" actionBlock:^{
            exit(0);
        }];
           
        // 下载按钮
        [alert addButton:@"访问官网" actionBlock:^{
            //
            NSString *urlStr = [NSString stringWithFormat:@"https://iosgods.cn"];[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
            exit(0);
        }];
        [alert showSuccess:@"iOsGoDsCn" subTitle:@"请挂专用防封代理使用否则封号" closeButtonTitle:@"确定" duration:5.0f];
        
        });

}




+ (void)ts: (UISwitch*) zhuangtai {
    if(zhuangtai.isOn) {
        kaiguan = YES;
    } else {
        kaiguan = NO;
    }
}
+ (void)ts1: (UISwitch*) zhuangtai1 {
    if(zhuangtai1.isOn) {
        kaiguan1 = YES;
    } else {
        kaiguan1 = NO;
    }
}
+ (void)ts2: (UISwitch*) zhuangtai2 {
    if(zhuangtai2.isOn) {
        kaiguan2 = YES;
    } else {
        kaiguan2 = NO;
    }
}
+ (void)ts3: (UISwitch*) zhuangtai3 {
    if(zhuangtai3.isOn) {
        kaiguan3 = YES;
    } else {
        kaiguan3 = NO;
    }
}
+ (void)ts4: (UISwitch*) zhuangtai4 {
    if(zhuangtai4.isOn) {
        kaiguan4 = YES;
    } else {
        kaiguan4 = NO;
    }
}
- (void)closeMenu {    menuView.hidden = YES; }
+ (instancetype)cjDrawView
{
    return [[HZKG alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        [self.layer addSublayer:self.drawLayer];
        [self.layer addSublayer:self.hpLayer];
        [self.layer addSublayer:self.wjLayer];
        [self addSubview:self.numberLabel];
        for(NSInteger i = 0; i < 100; i++){
            
            drawLayer[i] = [CAShapeLayer layer];
            drawLayer[i].frame = self.bounds;
            drawLayer[i].fillColor = [UIColor clearColor].CGColor;
            
            [self.layer addSublayer:drawLayer[i]];
        }
        
    }
    return self;
}

#pragma mark -------------------------------------事件-------------------------------------------

- (void)dealloc
{
    NSLog(@"--%s--", __func__);
}


- (void)clear{
    
    for (NSInteger i = 0; i < 100; i++) {
        
        
        
        tsLabel[i].string = @"";
        drawLayer[i].strokeColor =  [UIColor clearColor].CGColor;
        
    }
}

- (void)show
{
    self.hidden = NO;
    self.timer.fireDate = [NSDate distantPast];
}

- (void)hide
{
    self.hidden = YES;
    self.timer.fireDate = [NSDate distantFuture];
}

- (void)configWithData:(NSArray *)rects hpData:(NSArray *)hpData disData:(NSArray *)disData
{
    _rects = rects;
    _hpData = hpData;
    _disData = disData;
    if(kaiguan4 == YES){
        _numberLabel.text =  [ NSString stringWithFormat:@"⚠️%d  600m内有个憨批玩家" ,(int)(_rects.count)]; }
    else{_numberLabel.text =@"";}
    

    
    [self clear];
    [self drawAction];
}

- (void)drawAction
{

    
    UIBezierPath *path = [UIBezierPath bezierPath];
    UIBezierPath *hpPath = [UIBezierPath bezierPath];
    UIBezierPath *wjPath = [UIBezierPath bezierPath];
    float wanjia =0;
    
    for (NSInteger i = 0; i < _rects.count; i++) {
        
        Path[i] = [UIBezierPath bezierPath];
        
        NSValue *val0  = _rects[i];
        NSNumber *val1 = _hpData[i];
        NSNumber *val2 = _disData[i];
        
        rect = [val0 CGRectValue];
        xue = [val1 floatValue];
        dis = [val2 floatValue];
        float xd = rect.origin.x+rect.size.width/2;//人物X坐标
        float yd = rect.origin.y;//人物Y坐标
        
        if (kaiguan == YES){
        //玩家框+距离
        wanjia+=1;
        tsLabel[i] .string = [NSString stringWithFormat:@"[%.2fm]",dis];
        tsLabel[i] .position = CGPointMake(xd, yd);
        CGRect wjRect = CGRectMake(xd-0, yd-0, 0, 0);
        UIBezierPath *wjBz = [UIBezierPath bezierPathWithRect:wjRect];
        [wjPath appendPath:wjBz];
        }
        if (kaiguan1 == YES){
        //方框
        UIBezierPath *sub = [UIBezierPath bezierPathWithRect:rect];
        [path appendPath:sub];
        }
        // 射线
        if (kaiguan2 == YES){
        UIBezierPath *line = [UIBezierPath bezierPath];
        [line moveToPoint:CGPointMake(kWidth*0.5, 45)];
        [line addLineToPoint:CGPointMake(xd, yd-18)];
        [path appendPath:line];
        }
        if (kaiguan3 == YES){
        // 血量
        CGRect hpRect = CGRectMake(xd-30, yd-19, xue/2+10, 2);
        UIBezierPath *hpBz = [UIBezierPath bezierPathWithRect:hpRect];
        [hpPath appendPath:hpBz];
        }

        
        
    }
    
    self.drawLayer.path = path.CGPath;
    self.hpLayer.path = hpPath.CGPath;
    self.wjLayer.path = wjPath.CGPath;
}


- (void)doTheJob
{
    NSLog(@"*** doTheJob");
    [[HZ factory] fetchData:^(NSArray * _Nonnull data, NSArray * _Nonnull hpData, NSArray * _Nonnull disData) {
        [self configWithData:data hpData:hpData disData:disData];
    }];
}

#pragma mark -------------------------------------懒加载-----------------------------------------

//人数
- (UILabel *)numberLabel{
    if (!_numberLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(kWidth*0.5-80, 40, 200, 30);
        label.text = @"ESP By Qi";
        label.textColor = [UIColor colorWithRed: 0.86 green: 0.24 blue: 0.00 alpha: 1.00];
        label.font = [UIFont boldSystemFontOfSize:20];
        label.textAlignment = 1;
        
        _numberLabel = label;
    }
    return _numberLabel;
}



//射线
- (CAShapeLayer *)drawLayer{
    if (!_drawLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        if (dis <=100){
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
        }
        if (dis >150){
            shapeLayer.strokeColor = [UIColor greenColor].CGColor;
        }

        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _drawLayer = shapeLayer;
    }
    return _drawLayer;
}

//血量
- (CAShapeLayer *)hpLayer{
    if (!_hpLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        shapeLayer.fillColor = [UIColor redColor].CGColor;
        _hpLayer = shapeLayer;
    }
    return _hpLayer;
}

//方框



//玩家框
- (CAShapeLayer *)wjLayer{
    if (!_wjLayer) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.frame = self.bounds;
        shapeLayer.strokeColor = [UIColor colorWithRed: 0.99 green: 0.80 blue: 0.00 alpha: 1.00].CGColor;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _wjLayer = shapeLayer;
    }
    return _wjLayer;
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self doTheJob];
        }];
    }
    return _timer;
}

@end
