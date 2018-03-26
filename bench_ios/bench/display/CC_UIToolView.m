//
//  CC_UIToolView.m
//  bench_ios
//
//  Created by gwh on 2018/3/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_UIToolView.h"

@implementation CC_UIToolView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.frame=CGRectMake(0, 0, [ccui getW], [ccui getRH:100]);
    self.backgroundColor=[UIColor blackColor];
    self.alpha=.8;
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [window addSubview:self];
    
    NSArray *names=@[@"log",@"上下"];
    for (int i=0; i<names.count; i++) {
        NSString *name=names[i];
        CC_Button *button=[CC_Button createWithFrame:CGRectMake([ccui getW]-[ccui getRH:80], [ccui getRH:36]*i, [ccui getRH:80], [ccui getRH:36]) andTitleString_stateNoraml:name andAttributedString_stateNoraml:nil andTitleColor_stateNoraml:[UIColor greenColor] andTitleFont:nil andBackGroundColor:nil andImage:nil andBackGroundImage:nil inView:self];
        [button addTappedOnceDelay:.1 withBlock:^(UIButton *button) {
            if ([name isEqualToString:@"上下"]) {
                [self upside:button];
            }else if ([name isEqualToString:@"log"]){
                [self logObj:button];
            }
        }];
    }
}

- (void)upside:(UIButton *)button{
    button.selected=!button.selected;
    if (button.selected) {
        self.bottom=[ccui getH];
    }else{
        self.top=0;
    }
}

- (void)logObj:(UIButton *)button{
    if ([[CC_UIHelper getInstance].lastV isKindOfClass:[UILabel class]]) {
        UILabel *l=(UILabel*)[CC_UIHelper getInstance].lastV;
        NSString *logStr=[NSString stringWithFormat:@"[CC_Label createWithFrame:CGRectMake([ccui getRH:%.0f], [ccui getRH:%.0f], [ccui getRH:%.0f], [ccui getRH:%.0f]) andTitleString:@\"%@\" andAttributedString:nil andTitleColor:[UIColor grayColor] andBackGroundColor:nil andFont:[ccui getRelativeFont:nil fontSize:12] andTextAlignment:0 atView:self];",l.origin.x,l.origin.y,l.frame.size.width,l.frame.size.height,l.text];
        CCLOG(@"obj=\n\n%@",logStr);
    }
}

@end
