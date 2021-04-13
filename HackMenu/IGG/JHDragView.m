
#import "JHDragView.h"

@implementation JHDragView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (CGRectGetWidth(frame) <= 0 ||
        CGRectGetHeight(frame) <= 0) {
        frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 130, 30, 30);
        //CGFloat width = MAX([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
        //frame = CGRectMake(width-70, 120, 65, 65);
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        //self.layer.borderColor = [UIColor colorWithRed: 0.50 green: 0.72 blue: 0.05 alpha: 0.50];
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
        //self.layer.borderWidth = 0.95f;
       self.backgroundColor=  [UIColor colorWithRed: 0.00 green: 0.00 blue: 0.00 alpha: 0.20];
        
        
        //self.backgroundColor = [UIColor blackColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = CGRectGetWidth(self.bounds) / 2;
        self.alpha = 50.0f;
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://iosgods.cn/uploads/monthly_2021_01/no.png.13301dba752dc89d1151a92030f5d49b.png"]];
            UIImage *decodedImage = [UIImage imageWithData:imageData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.layer.contents = (id)decodedImage.CGImage;
            });
        });
    }
    return self;
}

#pragma mark - override

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    self.center = point;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self shouldResetFrame];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self shouldResetFrame];
}

#pragma mark - private

- (void)shouldResetFrame
{
    CGFloat midX = CGRectGetWidth(self.superview.frame)*0.5;
    CGFloat midY = CGRectGetHeight(self.superview.frame)*0.5;
    CGFloat maxX = midX*2;
    CGFloat maxY = midY*2;
    CGRect frame = self.frame;

    if (CGRectGetMinX(frame) < 0 ||
        CGRectGetMidX(frame) <= midX) {
        frame.origin.x = 0;
    }else if (CGRectGetMidX(frame) > midX ||
              CGRectGetMaxX(frame) > maxX) {
        frame.origin.x = maxX - CGRectGetWidth(frame);
    }

    if (CGRectGetMinY(frame) < 0) {
        frame.origin.y = 0;
    }else if (CGRectGetMaxY(frame) > maxY) {
        frame.origin.y = maxY - CGRectGetHeight(frame);
    }

    [UIView animateWithDuration:0.25 animations:^{
        //CGFloat width = MAX([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
        //self.frame = CGRectMake(width-70, 100, 65, 65);
        //self.frame = frame;
    }];
}


@end
