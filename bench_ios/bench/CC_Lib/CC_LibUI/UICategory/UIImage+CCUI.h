//
//  UIImage+CCUI.h
//  bench_ios
//
//  Created by gwh on 2020/3/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CCUI)

// xxx.data 格式image
+ (UIImage *)cc_decodeImageNamed:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
