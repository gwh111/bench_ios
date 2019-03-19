//
//  NSString+_CCExtention.m
//  bench_ios
//
//  Created by gwh on 2018/8/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NSString+CCCat.h"

@implementation NSString (CCCat)

#pragma mark common
- (NSArray *)ccWords:(NSString *)cStr{
    
    NSMutableArray *words = [[NSMutableArray alloc] init];
    
    const char *str = [cStr cStringUsingEncoding:NSUTF8StringEncoding];
    
    char *word;
    for (int i = 0; i < strlen(str);) {
        int len = 0;
        if (str[i] >= 0xFFFFFFFC) {
            len = 6;
        } else if (str[i] >= 0xFFFFFFF8) {
            len = 5;
        } else if (str[i] >= 0xFFFFFFF0) {
            len = 4;
        } else if (str[i] >= 0xFFFFFFE0) {
            len = 3;
        } else if (str[i] >= 0xFFFFFFC0) {
            len = 2;
        } else if (str[i] >= 0x00) {
            len = 1;
        }
        
        word = malloc(sizeof(char) * (len + 1));
        for (int j = 0; j < len; j++) {
            word[j] = str[j + i];
        }
        word[len] = '\0';
        i = i + len;
        
        NSString *oneWord = [NSString stringWithCString:word encoding:NSUTF8StringEncoding];
        free(word);
        [words addObject:oneWord];
    }
    
    return words;
}

- (NSString *)correctDecimalLoss
{
    if (self==nil) {
        return nil;
    }
    if (self.length<=0) {
        return @"";
    }
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [self doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

- (NSString *)getDecimalStrWithMode:(NSRoundingMode)roundingMode scale:(short)scale {
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *aDN = [[NSDecimalNumber alloc] initWithString:self];
    NSDecimalNumber *resultDN = [aDN decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    NSString *str=[NSString stringWithFormat:@"%@",resultDN];
    return str;
}

- (CGFloat)heightForWidth:(CGFloat)width font:(UIFont *)font{
    
    if (self.length<=0) {
        return 0;
    }
    CGSize textSize = CGSizeMake(width , CGFLOAT_MAX);
    NSMutableParagraphStyle *parStyle=[[NSMutableParagraphStyle alloc]init];
    parStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary *attributes=@{NSFontAttributeName:font,NSParagraphStyleAttributeName:parStyle };
    return ceil([self boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.height);
}

- (CGFloat)widthForHeight:(CGFloat)height font:(UIFont *)font{
    
    if (self.length<=0) {
        return 0;
    }
    CGSize textSize = CGSizeMake(CGFLOAT_MAX , height);
    NSMutableParagraphStyle *parStyle=[[NSMutableParagraphStyle alloc]init];
    parStyle.lineBreakMode=NSLineBreakByWordWrapping;
    NSDictionary *attributes=@{NSFontAttributeName:font,NSParagraphStyleAttributeName:parStyle };
    return ceil([self boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.width);
}

@end
