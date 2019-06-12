//
//  UITextField+CCCat.m
//  bench_ios
//
//  Created by david on 2019/6/11.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "UITextField+CCCat.h"

@implementation UITextField (CCCat)
/** 检查textField.text的最大长度 (超出截掉)*/
- (void)checkWithMaxLength:(NSUInteger)maxLength {
    //1.获取标记的占位textRange(待确认输入的textRange)
    UITextRange *selectedRange = [self markedTextRange];
    
    //2.获取标记区域的字符串
    NSString *newText = [self textInRange:selectedRange];
    
    //3.如果nextText为空, 且self.text的字数超了 ==> 进行截取
    if (newText.length<1 && self.text.length>maxLength) {
        self.text = [self.text substringToIndex:maxLength];
    }
}
@end
