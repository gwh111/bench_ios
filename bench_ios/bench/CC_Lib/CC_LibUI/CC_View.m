//
//  CC_View.m
//  testbenchios
//
//  Created by gwh on 2019/8/7.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_View.h"
#import "CC_Label.h"

typedef void (^CCAssociatedTapBlock)(UIView *view);

@interface CC_View () {
@public
    BOOL _dragable;
}

@end

@implementation CC_View

// MARK: - LifeCycle -

// MARK: - Actions -

- (void)cc_updateBadge:(NSString *)badge{
    [self checkBadgeLabel];
    
    CGSize size = [self caculateBadgeWidth:badge];
    self.badgeLabel.frame = CGRectMake(self.width-size.width/2.0, -size.height/2.0, size.width, size.height);
    self.badgeLabel.text = badge;
    self.badgeLabel.layer.cornerRadius = size.height/2.0;
    self.badgeLabel.layer.masksToBounds = YES;
}

- (void)cc_updateBadgeBackgroundColor:(UIColor *)backgroundColor{
    [self checkBadgeLabel];
    self.badgeLabel.backgroundColor = backgroundColor;
}

- (void)cc_updateBadgeTextColor:(UIColor*)textColor{
    [self checkBadgeLabel];
    self.badgeLabel.textColor = textColor;
}

// MARK: - UI -
- (CC_Label *)badgeLabel{
    return [CC_Runtime cc_getObject:self key:@selector(badgeLabel)];
}

- (void)setBadgeLabel:(CC_Label *)badgeLabel{
    [CC_Runtime cc_setObject:self key:@selector(badgeLabel) value:badgeLabel];
}

// MARK: - Internal -
- (void)checkBadgeLabel {
    if (!self.badgeLabel) {
        self.badgeLabel = [CC_Base.shared cc_init:CC_Label.class];
        {typeof (self.badgeLabel) item = self.badgeLabel;
            item.cc_font([[CC_CoreUI shared]relativeFont:11])
                .cc_textAlignment(NSTextAlignmentCenter)
                .cc_backgroundColor([UIColor cc_rgbA:255 green:89 blue:59 alpha:1])
                .cc_addToView(self);
        }
    }
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

- (__kindof CC_View * (^)(BOOL))cc_dragable {
    return ^(BOOL dragable) {
        self->_dragable = dragable;
        return self;
    };
}

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


@end
