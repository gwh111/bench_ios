//
//  CC_Money.m
//  bench_ios
//
//  Created by gwh on 2019/11/11.
//

#import "CC_Money.h"
#import "CC_Base.h"
#import "CC_Lib+NSString.h"

@implementation CC_Money

- (NSString *)moneyWithString:(NSString *)money {
    
    if ([money hasSuffix:@"."]) {
        money = [money substringToIndex:money.length - 1];
    }
    money = [money cc_convertToDecimalStr:NSRoundBankers scale:2];
    _value = money;
    
    _number = _value.doubleValue;
    return _value;
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
