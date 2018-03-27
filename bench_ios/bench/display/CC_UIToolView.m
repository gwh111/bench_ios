//
//  CC_UIToolView.m
//  bench_ios
//
//  Created by gwh on 2018/3/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_UIToolView.h"

static int textFieldBaseTag=100;

@implementation CC_UIToolView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)keyboardWillShow{
    if (self.bottom==[ccui getH]) {
        self.top=[ccui getY]+20;
    }
    [self updateFrame];
}

- (void)initUI{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    
    self.frame=CGRectMake(0, 0, [ccui getW], [ccui getRH:120]);
    self.backgroundColor=[UIColor blackColor];
    self.alpha=.8;
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [window addSubview:self];
    
    //防止穿透
    [CC_Button cr:self l:0 t:0 w:[ccui getW] h:[ccui getRH:120] ts:nil ats:nil tc:nil bgc:nil img:nil bgimg:nil f:nil ta:0 uie:0];
    
    NSArray *frames=@[@"左",@"上",@"宽",@"高"];
    for (int i=0; i<frames.count; i++) {
        [CC_Label cr:self l:10+i*60 t:0 w:60 h:30 ts:frames[i] ats:nil tc:[UIColor greenColor] bgc:[UIColor clearColor] f:[ccui getRFS:14] ta:1];
        CC_TextField *la=[CC_TextField cr:self l:10+i*60 t:30 w:60 h:30 tc:[UIColor greenColor] bgc:[UIColor blackColor] f:[ccui getRFS:14] ta:1 ph:@"1" uie:YES];
        la.tag=i+textFieldBaseTag;
    }
    
    NSArray *names=@[@"log",@"上下",@"修改"];
    for (int i=0; i<names.count; i++) {
        NSString *name=names[i];
        CC_Button *button=[CC_Button createWithFrame:CGRectMake([ccui getW]-[ccui getRH:80], [ccui getRH:30]*i, [ccui getRH:80], [ccui getRH:30]) andTitleString_stateNoraml:name andAttributedString_stateNoraml:nil andTitleColor_stateNoraml:[UIColor greenColor] andTitleFont:nil andBackGroundColor:nil andImage:nil andBackGroundImage:nil inView:self];
        [button addTappedOnceDelay:.1 withBlock:^(UIButton *button) {
            if ([name isEqualToString:@"上下"]) {
                [self upside:button];
            }else if ([name isEqualToString:@"log"]){
                [self logObj:button];
            }else if ([name isEqualToString:@"修改"]){
                [self fixObj:button];
            }
        }];
        [self upside:button];
    }
}

- (void)upside:(UIButton *)button{
    button.selected=!button.selected;
    if (button.selected) {
        self.bottom=[ccui getH];
    }else{
        self.top=[ccui getY]+20;;
    }
}

