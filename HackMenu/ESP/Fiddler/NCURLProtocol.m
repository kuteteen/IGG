//奶茶

#import "NCURLProtocol.h"
#import "NCSessionConfiguration.h"
//定义拦截网址
static NSString *const old1 = @"http://cs.mbgame.gamesafe.qq.com";
static NSString *const new1 = @"*bpu";
static NSString *const old2 = @"EXACT:http://access1.tpns.sh.tencent.com:1883";
static NSString *const new2 = @"*bpu";
static NSString *const old3 = @"EXACT:https://down.anticheatexpert.com/iedsafe/Client/ios/2131/config2.xml";
static NSString *const new3 =@"*redir:https://down.anticheatexpert.com/iedsafe/Client/ios/2131/config2.xml";
static NSString *const old4 =@"EXACT:https://down.anticheatexpert.com/iedsafe/Client/ios/2131/config3.xml";
static NSString *const new4 = @"*redir:https://down.anticheatexpert.com/iedsafe/Client/ios/2131/config3.xml";
static NSString *const old5 = @"https://down.pandora.qq.com/";
static NSString *const new5 = @"*bpu";
static NSString *const old6 = @"https://down.anticheatexpert.com/iedsafe/Client/ios/2131/0AEE5282/comm.dat";
static NSString *const new6 = @"*bpu";
static NSString *const old7 = @"https://down.anticheatexpert.com/iedsafe/Client/ios/2131/1C8710C6/tssmua.zip";
static NSString *const new7 = @"*bpu";
static NSString *const old8 = @"https://down.anticheatexpert.com/iedsafe/Client/ios/2131/1EEE921C/mrpcs.data";
static NSString *const new8 = @"*bpu";
static NSString *const old9 = @"wetest.qq.com/";
static NSString *const new9 = @"*bpu";
static NSString *const old10 = @"https://app.xkkgame.top/";
static NSString *const new10 = @"*redir:https://app.xkkgame.top/";
static NSString *const old11 = @"https://api.unipay.qq.com/";
static NSString *const new11 = @"*bpu";
static NSString *const old12 = @"https://appsupport.qq.com/";
static NSString *const new12 = @"*bpu";
static NSString *const old13 = @"https://boce.tgpa.qq.com/getip";
static NSString *const new13 = @"*bpu";
static NSString *const old14 = @"https://cdn.wetest.qq.com/";
static NSString *const new14 = @"*bpu";
static NSString *const old15 = @"https://cloudctrl.gcloud.qq.com/";
static NSString *const new15 = @"*bpu";
static NSString *const old16 = @"https://gpcloud.tgpa.qq.com/";
static NSString *const new16 = @"*bpu";
static NSString *const old17 = @"https://gchat.qpic.cn/";
static NSString *const new17 = @"*bpu";
static NSString *const old18 = @"https://guid.tpns.sh.tencent.com/";
static NSString *const new18 = @"*bpu";
static NSString *const old19 = @"https://idcconfig.gcloud.qq.com/";
static NSString *const new19 = @"*bpu";
static NSString *const old20 = @"https://ios.bugly.qq.com";
static NSString *const new20 = @"*bpu";
static NSString *const old21 = @"https://img.ssl.msdk.qq.com/notice/";
static NSString *const new21 = @"*bpu";
static NSString *const old22 = @"https://iplocreptest.map.qq.com/";
static NSString *const new22 = @"*bpu";
static NSString *const old23 = @"https://livew.l.qq.com";
static NSString *const new23 = @"*bpu";
static NSString *const old24 = @"https://log.tpns.sh.tencent.com/";
static NSString *const new24 = @"*bpu";
static NSString *const old25 = @"https://nggproxy.3g.qq.com/";
static NSString *const new25 = @"*bpu";
static NSString *const old26 = @"https://pingfore.qq.com";
static NSString *const new26 = @"*bpu";
static NSString *const old27 = @"https://priv.igame.qq.com/";
static NSString *const new27 = @"*bpu";
static NSString *const old28 = @"https://pubgmhdprobe.tgpa.qq.com/";
static NSString *const new28 = @"*bpu";
static NSString *const old29 = @"https://probe.tgpa.qq.com/";
static NSString *const new29 = @"*bpu";
static NSString *const old30 = @"https://szmg.qq.com/";
static NSString *const new30 = @"*bpu";
static NSString *const old31 = @"http://safebrowsing.urlsec.qq.com";
static NSString *const new31 = @"*bpu";
static NSString *const old32 = @"https://stat.tpns.sh.tencent.com/";
static NSString *const new32 = @"*bpu";
static NSString *const old33 = @"https://settings-win.data.microsoft.com/";
static NSString *const new33 = @"*bpu";
static NSString *const old34 = @"https://video.qq.com/";
static NSString *const new34 = @"*bpu";
static NSString *const old35 = @"http://mazu.3g.qq.com";
static NSString *const new35 = @"*bpu";
static NSString *const old36 = @"https://wspeed.qq.com/";
static NSString *const new36 = @"*bpu";
static NSString *const old37 = @"https://hpjy-op.tga.qq.com";
static NSString *const new37 = @"*bpu";
static NSString *const old38 = @"https://harmony.voice.gcloud.qq.com:443/";
static NSString *const new38 = @"*bpu";
static NSString *const old39 = @"https://huatuocode.huatuo.qq.com/";
static NSString *const new39 = @"*bpu";
static NSString *const old40 = @"https://dp3.qq.com/stdlog";
static NSString *const new40 = @"*bpu";
static NSString *const old41 = @"qlogo.cn";
static NSString *const new41 = @"*bpu";
static NSString *const old42 = @"qpic.cn/";
static NSString *const new42 = @"*bpu";
static NSString *const old43 = @"thirdqq.qlogo.cn";
static NSString *const new43 = @"*bpu";
static NSString *const old44 = @"https://thirdwx.qlogo.cn/";
static NSString *const new44 = @"*bpu";

