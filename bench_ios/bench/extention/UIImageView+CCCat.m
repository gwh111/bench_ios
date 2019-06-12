//
//  UIImageView+CCCat.m
//  bench_ios
//
//  Created by 路飞 on 2019/6/10.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "UIImageView+CCCat.h"
#import "CC_Share.h"

@interface UIImageView ()

@property (nonatomic, strong) UILabel* badgeLb;

@end

@implementation UIImageView (CCCat)

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.badgeLb = [[UILabel alloc]init];
        self.badgeLb.backgroundColor = ccRGBA(255, 89, 59, 1);
        self.badgeLb.textColor = UIColor.whiteColor;
        self.badgeLb.font = RF(11.0f);
        self.badgeLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.badgeLb];
        self.userInteractionEnabled=NO;
    }
    return self;
}

- (void)updateBadge:(NSString*)badge{
    CGSize size = [self caculateBadgeWidth:badge];
    self.badgeLb.frame = CGRectMake(self.width-size.width/2.0, -size.height/2.0, size.width, size.height);
    self.badgeLb.text = badge;
    self.badgeLb.layer.cornerRadius = size.height/2.0;
    self.badgeLb.layer.masksToBounds = YES;
}

- (void)updateBadgeBackGroundColor:(UIColor*)backGroundColor{
    self.badgeLb.backgroundColor = backGroundColor;
}

- (void)updateBadgeTextColor:(UIColor*)textColor{
    self.badgeLb.textColor = textColor;
}

- (CGSize)caculateBadgeWidth:(NSString*)badge{
    if (badge.length <= 0) {
        return CGSizeZero;
    }else{
        CGSize size = [badge boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:RF(11.0f)} context:nil].size;
        size.height = RH(14.0f);
        size.width += RH(8.0f);
        return size;
    }
}

#pragma mark - properties
- (UILabel *)badgeLb{
    return objc_getAssociatedObject(self, @selector(badgeLb));
}

- (void)setBadgeLb:(UILabel *)badgeLb{
    objc_setAssociatedObject(self, @selector(badgeLb), badgeLb, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
