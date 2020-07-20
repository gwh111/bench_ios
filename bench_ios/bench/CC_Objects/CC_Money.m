//
//  CC_Money.m
//  bench_ios
//
//  Created by gwh on 2019/11/11.
//

#import "CC_Money.h"
#import "CC_Base.h"
#import "NSString+CC_Foundation.h"

@implementation CC_Money

+ (CC_Money *)moneyWithInt:(int)number {
    
    NSString *moneyStr = [NSString stringWithFormat:@"%d",number];
    CC_Money *money = [CC_Money moneyWithString:moneyStr];
    return money;
}

+ (CC_Money *)moneyWithFloat:(float)number {
    
    NSString *moneyStr = [NSString stringWithFormat:@"%f",number];
    CC_Money *money = [CC_Money moneyWithString:moneyStr];
    return money;
}

+ (CC_Money *)moneyWithString:(NSString *)str {
    
    str = [NSString stringWithFormat:@"%@",str];
    CC_Money *money = CC_Money.new;
    
    if ([str hasSuffix:@"."]) {
        str = [str substringToIndex:str.length - 1];
    }
    str = [str cc_convertToDecimalStr:NSRoundPlain scale:2];
    money.value = str;
    money.number = money.value.doubleValue;
    money.moneyValue = [NSString stringWithFormat:@"%.2f",money.number];
    return money;
}

- (void)addMoney:(CC_Money *)add {
    
    double v = _value.doubleValue;
    double a = add.value.doubleValue;
    double total = v + a;
    _value = [NSString stringWithFormat:@"%f", total];
    _value = [_value cc_convertToDecimalStr:NSRoundBankers scale:2];
    
    _number = _value.doubleValue;
}

- (void)cutMoney:(CC_Money *)cut {
    
    double v = _value.doubleValue;
    double c = cut.value.doubleValue;
    double total = v - c;
    _value = [NSString stringWithFormat:@"%f", total];
    _value = [_value cc_convertToDecimalStr:NSRoundBankers scale:2];
    
    _number = _value.doubleValue;
}

@end
