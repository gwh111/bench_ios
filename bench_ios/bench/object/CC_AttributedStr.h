//
//  AppAttributedStr.h
//  JCZJ
//
//  Created by apple on 16/12/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CC_AttributedStr : NSObject

/** 添加有颜色的字符*/
+ (NSMutableAttributedString *)getOrigAttStr:(NSMutableAttributedString *)origAttStr appendStr:(NSString *)appendStr withColor:(UIColor *)color;
+ (NSMutableAttributedString *)getOrigAttStr:(NSMutableAttributedString *)origAttStr appendStr:(NSString *)appendStr withColor:(UIColor *)color andFont:(UIFont *)font;

/** 根据宽度和字体计算label高度*/
+ (CGFloat)heightForLableWithStr:(NSString *)text lableWidth:(CGFloat)lableWidth font:(UIFont *)font;

/** 根据高度和字体计算label宽度*/
+ (CGFloat)lengthForLableWithStr:(NSString *)text lableHeight:(CGFloat)lableHeight font:(UIFont *)font;

/** 计算textview的高度*/
- (float)heightForStr:(UITextView *)textView andWidth:(float)width;
/** 计算textview的宽度*/
- (float)widthForStr:(UITextView *)textView andHeight:(float)height;

/** 替换html标签
    原字符
    tagName 要替换的标签名 nil表示所有标签
    toStr 替换成 替换成nil表示删除标签
    trim 过滤空格
 */
- (NSString *)cutHtmlTagFromStr:(NSString *)htmlStr withTagName:(NSString *)tagNameStr toStr:(NSString *)replaceStr trimSpace:(BOOL)trim;

@end

