//
//  PubgLoad.m
//  pubg
//
//  Created by 李良林 on 2021/2/14.
//

#import "PubgLoad.h"
#import <UIKit/UIKit.h>
#include <JRMemory/MemScan.h>
#import "JHPP.h"
#import "JHDragView.h"
#import "SCLAlertView.h"
@interface PubgLoad()
@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation PubgLoad

static PubgLoad *extraInfo;
static BOOL MenDeal;

+ (void)load
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        extraInfo =  [PubgLoad new];
        [extraInfo initTapGes];
        [extraInfo tapIconView];
    });
}

-(void)initTapGes
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.numberOfTapsRequired = 2;//点击次数
    tap.numberOfTouchesRequired = 3;//手指数
    [[JHPP currentViewController].view addGestureRecognizer:tap];
    [tap addTarget:self action:@selector(tapIconView)];
}

-(void)tapIconView
{
    JHDragView *view = [[JHPP currentViewController].view viewWithTag:100];
    if (!view) {
        view = [[JHDragView alloc] init];
        view.tag = 100;
        [[JHPP currentViewController].view addSubview:view];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onConsoleButtonTapped:)];
        tap.numberOfTapsRequired = 1;
        [view addGestureRecognizer:tap];
    }
    
    if (!MenDeal) {
        view.hidden = NO;
    } else {
        view.hidden = YES;
    }
    
    MenDeal = !MenDeal;
}
// JR_Search_Type_ULong   //I64     uint64_t
// JR_Search_Type_Double  //Double  Double
// JR_Search_Type_SLong   //U64     SInt64
// JR_Search_Type_Float   //Float   Float
// JR_Search_Type_UInt    //I32     uint32_t
// JR_Search_Type_SInt    //U32     SInt32
// JR_Search_Type_UShort  //I16     uint16_t
// JR_Search_Type_SShort  //U16     SInt16
// JR_Search_Type_UByte   //I8      uint8_t
// JR_Search_Type_SByte   //U8      SInt8