@interface URLProtocol () <NSURLConnectionDelegate,NSURLConnectionDataDelegate, NSURLSessionDelegate>
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) NSOperationQueue     *sessionDelegateQueue;
@property (nonatomic, strong) NSURLResponse        *response;
@end

@implementation URLProtocol

#pragma mark - 开始监听

+ (void)startMonitor
{
    SessionConfiguration *sessionConfiguration = [SessionConfiguration defaultConfiguration];
    [NSURLProtocol registerClass:[URLProtocol class]];
    if (![sessionConfiguration isSwizzle]) {
        [sessionConfiguration load];
    }
}

#pragma mark - 停止监听

+ (void)stopMonitor
{
    SessionConfiguration *sessionConfiguration = [SessionConfiguration defaultConfiguration];
    [NSURLProtocol unregisterClass:[URLProtocol class]];
    if ([sessionConfiguration isSwizzle]) {
        [sessionConfiguration unload];
    }
}

#pragma mark - 是否需要监控 此次请求
//开始拦截请求
+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    // 已经拦截过的请放行，避免出现死循环
    if ([NSURLProtocol propertyForKey:@"URLProtocolHandledKey" inRequest:request] ) {
        return NO;
    }
    
    // 不是 http,https 网络请求，不处理
    if (![request.URL.scheme isEqualToString:@"http"] &&
        ![request.URL.scheme isEqualToString:@"https"]) {
        return NO;
    }
    //判断拦截指定网址
    if ([request.URL.absoluteString containsString:old1]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old2]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old3]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old4]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old5]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old6]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old7]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old8]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old9]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old10]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old11]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old12]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old13]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old14]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old15]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old16]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old17]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old18]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old19]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old20]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old21]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old22]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old23]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old24]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old25]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old26]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old27]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old28]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old29]) {
        return YES;
    } else {
        return NO;
    }

    if ([request.URL.absoluteString containsString:old30]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old31]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old32]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old33]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old34]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old35]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old36]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old37]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old38]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old39]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old40]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old41]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old42]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old43]) {
        return YES;
    } else {
        return NO;
    }
    if ([request.URL.absoluteString containsString:old44]) {
        return YES;
    } else {
        return NO;
    }
        
    // 拦截所有
     return YES;
}

