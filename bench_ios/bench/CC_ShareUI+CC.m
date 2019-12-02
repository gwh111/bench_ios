//
//  CC_ShareUI+CC.m
//  bench_ios
//
//  Created by gwh on 2019/11/28.
//

#import "CC_ShareUI+CC.h"

@implementation CC_ShareUI (CC)

#pragma mark view
- (CC_View *)grayLine {
    return ccs.View
    .cc_frame(0, 0, WIDTH(), 2)
    .cc_backgroundColor(HEX(#F5F5F5));
}

#pragma mark label
- (CC_Label *)dateLabel {
    return ccs.Label
    .cc_frame(RH(10), 0, RH(200), RH(20))
    .cc_textColor(HEX(#999999))
    .cc_font(RF(11))
    .cc_text(@"2019/09/10 10:13:41");
}

#pragma mark button
- (CC_Button *)disabledDoneButton {
    return ccs.Button
    .cc_frame(RH(20), 0, WIDTH() - RH(40), RH(40))
    .cc_setBackgroundColorForState(HEX(#D7D9DB), UIControlStateNormal)
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

@end
