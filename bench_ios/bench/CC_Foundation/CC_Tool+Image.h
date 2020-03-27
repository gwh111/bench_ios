//
//  CC_Tool+Image.h
//  bench_ios
//
//  Created by gwh on 2020/3/24.
//

#import "CC_Tool.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CC_Tool (Image)

- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)targetSize;

- (UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb;

- (NSData *)scaleImage:(UIImage *)image toMaxLength:(NSUInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
