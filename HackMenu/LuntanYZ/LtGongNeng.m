#import <WebKit/WebKit.h>
#import "LtShengMing.h"
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import "SCLAlertView.h"
#import "LtShengMing.h"
/*
 首页>（登陆/注册）>普通>(购买)>尊敬的>>>>>>>>>>>>>
 */
//构建功能详细代码
//匹配关键词

static NSString *MUFENGKEY  =   @"MUFENG";
@interface JD : UIViewController<WKNavigationDelegate>
@end
@implementation JD
static JD *jd = nil;
+ (JD *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (jd == nil) {
            jd = [[self alloc] init];
        }
    });
    return jd;
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    @autoreleasepool {
        
        
        NSString *doc = @"document.body.outerHTML";
        [webView evaluateJavaScript:doc
                  completionHandler:^(id _Nullable htmlStr, NSError * _Nullable error)
        {
                      if (error)
                      {
                          NSLog(@"JSError:%@",error);
                      }
                      NSLog(@"html加载完成正在匹配~~~~~~");
            if ([(NSString *)htmlStr containsString:@"欢迎注册登陆"])
            {
                [webView removeFromSuperview];
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert addTimerToButtonIndex:0 reverse:YES];
                [alert addButton:@"登陆" actionBlock:^{
                    
                    [NSObject denglu];
                    
                }];
                [alert addButton:@"注册" actionBlock:^{
                    
                    [NSObject zhuche];
                    
                }];
                [alert showWaiting:@"登陆提示" subTitle:@"您没登入\n请先/注册/登陆\n购买VIP即可" closeButtonTitle:nil duration:4];
            }
            
            if ([(NSString *)htmlStr containsString:@"状态普通"])
            {
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert addTimerToButtonIndex:0 reverse:YES];
                [webView removeFromSuperview];
                
                NSRange name1 = [htmlStr rangeOfString:@"66166"];
                NSRange name2 = [htmlStr rangeOfString:@"99199"];
                NSRange name = NSMakeRange(name1.location + name1.length, name2.location - name1.location - name1.length);
                NSString *member = [htmlStr substringWithRange:name];
                [alert addButton:@"购买VIP会员"  actionBlock:^{
                    [NSObject goumai];
                }];
                [alert addButton:@"退出游戏"  actionBlock:^{
                    exit(0);
                }];
                                                            
                                                        
                [alert showInfo:member subTitle:@"您不是VIP用请先购买" closeButtonTitle:nil duration:10];
            }
            if ([(NSString *)htmlStr containsString:htmlStr])//设备检查
            {
               if ([htmlStr containsString:@"本机"]) {
                    if ([htmlStr containsString:@"其他设备"])
                    {
                        SCLAlertView *alert =[[SCLAlertView alloc] initWithNewWindow];
                        [alert addTimerToButtonIndex:0 reverse:YES];
                        
                        [alert showWarning:nil title:@"登陆设备过多" subTitle:@"请往下翻动\n除本机外 其他设备退出\n登陆太多设备禁封论坛VIP后果自负" closeButtonTitle:@"知道" duration:5];
                        NSLog(@"提示设备多提示退出方法");
                        NSLog(@"关闭定时器");
                    }
                    else {
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [NSObject huoqukey];
                        });
                        [webView removeFromSuperview];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            NSLog(@"启动定时器111");
                            
                        });
                         
                    }
                    
                }
                
            }
            
            if ([(NSString *)htmlStr containsString:@"尊敬的VIP用户"])
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [NSObject huoqukey];
                });
                
                
                NSLog(@"匹配到尊敬的VIP~~~~~~~~·");
                [webView removeFromSuperview];
                NSLog(@"启动定时器2222");
                
            }
            
            
        }] ;


    }
}

/**清除缓存和cookie*/
- (void)cleanCacheAndCookie{
    
    //清除cookies
    
    NSHTTPCookie *cookie;
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (cookie in [storage cookies]){
        
        [storage deleteCookie:cookie];
        
    }
    
    //清除UIWebView的缓存
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSURLCache * cache = [NSURLCache sharedURLCache];
    
    [cache removeAllCachedResponses];
    
    [cache setDiskCapacity:0];
    
    [cache setMemoryCapacity:0];
    
}
@end