-(void)onConsoleButtonTapped:(id)sender
{
    //解析服务器版本
    NSError *error;
    NSString *txturl = [NSString stringWithFormat:@"https://iosgods.cn/html/game/wzdl.json"];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:txturl]];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    //主标题
    NSArray *zhugongneng = [json objectForKey:@"gongneng"];//主功能
    NSString *zhutitle = [json objectForKey:@"zhutitle"];
    NSString *fubiaoti = [json objectForKey:@"futitle"];
    NSArray *shulu =[[json objectForKey:@"shulu"] componentsSeparatedByString:@","];
    //主菜单
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert addTimerToButtonIndex:0 reverse:YES];
    if (shulu[0]!=nil) {
        SCLTextView *textF =   [alert addTextField:shulu[1] setDefaultText:nil];
        [alert addButton:shulu[0] actionBlock:^{
            JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
            AddrRange range = (AddrRange){0x100000000,0x160000000};
            float zdy =[textF.text floatValue];
            float search = [shulu[2] floatValue];
            engine.JRScanMemory(range, &search, JR_Search_Type_Float);
            float search2 = [shulu[3] floatValue];
            engine.JRNearBySearch(0x20,&search2,JR_Search_Type_Float);
            float search3 = [shulu[4] floatValue];
            engine.JRNearBySearch(0x20,&search3,JR_Search_Type_Float);
            vector<void*>results = engine.getAllResults();
            float modify = 1.2*zdy;
            for(int i = 0;i<results.size();i++){
                engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
                    }
        }];
    }
    
    for (int i=0; i<zhugongneng.count; i++) {
        //循环写子菜单
        NSArray *zicaidan = [zhugongneng[i] objectForKey:@"gongneng"];//子菜单
        NSString *zititle = [zhugongneng[i] objectForKey:@"title"];//子菜单主标题
        NSString *zifutitle = [zhugongneng[i] objectForKey:@"futitle"];//子菜单副标题
        NSLog(@"子菜单%d",i);
        [alert addButton:zititle actionBlock:^{
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert addTimerToButtonIndex:0 reverse:YES];
            
            for (int ii=0; ii<zicaidan.count; ii++) {
                NSDictionary *zhigongneng =zicaidan[ii];
                NSString *gongneng =[zhigongneng objectForKey:@"title"];
                NSArray *sousuo =[[zhigongneng objectForKey:@"sousuo"] componentsSeparatedByString:@","];
                NSArray *quangai =[[zhigongneng objectForKey:@"quangai"] componentsSeparatedByString:@","];
                NSArray *geshi =[[zhigongneng objectForKey:@"geshi"] componentsSeparatedByString:@","];
//                NSArray *fanwei =[[zhigongneng objectForKey:@"fanwei"] componentsSeparatedByString:@","];
                NSArray *jingque =[[zhigongneng objectForKey:@"jingque"] componentsSeparatedByString:@","];
                NSArray *tiaojian =[[zhigongneng objectForKey:@"tiaojian"] componentsSeparatedByString:@","];
                NSLog(@"功能%@",sousuo[0]);//I32:-1231431
                
                [alert addButton:gongneng actionBlock:^{
                    
                    JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
                    AddrRange range = (AddrRange){0x100000000,0x160000000};
                    //第一个搜索
                    if(sousuo[0]!=nil){
                        if ([geshi[0] isEqual:@"Double"]) {
                        double search = [sousuo[0] doubleValue];
                        engine.JRScanMemory(range, &search, JR_Search_Type_Double);
                    }
                        if ([geshi[0] isEqual:@"Float"]) {
                        float search = [sousuo[0] floatValue];
                        engine.JRScanMemory(range, &search, JR_Search_Type_Float);
                    }
                        if ([geshi[0] isEqual:@"I8"]) {
                        uint8_t search = [sousuo[0] intValue];
                        engine.JRScanMemory(range, &search, JR_Search_Type_UByte);
                    }
                        if ([geshi[0] isEqual:@"I16"]) {
                        uint16_t search = [sousuo[0] intValue];
                        engine.JRScanMemory(range, &search, JR_Search_Type_UShort);
                    }
                        if ([geshi[0] isEqual:@"I32"]) {
                        uint32_t search = [sousuo[0] doubleValue];
                        engine.JRScanMemory(range, &search, JR_Search_Type_UInt);
                    }
                        if ([geshi[0] isEqual:@"I64"]) {
                        uint64_t search = [sousuo[0] doubleValue];
                        engine.JRScanMemory(range, &search, JR_Search_Type_ULong);
                    }
                        if ([geshi[0] isEqual:@"U8"]) {
                        SInt8 search = [sousuo[0] doubleValue];
                        engine.JRScanMemory(range, &search, JR_Search_Type_SByte);
                    }
                        if ([geshi[0] isEqual:@"U16"]) {
                        SInt16 search = [sousuo[0] doubleValue];
                        engine.JRScanMemory(range, &search, JR_Search_Type_SShort);
                    }
                        if ([geshi[0] isEqual:@"U32"]) {
                        SInt32 search = [sousuo[0] doubleValue];
                        engine.JRScanMemory(range, &search, JR_Search_Type_SInt);
                    }
                        if ([geshi[0] isEqual:@"U64"]) {
                        SInt64 search = [sousuo[0] doubleValue];
                        engine.JRScanMemory(range, &search, JR_Search_Type_SLong);
                    }
                    }
                    //联合第二个搜索
                    else if(sousuo[1]!=nil){
                        if ([geshi[1] isEqual:@"Double"]) {
                            double search1 = [sousuo[1] doubleValue];
                            engine.JRNearBySearch(0x50,&search1,JR_Search_Type_Double);
                        }
                        if ([geshi[1] isEqual:@"Float"]) {
                            float search1 = [sousuo[1] floatValue];
                            engine.JRNearBySearch(0x50,&search1,JR_Search_Type_Float);
                        }
                        if ([geshi[1] isEqual:@"I8"]) {
                            uint8_t search1 = [sousuo[1] doubleValue];
                            engine.JRNearBySearch(0x50,&search1,JR_Search_Type_UByte);
                        }
                        if ([geshi[1] isEqual:@"I16"]) {
                            uint16_t search1 = [sousuo[1] doubleValue];
                            engine.JRNearBySearch(0x50,&search1,JR_Search_Type_UShort);
                        }
                        if ([geshi[1] isEqual:@"I32"]) {
                            uint32_t search1 = [sousuo[1] doubleValue];
                            engine.JRNearBySearch(0x50,&search1,JR_Search_Type_UInt);
                        }
                        if ([geshi[1] isEqual:@"I64"]) {
                            uint64_t search1 = [sousuo[1] doubleValue];
                            engine.JRNearBySearch(0x50,&search1,JR_Search_Type_ULong);
                        }
                        if ([geshi[1] isEqual:@"U8"]) {
                            SInt8 search1 = [sousuo[1] doubleValue];
                            engine.JRNearBySearch(0x50, &search1, JR_Search_Type_SByte);
                        }
                        if ([geshi[1] isEqual:@"U16"]) {
                            SInt16 search1 = [sousuo[1] doubleValue];
                            engine.JRNearBySearch(0x50, &search1, JR_Search_Type_SShort);
                        }
                        if ([geshi[1] isEqual:@"U32"]) {
                            SInt32 search1 = [sousuo[1] doubleValue];
                            engine.JRNearBySearch(0x50, &search1, JR_Search_Type_SInt);
                        }
                        if ([geshi[1] isEqual:@"U64"]) {
                            SInt64 search1 = [sousuo[1] doubleValue];
                            engine.JRNearBySearch(0x50, &search1, JR_Search_Type_SLong);
                        }
                    }
                    //联合第三个搜索
                    else if(sousuo[2]!=nil){
                        if ([geshi[2] isEqual:@"Double"]) {
                            double search2 = [sousuo[2] doubleValue];
                            engine.JRNearBySearch(0x50,&search2,JR_Search_Type_Double);
                        }
                        else if ([geshi[2] isEqual:@"Float"]) {
                            float search2 = [sousuo[2] floatValue];
                            engine.JRNearBySearch(0x50,&search2,JR_Search_Type_Float);
                        }
                        else if ([geshi[2] isEqual:@"I8"]) {
                            uint8_t search2 = [sousuo[2] doubleValue];
                            engine.JRNearBySearch(0x50,&search2,JR_Search_Type_UByte);
                        }
                        else if ([geshi[2] isEqual:@"I16"]) {
                            uint16_t search2 = [sousuo[2] doubleValue];
                            engine.JRNearBySearch(0x50,&search2,JR_Search_Type_UShort);
                        }
                        else if ([geshi[2] isEqual:@"I32"]) {
                            uint32_t search2 = [sousuo[2] doubleValue];
                            engine.JRNearBySearch(0x50,&search2,JR_Search_Type_UInt);
                        }
                        else if ([geshi[2] isEqual:@"I64"]) {
                            uint64_t search2 = [sousuo[2] doubleValue];
                            engine.JRNearBySearch(0x50,&search2,JR_Search_Type_ULong);
                        }
                        else if ([geshi[2] isEqual:@"U8"]) {
                            SInt8 search2 = [sousuo[2] doubleValue];
                            engine.JRNearBySearch(0x50, &search2, JR_Search_Type_SByte);
                        }
                        else if ([geshi[2] isEqual:@"U16"]) {
                            SInt16 search2 = [sousuo[2] doubleValue];
                            engine.JRNearBySearch(0x50, &search2, JR_Search_Type_SShort);
                        }
                        else if ([geshi[2] isEqual:@"U32"]) {
                            SInt32 search2 = [sousuo[2] doubleValue];
                            engine.JRNearBySearch(0x50, &search2, JR_Search_Type_SInt);
                        }
                        else if ([geshi[2] isEqual:@"U64"]) {
                            SInt64 search2 = [sousuo[2] doubleValue];
                            engine.JRNearBySearch(0x50, &search2, JR_Search_Type_SLong);
                        }
                    }
                    //联合第四个搜索
                    else if(sousuo[3]!=nil){
                        if ([geshi[3] isEqual:@"Double"]) {
                            double search3 = [sousuo[3] doubleValue];
                            engine.JRNearBySearch(0x50,&search3,JR_Search_Type_Double);
                        }
                        else if ([geshi[3] isEqual:@"Float"]) {
                            float search3 = [sousuo[3] floatValue];
                            engine.JRNearBySearch(0x50,&search3,JR_Search_Type_Float);
                        }
                        else if ([geshi[3] isEqual:@"I8"]) {
                            uint8_t search3 = [sousuo[3] doubleValue];
                            engine.JRNearBySearch(0x50,&search3,JR_Search_Type_UByte);
                        }
                        else if ([geshi[3] isEqual:@"I16"]) {
                            uint16_t search3 = [sousuo[3] doubleValue];
                            engine.JRNearBySearch(0x50,&search3,JR_Search_Type_UShort);
                        }
                        else if ([geshi[3] isEqual:@"I32"]) {
                            uint32_t search3 = [sousuo[3] doubleValue];
                            engine.JRNearBySearch(0x50,&search3,JR_Search_Type_UInt);
                        }
                        else if ([geshi[3] isEqual:@"I64"]) {
                            uint64_t search3 = [sousuo[3] doubleValue];
                            engine.JRNearBySearch(0x50,&search3,JR_Search_Type_ULong);
                        }
                        else if ([geshi[3] isEqual:@"U8"]) {
                            SInt8 search3 = [sousuo[3] doubleValue];
                            engine.JRNearBySearch(0x50, &search3, JR_Search_Type_SByte);
                        }
                        else if ([geshi[3] isEqual:@"U16"]) {
                            SInt16 search3 = [sousuo[3] doubleValue];
                            engine.JRNearBySearch(0x50, &search3, JR_Search_Type_SShort);
                        }
                        else if ([geshi[3] isEqual:@"U32"]) {
                            SInt32 search3 = [sousuo[3] doubleValue];
                            engine.JRNearBySearch(0x50, &search3, JR_Search_Type_SInt);
                        }
                        else if ([geshi[3] isEqual:@"U64"]) {
                            SInt64 search3 = [sousuo[3] doubleValue];
                            engine.JRNearBySearch(0x50, &search3, JR_Search_Type_SLong);
                        }
                    }
                    //联合第五个搜索
                    else if(sousuo[4]!=nil){
                        if ([geshi[4] isEqual:@"Double"]) {
                            double search4 = [sousuo[4] doubleValue];
                            engine.JRNearBySearch(0x50,&search4,JR_Search_Type_Double);
                        }
                        else if ([geshi[4] isEqual:@"Float"]) {
                            float search4 = [sousuo[4] floatValue];
                            engine.JRNearBySearch(0x50,&search4,JR_Search_Type_Float);
                        }
                        else if ([geshi[4] isEqual:@"I8"]) {
                            uint8_t search4 = [sousuo[4] doubleValue];
                            engine.JRNearBySearch(0x50,&search4,JR_Search_Type_UByte);
                        }
                        else if ([geshi[4] isEqual:@"I16"]) {
                            uint16_t search4 = [sousuo[4] doubleValue];
                            engine.JRNearBySearch(0x50,&search4,JR_Search_Type_UShort);
                        }
                        else if ([geshi[4] isEqual:@"I32"]) {
                            uint32_t search4 = [sousuo[4] doubleValue];
                            engine.JRNearBySearch(0x50,&search4,JR_Search_Type_UInt);
                        }
                        else if ([geshi[4] isEqual:@"I64"]) {
                            uint64_t search4 = [sousuo[4] doubleValue];
                            engine.JRNearBySearch(0x50,&search4,JR_Search_Type_ULong);
                        }
                        else if ([geshi[4] isEqual:@"U8"]) {
                            SInt8 search4 = [sousuo[4] doubleValue];
                            engine.JRNearBySearch(0x50, &search4, JR_Search_Type_SByte);
                        }
                        else if ([geshi[4] isEqual:@"U16"]) {
                            SInt16 search4 = [sousuo[4] doubleValue];
                            engine.JRNearBySearch(0x50, &search4, JR_Search_Type_SShort);
                        }
                        else if ([geshi[4] isEqual:@"U32"]) {
                            SInt32 search4 = [sousuo[4] doubleValue];
                            engine.JRNearBySearch(0x50, &search4, JR_Search_Type_SInt);
                        }
                        else if ([geshi[4] isEqual:@"U64"]) {
                            SInt64 search4 = [sousuo[4] doubleValue];
                            engine.JRNearBySearch(0x50, &search4, JR_Search_Type_SLong);
                        }
                    }
                    //最后精确搜索
                    else if (jingque!=nil) {
                        if ([jingque[0] isEqual:@"Double"]) {
                            double searchjq = [jingque[1] doubleValue];
                            engine.JRScanMemory(range,&searchjq,JR_Search_Type_Double);
                        }
                        else if ([jingque[0] isEqual:@"Float"]) {
                            float searchjq = [jingque[1] floatValue];
                            engine.JRScanMemory(range,&searchjq,JR_Search_Type_Float);
                        }
                        else if ([jingque[0] isEqual:@"I8"]) {
                            uint8_t searchjq = [jingque[1] floatValue];
                            engine.JRScanMemory(range,&searchjq,JR_Search_Type_UByte);
                        }
                        else if ([jingque[0] isEqual:@"I16"]) {
                            uint16_t searchjq = [jingque[1] floatValue];
                            engine.JRScanMemory(range,&searchjq,JR_Search_Type_UShort);
                        }
                        else if ([jingque[0] isEqual:@"I32"]) {
                            uint32_t searchjq = [jingque[1] floatValue];
                            engine.JRScanMemory(range,&searchjq,JR_Search_Type_UInt);
                        }
                        else if ([jingque[0] isEqual:@"I64"]) {
                            uint64_t searchjq = [jingque[1] floatValue];
                            engine.JRScanMemory(range,&searchjq,JR_Search_Type_ULong);
                        }
                        else if ([jingque[0] isEqual:@"U8"]) {
                            SInt8 searchjq = [jingque[1] floatValue];
                            engine.JRScanMemory(range,&searchjq,JR_Search_Type_SByte);
                        }
                        else if ([jingque[0] isEqual:@"U16"]) {
                            SInt16 searchjq = [jingque[1] floatValue];
                            engine.JRScanMemory(range,&searchjq,JR_Search_Type_SShort);
                        }
                        else if ([jingque[0] isEqual:@"U32"]) {
                            SInt32 searchjq = [jingque[1] floatValue];
                            engine.JRScanMemory(range,&searchjq,JR_Search_Type_SInt);
                        }
                        else if ([jingque[0] isEqual:@"U64"]) {
                            SInt64 searchjq = [jingque[1] floatValue];
                            engine.JRScanMemory(range,&searchjq,JR_Search_Type_SLong);
                        }
                    }
                    
                    //最后修改
                    vector<void*>results = engine.getAllResults();
                    //全改多个
                    if(quangai.count>2){
                        for(int i = 0;i<results.size();i++){
                            //第一个条件1全改
                            if ([quangai[0] isEqual:@"Double"]) {
                                double modify = [quangai[1] doubleValue];
                                if(quangai[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Double);
                            }
                            else if ([quangai[0] isEqual:@"Float"]) {
                                float modify = [quangai[1] floatValue];
                                if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
                            }
                            else if ([quangai[0] isEqual:@"I8"]) {
                                uint8_t modify = [quangai[1] floatValue];
                                if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UByte);
                            }
                            else if ([quangai[0] isEqual:@"I16"]) {
                                uint16_t modify = [quangai[1] floatValue];
                                if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UShort);
                            }
                            else if ([quangai[0] isEqual:@"I32"]) {
                                uint32_t modify = [quangai[1] doubleValue];
                                if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);
                            }
                            else if ([quangai[0] isEqual:@"I64"]) {
                                uint64_t modify = [quangai[1] floatValue];
                                if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_ULong);
                            }
                            else if ([quangai[0] isEqual:@"U8"]) {
                                SInt8 modify = [quangai[1] doubleValue];
                                if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SByte);
                            }
                            else if ([quangai[0] isEqual:@"U16"]) {
                                SInt16 modify = [quangai[1] doubleValue];
                                if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SShort);
                            }
                            else if ([quangai[0] isEqual:@"U32"]) {
                                SInt32 modify = [quangai[1] doubleValue];
                                if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SInt);
                            }
                            else if ([quangai[0] isEqual:@"U64"]) {
                                SInt64 modify = [quangai[1] doubleValue];
                                if(tiaojian[0])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SLong);
                            }
                            //第一个条件2全改
                            else if ([quangai[2] isEqual:@"Double"]) {
                                double modify2 = [quangai[3] doubleValue];
                                if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify2,JR_Search_Type_Double);
                            }
                            else if ([quangai[2] isEqual:@"Float"]) {
                                float modify = [quangai[3] floatValue];
                                if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
                            }
                            else if ([quangai[2] isEqual:@"I8"]) {
                                uint8_t modify = [quangai[3] floatValue];
                                if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UByte);
                            }
                            else if ([quangai[2] isEqual:@"I16"]) {
                                uint16_t modify = [quangai[2] floatValue];
                                if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UShort);
                            }
                            else if ([quangai[2] isEqual:@"I32"]) {
                                uint32_t modify = [quangai[3] doubleValue];
                                if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);
                            }
                            else if ([quangai[2] isEqual:@"I64"]) {
                                uint64_t modify = [quangai[3] floatValue];
                                if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_ULong);
                            }
                            else if ([quangai[2] isEqual:@"U8"]) {
                                SInt8 modify = [quangai[3] doubleValue];
                                if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SByte);
                            }
                            else if ([quangai[2] isEqual:@"U16"]) {
                                SInt16 modify = [quangai[3] doubleValue];
                                if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SShort);
                            }
                            else if ([quangai[2] isEqual:@"U32"]) {
                                SInt32 modify = [quangai[3] doubleValue];
                                if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SInt);
                            }
                            else if ([quangai[2] isEqual:@"U64"]) {
                                SInt64 modify = [quangai[3] doubleValue];
                                if(tiaojian[1])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SLong);
                            }
                            //第一个条件3全改
                            
                            //第一个条件4全改
                            
                        }
                    }
                    //只有一个全改
                    if (quangai.count==2) {
                        if ([quangai[0] isEqual:@"Double"]) {
                            double modify = [quangai[1] doubleValue];
                            for(int i = 0;i<results.size();i++){
                                    if([zhigongneng objectForKey:@"tiaojian"])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Double);
                            }
                        }
                        else if ([quangai[0] isEqual:@"Float"]) {
                            float modify = [quangai[1] floatValue];
                            for(int i = 0;i<results.size();i++){
                                    if([zhigongneng objectForKey:@"tiaojian"])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
                            }
                        }
                        else if ([quangai[0] isEqual:@"I8"]) {
                            uint8_t modify = [quangai[1] doubleValue];
                            for(int i = 0;i<results.size();i++){
                                    if([zhigongneng objectForKey:@"tiaojian"])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UByte);
                            }
                        }
                        else if ([quangai[0] isEqual:@"I16"]) {
                            uint16_t modify = [quangai[1] doubleValue];
                            for(int i = 0;i<results.size();i++){
                                    if([zhigongneng objectForKey:@"tiaojian"])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UShort);
                            }
                        }
                        else if ([quangai[0] isEqual:@"I32"]) {
                            uint32_t modify = [quangai[1] doubleValue];
                            for(int i = 0;i<results.size();i++){
                                    if([zhigongneng objectForKey:@"tiaojian"])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);
                            }
                        }
                        else if ([quangai[0] isEqual:@"I64"]) {
                            uint64_t modify = [quangai[1] doubleValue];
                            for(int i = 0;i<results.size();i++){
                                    if([zhigongneng objectForKey:@"tiaojian"])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_ULong);
                            }
                        }
                        else if ([quangai[0] isEqual:@"U8"]) {
                            SInt8 modify = [quangai[1] doubleValue];
                            for(int i = 0;i<results.size();i++){
                                    if([zhigongneng objectForKey:@"tiaojian"])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SByte);
                            }
                        }
                        else if ([quangai[0] isEqual:@"U16"]) {
                            SInt16 modify = [quangai[1] doubleValue];
                            for(int i = 0;i<results.size();i++){
                                    if([zhigongneng objectForKey:@"tiaojian"])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SShort);
                            }
                        }
                        else if ([quangai[0] isEqual:@"U32"]) {
                            SInt32 modify = [quangai[1] doubleValue];
                            for(int i = 0;i<results.size();i++){
                                    if([zhigongneng objectForKey:@"tiaojian"])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SInt);
                            }
                        }
                        else if ([quangai[0] isEqual:@"U64"]) {
                            SInt64 modify = [quangai[1] doubleValue];
                            for(int i = 0;i<results.size();i++){
                                    if([zhigongneng objectForKey:@"tiaojian"])engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SLong);
                            }
                        }
                    }
                    
                    
                    
                }];
            }
            [alert showSuccess:zititle subTitle:zifutitle closeButtonTitle:@"取消" duration:0];
        }];
        
    }
    [alert addButton:@"透视" actionBlock:^{
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x160000000};
        SInt32 search = -2147483600;
        engine.JRScanMemory(range, &search, JR_Search_Type_SInt);
        SInt32 search1 = 16777216;
        engine.JRNearBySearch(0x5,&search1,JR_Search_Type_SInt);
        SInt32 search2 = 1;
        engine.JRNearBySearch(0x5,&search2,JR_Search_Type_SInt);
        SInt32 search3 = 1;
        engine.JRScanMemory(range, &search3, JR_Search_Type_SInt);
        vector<void*>results = engine.getAllResults();
        SInt32 modify = 257;
        for(int i = 0;i<results.size();i++){
            engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_SInt);
        }
        
    }];
    //    }]];
    [alert showSuccess:zhutitle subTitle:fubiaoti closeButtonTitle:@"取消" duration:0];
    

