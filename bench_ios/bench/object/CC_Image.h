//
//  CC_Image.h
//  bench_ios
//
//  Created by gwh on 2017/7/27.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CC_Image : NSObject

+ (UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb;

+ (UIImage*)getImageWithColor:(UIColor*)color width:(CGFloat)width height:(CGFloat)height;

@end
