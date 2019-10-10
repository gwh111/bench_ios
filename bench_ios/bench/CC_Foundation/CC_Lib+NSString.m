//
//  NSString+CC.m
//  testbenchios
//
//  Created by gwh on 2019/8/1.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Lib+NSString.h"
#import "CC_Base.h"

@implementation NSString (CC_Lib)

#pragma mark function
- (void)cc_update:(NSString *)str{
    NSString *textAddress = [NSString stringWithFormat:@"%p",self];
    NSString *address = [CC_Base.shared cc_bind:textAddress];
    if (!address) {
        return;
    }
    // So this works. That being said, I would be very uncomfortable relying on this in a project of mine. If that variable gets released before you scan its address, who knows what you're going to get. In that respect, I guess that breaks the "ARC compatible" criterion because who knows when that reference will get released which makes this very dangerous. Also, type safety is totally out the window.
    // 必须明确知道地址对应的对象是否存在，否则在ARC中是不安全的
    
    address = [address hasPrefix:@"0x"]?address:[@"0x" stringByAppendingString:address];
    unsigned long long hex = strtoull(address.UTF8String, NULL, 0);
    id gotcha = (__bridge id)(void *)hex;
    if ([gotcha isKindOfClass:[UILabel class]]) {
        UILabel *obj = gotcha;
        obj.text = str;
    }else if ([gotcha isKindOfClass:[UITextView class]]) {
        UITextView *obj = gotcha;
        obj.text = str;
    }else if ([gotcha isKindOfClass:[UITextField class]]) {
        UITextField *obj = gotcha;
        obj.text = str;
    }else if ([gotcha isKindOfClass:[UIButton class]]) {
        UIButton *obj = gotcha;
        [obj setTitle:str forState:UIControlStateNormal];
    }
}

- (NSArray *)cc_convertToWord{
    NSMutableArray *words = [[NSMutableArray alloc] init];
    const char *str = [self cStringUsingEncoding:NSUTF8StringEncoding];
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
            word[j] = str[j+i];
        }
        word[len] = '\0';
        i = i+len;
        
        NSString *oneWord = [NSString stringWithCString:word encoding:NSUTF8StringEncoding];
        free(word);
        [words addObject:oneWord];
    }
    return words;
}

- (NSString *)cc_convertToUrlString{
    NSMutableCharacterSet *allowed = [NSMutableCharacterSet alphanumericCharacterSet];
    [allowed addCharactersInString:@"!*'();:@&=+$,/?%#[]<>&\\"];
    [self stringByAddingPercentEncodingWithAllowedCharacters:allowed];
    return self;
}

- (NSData *)cc_convertToUTF8data{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSData *)cc_convertToBase64data{
    NSData *ciphertextdata = [[NSData alloc]initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return ciphertextdata;
}

- (NSDate *)cc_convertToDateWithformatter:(NSString *)formatterStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    if (formatterStr) {
        [dateFormatter setDateFormat:formatterStr];
    }else{
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }
    NSDate *resDate = [dateFormatter dateFromString:self];
    return resDate;
}

- (NSDate *)cc_convertToDate{
    return [self cc_convertToDateWithformatter:nil];
}

- (NSString *)cc_convertToDecimalLosslessString{
    if (self == nil) {
        return nil;
    }
    if (self.length <= 0) {
        return @"";
    }
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [self doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

- (NSString *)cc_convertToDecimalStr:(NSRoundingMode)roundingMode scale:(short)scale{
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *aDN = [[NSDecimalNumber alloc] initWithString:self];
    NSDecimalNumber *resultDN = [aDN decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    NSString *str = [NSString stringWithFormat:@"%@",resultDN];
    return str;
}

- (NSString *)cc_removeSuffixZero:(NSString *)numberStr {
    if (numberStr.length > 1) {
        
        if ([numberStr componentsSeparatedByString:@"."].count == 2) {
            NSString *last = [numberStr componentsSeparatedByString:@"."].lastObject;
            if ([last isEqualToString:@"00"]) {
                numberStr = [numberStr substringToIndex:numberStr.length - (last.length + 1)];
                return numberStr;
            }else{
                if ([[last substringFromIndex:last.length -1] isEqualToString:@"0"]) {
                    numberStr = [numberStr substringToIndex:numberStr.length - 1];
                    return numberStr;
                }
            }
        }
        return numberStr;
    }else{
        return numberStr;
    }
}

#pragma mark is
- (BOOL)cc_isPureInt{
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)cc_isPureLetter{
    if (self.length == 0) {
        return NO;
    }
    NSString *regex =@"[a-zA-Z]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)cc_isPureChinese{
    for (int i = 0; i < self.length; i++){
        int a = [self characterAtIndex:i];
        if(a > 0x4e00 && a <0x9fff){
            
        }else{
            return NO;
        }
    }
    return YES;
}

- (BOOL)cc_isNumberWordChinese{
    NSString *regex = @"[a-zA-Z0-9\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    if(isMatch==0){
        return NO;
    }
    return YES;
}

- (BOOL)cc_hasChinese{
    for(int i = 0; i < [self length]; i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)cc_isMobileCell{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((12[0-9])|(13[0,0-9])|(14[0,0-9])|(15[0,0-9])|(16[0,0-9])|(17[0,0-9])|(18[0,0-9])|(19[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)cc_isEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

#pragma mark private function
- (void)dealloc{
    
}

@end

@implementation NSMutableAttributedString (CC_Lib)

- (void)cc_appendAttStr:(NSString *)appendStr color:(UIColor *)color{
    [self cc_appendAttStr:appendStr color:color font:nil];
}

- (void)cc_appendAttStr:(NSString *)appendStr color:(UIColor *)color font:(UIFont *)font{
    if (!appendStr || appendStr.length == 0) {
        return;
    }
    NSMutableAttributedString *appendAttStr = [[NSMutableAttributedString alloc]initWithString:appendStr];
    [appendAttStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0,appendAttStr.length)];
    if (font) {
        [appendAttStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,appendAttStr.length)];
    }
    NSAttributedString *att = [[NSAttributedString alloc]initWithAttributedString:appendAttStr];
    [self appendAttributedString:att];
}

@end