//    总菜单结束=============
    
    /*[alertCtrl addAction:[UIAlertAction actionWithTitle:@"镜防" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x00000000,0x160000000};
        uint64_t search = 6874028368030887269;
        engine.JRScanMemory(range, &search, JR_Search_Type_ULong);
        vector<void*>results = engine.getAllResults();
        uint64_t modify = 0;
        for(int i = 0;i < results.size();i++){
            if(i == 0)engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_ULong);
        }
    }]];*/
    
    
//    [alertCtrl addAction:[UIAlertAction actionWithTitle:@"范围-20w" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
//        AddrRange range = (AddrRange){0x100000000,0x160000000};
//        float search = 9.203507e-05;
//        engine.JRScanMemory(range, &search, JR_Search_Type_Float);
//        float search1 = 28;
//        engine.JRNearBySearch(0x20,&search1,JR_Search_Type_Float);
//        vector<void*>results = engine.getAllResults();
//        float modify = 200000;
//        for(int i = 0;i<results.size();i++){
//            if(i == 1)engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
//        }
//    }]];
    
   /* [alertCtrl addAction:[UIAlertAction actionWithTitle:@"范围-60w" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
        AddrRange range = (AddrRange){0x100000000,0x160000000};
        float search = 9.203507e-05;
        engine.JRScanMemory(range, &search, JR_Search_Type_Float);
        float search1 = 28;
        engine.JRNearBySearch(0x20,&search1,JR_Search_Type_Float);
        vector<void*>results = engine.getAllResults();
        float modify = 600000;
        for(int i = 0;i<results.size();i++){
            if(i == 1)engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_Float);
        }
    }]];*/
    
//
//    [alertCtrl addAction:[UIAlertAction actionWithTitle:@"内存防请配合端口" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        JRMemoryEngine engine = JRMemoryEngine(mach_task_self());
//        AddrRange range = (AddrRange){0x100000000,0x160000000};
//        uint32_t search = 67109633;
//        engine.JRScanMemory(range, &search, JR_Search_Type_UInt);
//        vector<void*>results = engine.getAllResults();
//        uint32_t modify = 0;
//        for(int i = 0; i < results.size(); i++){
//            engine.JRWriteMemory((unsigned long long)(results[i]),&modify,JR_Search_Type_UInt);
//        }
//    }]];
    
}


@end