@implementation NSObject (hook)
- (BOOL)shouye//1
{
    @autoreleasepool {
        
         UIWindow    *window =   [[UIApplication sharedApplication] keyWindow];
         WKWebView   *webView    =   [[WKWebView alloc] initWithFrame:window.bounds];
         webView.navigationDelegate  =   [JD sharedInstance];
        
         [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://iosgods.cn/"]]];
         [window addSubview:webView];
         return 0;

    }
}
- (BOOL)denglu//2
{
    @autoreleasepool {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
               UIWindow    *window =   [[UIApplication sharedApplication] keyWindow];
               WKWebView   *webView    =   [[WKWebView alloc] initWithFrame:window.bounds];
               webView.navigationDelegate  =   [JD sharedInstance];
              
               [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://iosgods.cn/index.php?/login/"]]];
               [window addSubview:webView];
               
               
               
           });
          
        return 0;
    }
    
}
- (BOOL)zhuche//3
{
    @autoreleasepool {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
               UIWindow    *window =   [[UIApplication sharedApplication] keyWindow];
               WKWebView   *webView    =   [[WKWebView alloc] initWithFrame:window.bounds];
               webView.navigationDelegate  =   [JD sharedInstance];
              
               [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://iosgods.cn/index.php?/register/"]]];
               [window addSubview:webView];
           });
        return 0;
    }
}
- (BOOL)goumai//4
{
    @autoreleasepool {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
               UIWindow    *window =   [[UIApplication sharedApplication] keyWindow];
               WKWebView   *webView    =   [[WKWebView alloc] initWithFrame:window.bounds];
               webView.navigationDelegate  =   [JD sharedInstance];
              
               [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://iosgods.cn/index.php?/clients/credit/"]]];
               [window addSubview:webView];
           });
        return 0;
    }
}
-(BOOL)huoqukey//5
{  NSLog(@"22222");
    @autoreleasepool {
        NSURL *mysqlurl=[NSURL URLWithString:@"https://iosgods.cn/"];
        //创建请求命令
        NSURLRequest *request=[NSURLRequest requestWithURL:mysqlurl];
        //创建会话对象 通过单例方法实现
        NSURLSession *session=[NSURLSession sharedSession];
        //执行会话的任务，通过request请求 获取data对象
        NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
            NSLog(@"加载33333333");
           
            if(error == nil && data != nil){
                
                NSLog(@"欢迎来到旭宝爱吃鱼的博客");
                //获得队列
                //设置时间间隔
                static dispatch_source_t _timer;
                NSTimeInterval period = 5.f;
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
                dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0);
                dispatch_source_set_event_handler(_timer, ^{
                NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
               
                NSRange name1 = [html rangeOfString:@"我日"];
                NSRange name2 = [html rangeOfString:@"你妈"];
                NSRange name = NSMakeRange(name1.location + name1.length, name2.location - name1.location - name1.length);
                NSString *member = [html substringWithRange:name];
                NSLog(@"打印出用ID啦：    %@",member);
                NSString *url = @"https://iosgods.cn/html/index.php?member_id=";
                NSLog(@"打印拼接后的URL：    %@%@",url,member);
                NSString * mysql = [url stringByAppendingString:member];
                NSURL *usidurl=[NSURL URLWithString:mysql];
                //创建请求命令
                NSURLRequest *request=[NSURLRequest requestWithURL:usidurl];
                //创建会话对象 通过单例方法实现
                NSURLSession *session=[NSURLSession sharedSession];
                NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                            {
                    if(error == nil && data != nil){
                        NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                        NSLog(@"这是设备ID🆚：%@",html);
                        NSLog(@"%@", [NSThread currentThread]);
                        if ((html.length)>50) {
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                                [alert addTimerToButtonIndex:0 reverse:YES];
                                [alert addButton:@"退出其他设备" actionBlock:^{
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        [NSObject shebei];
                                       
                                        NSLog(@"大于50被迫下线");
                                        dispatch_source_cancel(_timer);
                                    });
                                    
                                }];
                                [alert showSuccess:@"被迫下线" subTitle:@"您的账号在其地方登入" closeButtonTitle:nil duration:5];
                            });
                            
                        }
                        if ((html.length)<50 && 20<(html.length)){
                            NSLog(@"小于50不提示正常玩");
                            return;
                        }
                    }else{
                        NSLog(@"%@",error);
                    }
                }];
                [task resume];
                });
                // 开启定时器
                dispatch_resume(_timer);
                
            }
            
            else
            {
                NSLog(@"加载5555555");
                return;
                
            }
        }];
            [task resume];
        
    }
    return 0;
}

- (BOOL)shebei//6
{
    @autoreleasepool {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
               UIWindow    *window =   [[UIApplication sharedApplication] keyWindow];
               WKWebView   *webView    =   [[WKWebView alloc] initWithFrame:window.bounds];
               webView.navigationDelegate  =   [JD sharedInstance];
              
               [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://iosgods.cn/index.php?/settings/devices"]]];
               [window addSubview:webView];
             });
        return 0;
    }
}
- (BOOL)jzdtk {
    NSString* bundlefile = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/FrameWorkOne.framework"];
         NSBundle *frameworkBundle = [NSBundle bundleWithPath:bundlefile];
        if (frameworkBundle && [frameworkBundle load]) {
            NSLog(@"bundle load framework success.");
        }else {
            NSLog(@"bundle load framework err");

            
        }
        
        Class pacteraClass = NSClassFromString(@"TestView");
        if (!pacteraClass) {
            NSLog(@"Unable to get TestDylib class");

            
        }
        
        [frameworkBundle unload];

}

@end
