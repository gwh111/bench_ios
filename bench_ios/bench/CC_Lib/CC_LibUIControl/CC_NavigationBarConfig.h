//
//  CC_NavigationBarConfig.h
//  bench_ios
//
//  Created by gwh on 2019/9/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CC_NavigationBarType) {
    CC_NavigationBarTypeLight, // 浅色背景，会用灰色后退按钮
    CC_NavigationBarTypeDark, // 深色背景，会用白色后退按钮
};

@interface CC_NavigationBarConfig : NSObject

@property (nonatomic,assign) CC_NavigationBarType cc_navigationBarType;
@property (nonatomic,strong) UIFont *cc_navigationBarTitleFont;
@property (nonatomic,strong) UIColor *cc_navigationBarTitleColor;
@property (nonatomic,strong) UIColor *cc_navigationBarBackgroundColor;
@property (nonatomic,strong) UIImage *cc_navigationBarBackgroundImage;
@property (nonatomic,assign) BOOL hiddenLine;

@end

NS_ASSUME_NONNULL_END
