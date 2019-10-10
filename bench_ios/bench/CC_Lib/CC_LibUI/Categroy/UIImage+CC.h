//
//  UIImage+CC.h
//  bench_ios
//
//  Created by ml on 2019/9/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CC)

- (UIImage *)cc_scaleToKb:(NSInteger)kb;

- (NSData *)cc_compressWithMaxLength:(NSUInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