- (void)logObj:(UIButton *)button{
    
    [self updateFrame];
    if ([[CC_UIHelper getInstance].lastV isKindOfClass:[UILabel class]]) {
        UILabel *l=(UILabel*)[CC_UIHelper getInstance].lastV;
        NSString *logStr=[NSString stringWithFormat:@"[CC_Label cr:self.view l:xxx t:yyy w:www h:hhh ts:@"" ats:nil tc:ccRGBHexA(0xFF0000, 1) bgc:[UIColor yellowColor] f:[ccui getRFS:14] ta:0];"];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"xxx" withString:ccstr(@"%.0f",l.origin.x)];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"yyy" withString:ccstr(@"%.0f",l.origin.y)];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"www" withString:ccstr(@"%.0f",l.frame.size.width)];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"hhh" withString:ccstr(@"%.0f",l.frame.size.height)];
        CCLOG(@"\nid obj=%@",logStr);
    }else if ([[CC_UIHelper getInstance].lastV isKindOfClass:[UITextField class]]){
        UITextField *l=(UITextField*)[CC_UIHelper getInstance].lastV;
        NSString *logStr=[NSString stringWithFormat:@"[CC_TextField cr:self.view l:xxx t:yyy w:www h:hhh tc:[UIColor blackColor] bgc:[UIColor whiteColor] f:[ccui getRFS:14] uie:NO];"];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"xxx" withString:ccstr(@"%.0f",l.origin.x)];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"yyy" withString:ccstr(@"%.0f",l.origin.y)];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"www" withString:ccstr(@"%.0f",l.frame.size.width)];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"hhh" withString:ccstr(@"%.0f",l.frame.size.height)];
        CCLOG(@"\nid obj=%@",logStr);
    }else if ([[CC_UIHelper getInstance].lastV isKindOfClass:[UITextView class]]){
        UITextView *l=(UITextView*)[CC_UIHelper getInstance].lastV;
        NSString *logStr=[NSString stringWithFormat:@"[CC_TextView cr:self.view l:xxx t:yyy w:www h:hhh ts:@"" ats:nil tc:[UIColor blackColor] bgc:[UIColor whiteColor] f:[ccui getRFS:14] ta:0 sb:YES eb:YES uie:NO];"];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"xxx" withString:ccstr(@"%.0f",l.origin.x)];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"yyy" withString:ccstr(@"%.0f",l.origin.y)];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"www" withString:ccstr(@"%.0f",l.frame.size.width)];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"hhh" withString:ccstr(@"%.0f",l.frame.size.height)];
        CCLOG(@"\nid obj=%@",logStr);
    }else if ([[CC_UIHelper getInstance].lastV isKindOfClass:[UIButton class]]){
        UIButton *l=(UIButton*)[CC_UIHelper getInstance].lastV;
        NSString *logStr=[NSString stringWithFormat:@"[CC_Button cr:self.view l:xxx t:yyy w:www h:hhh ts:@"" ats:nil tc:[UIColor blackColor] bgc:nil img:nil bgimg:nil f:[ccui getRFS:16] ta:0 uie:NO];"];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"xxx" withString:ccstr(@"%.0f",l.origin.x)];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"yyy" withString:ccstr(@"%.0f",l.origin.y)];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"www" withString:ccstr(@"%.0f",l.frame.size.width)];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"hhh" withString:ccstr(@"%.0f",l.frame.size.height)];
        CCLOG(@"\nid obj=%@",logStr);
    }else if ([[CC_UIHelper getInstance].lastV isKindOfClass:[UIView class]]){
        UIView *l=(UIView*)[CC_UIHelper getInstance].lastV;
        NSString *logStr=[NSString stringWithFormat:@"[CC_View cr:self.view l:xxx t:yyy w:www h:hhh bcg:ccRGBHex(0xFF0000)];"];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"xxx" withString:ccstr(@"%.0f",l.origin.x)];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"yyy" withString:ccstr(@"%.0f",l.origin.y)];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"www" withString:ccstr(@"%.0f",l.frame.size.width)];
        logStr=[logStr stringByReplacingOccurrencesOfString:@"hhh" withString:ccstr(@"%.0f",l.frame.size.height)];
        CCLOG(@"\nid obj=%@",logStr);
    }
}

- (void)fixObj:(UIButton *)button{
    
    UIView *v=(UIView*)[CC_UIHelper getInstance].lastV;
    for (int i=0; i<4; i++) {
        CC_TextField *la=[self viewWithTag:textFieldBaseTag+i];
        if (i==0) {
            v.left=[la.text floatValue];
        }else if (i==1){
            v.top=[la.text floatValue];
        }else if (i==2){
            v.width=[la.text floatValue];
        }else if (i==3){
            v.height=[la.text floatValue];
        }
    }
}

- (void)updateFrame{
    
    UIView *v=(UIView*)[CC_UIHelper getInstance].lastV;
    NSArray *fs=@[@(v.frame.origin.x),@(v.frame.origin.y),@(v.frame.size.width),@(v.frame.size.height)];
    for (int i=0; i<4; i++) {
        CC_TextField *la=[self viewWithTag:textFieldBaseTag+i];
        la.text=ccstr(@"%d",[fs[i] intValue]);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //方法3:结束主窗口上的所有编辑
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    [self updateFrame];
    
    
}

@end
