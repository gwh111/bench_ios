//
//  UISwitch+CCUI.h
//  bench_ios
//
//  Created by ml on 2019/9/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISwitch (CCUI)

/// The color used to tint the appearance of the switch when it is turned on.
- (UISwitch *(^)(UIColor *))cc_onTintColor;

/// The color used to tint the outline of the switch when it is turned off.
- (UISwitch *(^)(UIColor *))cc_tintColor;

/// The color used to tint the appearance of the thumb.
- (UISwitch *(^)(UIColor *))cc_thumbTintColor;

/// In iOS 6 and earlier, the image displayed when the switch is in the on position.
/// In iOS 7 and later, this property has no effect.
- (UISwitch *(^)(UIImage *))cc_onImage;

/// In iOS 6 and earlier, the image displayed when the switch is in the off position.
/// In iOS 7 and later, this property has no effect.
- (UISwitch *(^)(UIImage *))cc_offImage;

/// A Boolean value that determines the off/on state of the switch.
- (UISwitch *(^)(BOOL))cc_on;


@end

NS_ASSUME_NONNULL_END
