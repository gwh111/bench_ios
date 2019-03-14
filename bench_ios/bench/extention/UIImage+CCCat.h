//
//  UIImage+QRScale.h
//  Pods
//
//  Created by xulihua on 15/12/9.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (CCCat)

/**
 *  把图片调整到新的大小
 */
-(UIImage *)transformToSize:(CGSize)newSize;
/**
 *  给一个图片添加一个底
    insets 边缘
    例子：UIImage *image = [img imageByInsetEdge:UIEdgeInsetsMake(-20, -20, -20, -20) withColor:COLOR_WHITE];
 */
- (UIImage *)imageByInsetEdge:(UIEdgeInsets)insets withColor:(UIColor *)color;

@end
