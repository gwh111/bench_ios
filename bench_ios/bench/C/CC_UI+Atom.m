//
//  CC_ShareUI+CC.m
//  bench_ios
//
//  Created by gwh on 2019/11/28.
//

#import "CC_UI+Atom.h"

@implementation CC_UI (Atom)

#pragma mark view
- (CC_View *)grayLine {
    return ccs.View
    .cc_frame(0, 0, WIDTH(), 2)
    .cc_backgroundColor(HEX(#F5F5F5));
}

- (CC_View *)alphaBackground {
    return ccs.View
    .cc_frame(0, 0, WIDTH(), HEIGHT())
    .cc_backgroundColor(RGBA(0, 0, 0, 0.5));
}

- (CC_View *)alphaBackgroundWithAnimation {
    CC_View *background = ccs.View
    .cc_frame(0, 0, WIDTH(), HEIGHT())
    .cc_backgroundColor(RGBA(0, 0, 0, 0.5));
    background.alpha = 0;
    [UIView animateWithDuration:.5 animations:^{
        background.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    return background;
}

#pragma mark label
- (CC_Label *)dateLabel {
    return ccs.Label
    .cc_frame(RH(10), 0, RH(200), RH(20))
    .cc_textColor(HEX(#999999))
    .cc_font(RF(11))
    .cc_text(@"2019/09/10 10:13:41");
}

- (CC_Label *)itemTitleLabel {
    return ccs.Label
    .cc_frame(RH(20), 0, WIDTH(), RH(50))
    .cc_textColor(UIColor.blackColor)
    .cc_text(@"标题")
    .cc_font(RF(20));
}

- (CC_Label *)itemDesLabel {
    return ccs.Label
    .cc_frame(RH(10), RH(15), RH(200), RH(35))
    .cc_textColor(UIColor.grayColor)
    .cc_textAlignment(NSTextAlignmentLeft)
    .cc_font(RF(14))
    .cc_text(@"描述");
}

#pragma mark button
// enabled = NO 灰底
// enabled = YES 红底
- (CC_Button *)doneButton {
    return ccs.Button
    .cc_frame(RH(20), 0, WIDTH() - RH(40), RH(40))
    .cc_setBackgroundColorForState(HEX(#D7D9DB), UIControlStateDisabled)
    .cc_setBackgroundColorForState(HEX(#F01F2F), UIControlStateNormal)
    .cc_setTitleColorForState(UIColor.whiteColor, UIControlStateNormal)
    .cc_setTitleForState(@"确认", UIControlStateNormal)
    .cc_cornerRadius(4)
    .cc_font(RF(16));
}

- (CC_Button *)closeButton {
    return ccs.Button
    .cc_frame(WIDTH() - RH(45), RH(20), RH(30), RH(30))
    .cc_setTitleColorForState(HEX(#B8B8B8), UIControlStateNormal)
    .cc_font(BRF(15))
    .cc_setTitleForState(@"X", UIControlStateNormal);
}

- (CC_Button *)warningButton {
    return ccs.Button
    .cc_frame(0, 0, RH(20), RH(20))
    .cc_cornerRadius(RH(10))
    .cc_backgroundColor(RGBA(0, 0, 0, 0.2))
    .cc_setTitleColorForState(COLOR_WHITE, UIControlStateNormal)
    .cc_setTitleForState(@"!",UIControlStateNormal);
}

- (CC_Button *)wordButton {
    return ccs.Button
    .cc_frame(WIDTH() - RH(60), RH(20), RH(60), RH(44))
    .cc_setTitleColorForState(UIColor.darkGrayColor, UIControlStateNormal)
    .cc_font(RF(16))
    .cc_setTitleForState(@"举报", UIControlStateNormal);
}

#pragma mark imageView
- (CC_ImageView *)figureImageView {
    return ccs.ImageView
    .cc_frame(RH(10), RH(10), RH(50), RH(50))
    .cc_cornerRadius(RH(25));
}

@end
