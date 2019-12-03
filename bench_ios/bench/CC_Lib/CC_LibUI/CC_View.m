//
//  CC_View.m
//  testbenchios
//
//  Created by gwh on 2019/8/7.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_View.h"
#import "CC_Label.h"
#import "CC_CoreUI.h"
#import "UIColor+CC.h"

typedef void (^CCAssociatedTapBlock)(UIView *view);

@interface CC_View () {
@public
    BOOL _dragable;
    CC_Label *_badgeLabel;
}

@end

@implementation CC_View

// MARK: - LifeCycle -

// MARK: - Actions -
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (self->_dragable == NO) { return; }
    
    UITouch *touch = [touches anyObject];
    
    // 当前触摸点
    CGPoint currentPoint = [touch locationInView:self.superview];
    // 上一个触摸点
    CGPoint previousPoint = [touch previousLocationInView:self.superview];
    
    // 当前view的中点
    CGPoint center = self.center;
    
    center.x += (currentPoint.x - previousPoint.x);
    center.y += (currentPoint.y - previousPoint.y);
    // 修改当前view的中点(中点改变view的位置就会改变)
    self.center = center;
}

- (__kindof CC_View *(^)(BOOL dragable))cc_dragable {
    return ^(BOOL dragable) {
        self->_dragable = dragable;
        return self;
    };
}

// MARK: - UI -
- (__kindof CC_View *(^)(NSString *))cc_badgeValue {
    return ^(NSString *badgeValue) {
        [self badgeLabel];
        CGSize size = [self caculateBadgeWidth:badgeValue];
        self.badgeLabel
        .cc_frame(self.width - size.width/2.0, -size.height/2.0, size.width, size.height)
        .cc_text(badgeValue)
        .cc_cornerRadius(size.height / 2.0);
        
        return self;
    };
}

- (__kindof CC_View *(^)(UIColor *))cc_badgeColor {
    return ^(UIColor *badgeColor) {
        [self badgeLabel];
        self->_badgeLabel.textColor = badgeColor;
        return self;
    };
}

- (__kindof CC_View *(^)(UIColor *))cc_badgeBgColor {
    return ^(UIColor *badgeBackgroundColor) {
        [self badgeLabel];
        self->_badgeLabel.backgroundColor = badgeBackgroundColor;
        return self;
    };
}

- (CC_Label *)badgeLabel {
    if (!_badgeLabel) {
        _badgeLabel = ((CC_Label *)[CC_Base.shared cc_init:CC_Label.class])
        .cc_font([[CC_CoreUI shared]relativeFont:11])
        .cc_textAlignment(NSTextAlignmentCenter)
        .cc_backgroundColor([UIColor colorWithRed:1 green:0.23 blue:0.19 alpha:1])
        .cc_addToView(self)
        .cc_textColor(UIColor.whiteColor);
    }
    return _badgeLabel;
}

- (CGSize)caculateBadgeWidth:(NSString *)badge {
    if (badge.length <= 0) {
        return CGSizeZero;
    }else{
        CGSize size = [badge boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[[CC_CoreUI shared]relativeFont:11]} context:nil].size;
        size.height = [[CC_CoreUI shared] relativeHeight:14];
        size.width += [[CC_CoreUI shared] relativeHeight:8];
        return size;
    }
}

@end