#pragma mark - 设置我们自己的自定义请求-应用的此次请求

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    [NSURLProtocol setProperty:@(YES) forKey:@"URLProtocolHandledKey" inRequest:mutableReqeust]; // 设置已处理标志
    
    //NSLog(@"*** 原请求的 URL : %@",request.URL);
    if ([request.URL host].length == 0)
    {
        return request;
    }

    NSString * originUrlStr = [request.URL absoluteString];
    NSString * originHostStr = [request.URL absoluteString];
    NSRange hostRange = [originUrlStr rangeOfString:originHostStr];
    
    if (hostRange.location == NSNotFound)
    {
        return request;
    }

    // 指定拦截网络请求
    if ([request.URL.absoluteString hasPrefix:old1 ]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new1]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old2 ]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new2]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old3]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new3]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old4]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new4]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old5]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new5]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old6]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new6]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old7]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new7]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old8]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new8]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old9]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new9]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old10]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new10]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old11]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new11]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old12]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new12]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old13]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new13]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old14]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new14]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old15]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new15]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old16]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new16]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old17]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new17]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old18]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new18]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old19]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new19]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old20]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new20]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old21]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new21]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old22]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new22]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old23]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new23]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old24]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new24]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old25]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new25]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old26]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new26]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old27]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new27]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old28]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new28]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old29]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new29]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old30]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new30]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old31]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new31]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old32]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new32]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old33]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new33]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old34]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new34]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old35]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new35]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old36]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new36]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old37]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new37]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old38]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new38]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old39]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new39]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old40]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new40]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old41]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new41]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old42]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new42]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old43]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new43]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    if ([request.URL.absoluteString hasPrefix:old44]) {
        // 重定向
        mutableReqeust.URL = [NSURL URLWithString:[originUrlStr stringByReplacingCharactersInRange:hostRange withString:new44]];
        //NSLog(@"*** 替换后的 URL : %@",mutableReqeust.URL);
        
        return [mutableReqeust copy];
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    else{
        return request;
    }
}

#pragma mark - 重新父类的开始加载方法

- (void)startLoading
{
    //NSLog(@"*** 监听URL接口 : %@", self.request.URL.absoluteString);
    
    NSURLSessionConfiguration *configuration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    
    self.sessionDelegateQueue = [[NSOperationQueue alloc] init];
    self.sessionDelegateQueue.maxConcurrentOperationCount = 1;
    self.sessionDelegateQueue.name = @"com.hujiang.wedjat.session.queue";
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:configuration
                                  delegate:self
                             delegateQueue:self.sessionDelegateQueue];
    
    self.dataTask = [session dataTaskWithRequest:self.request];
    [self.dataTask resume];
}

#pragma mark - 结束加载

- (void)stopLoading
{
    [self.dataTask cancel];
}

#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (!error) {
        [self.client URLProtocolDidFinishLoading:self];
    } else if ([error.domain isEqualToString:NSURLErrorDomain] && error.code == NSURLErrorCancelled) {
    } else {
        [self.client URLProtocol:self didFailWithError:error];
    }
    self.dataTask = nil;
}

#pragma mark - NSURLSessionDataDelegate 当服务端返回信息时，这个回调函数会被ULS调用，在这里实现http返回信息的截

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {

    // 原返回数据
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (dataStr) {
        //NSLog(@"*** 原返回数据 before : %@", dataStr);
    }
    
    // 修改数据
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old1]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old2]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old3]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old4]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old5]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old6]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old7]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old8]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old9]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old10]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old11]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old12]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old13]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old14]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old15]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old16]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old17]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old18]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old19]) {

    }

    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old20]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old21]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old22]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old23]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old24]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old25]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old26]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old27]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old28]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old29]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old30]) {

    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old31]) {
        
    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old32]) {
        
    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old33]) {
        
    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old34]) {
        
    }
    
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old35]) {
        
    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old36]) {
        
    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old37]) {
        
    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old38]) {
        
    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old39]) {
        
    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old40]) {
        
    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old41]) {
        
    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old42]) {
        
    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old43]) {
        
    }
    if ([dataTask.originalRequest.URL.absoluteString isEqualToString:old44]) {
        
    }
 
    [self.client URLProtocol:self didLoadData:data];
    
    // 修改后返回数据
    NSString *dataStr1 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (dataStr1) {
        //NSLog(@"*** 修改后返回数据 after : %@", dataStr1);
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    completionHandler(NSURLSessionResponseAllow);
    self.response = response;
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    if (response != nil){
        self.response = response;
        [[self client] URLProtocol:self wasRedirectedToRequest:request redirectResponse:response];
    }
}


@end
