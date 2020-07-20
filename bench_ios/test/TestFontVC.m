//
//  TestFontVC.m
//  bench_ios
//
//  Created by gwh on 2020/4/27.
//

#import "TestFontVC.h"
#import "ccs.h"

@interface TestFontVC ()

@end

@implementation TestFontVC

- (void)cc_viewDidLoad {
    
    float y = 0;
    for (int i = 0; i < 18; i++) {
        int f = 8+i;
        NSString *text = [ccs string:@"%d号字体大小123456789",f];
        CC_Label *textLabel =
        ccs.Label
        .cc_frame(0,0,WIDTH(),0)
        .cc_font(RF(f))
        .cc_text(text)
        .cc_addToView(self);
        [textLabel sizeToFit];
        textLabel.top = y;
        y = textLabel.bottom;
        if (f == 20) {
            for (int m = 1; m < 6; m++) {
                NSString *text1 = [ccs string:@"%@ 距离上面%d",text,m*2];
                CC_Label *textLabel1 =
                ccs.Label
                .cc_frame(0,0,WIDTH(),0)
                .cc_font(RF(f))
                .cc_text(text1)
                .cc_addToView(self);
                [textLabel1 sizeToFit];
                textLabel1.top = y + RH(m*2);
                y = textLabel1.bottom;
            }
        }
    }
    
    ccs.Label
    .cc_backgroundColor(UIColor.grayColor)
    .cc_textAlignment(NSTextAlignmentCenter)
    .cc_frame(0,self.cc_displayView.height - ccs.safeBottom - RH(70),RH(187.5),RH(30))
    .cc_text(@"187.5")
    .cc_addToView(self);
    
    ccs.Label
    .cc_backgroundColor(UIColor.grayColor)
    .cc_textAlignment(NSTextAlignmentCenter)
    .cc_frame(0,self.cc_displayView.height - ccs.safeBottom - RH(30),RH(375),RH(30))
    .cc_text(@"375")
    .cc_addToView(self);
}

@end
