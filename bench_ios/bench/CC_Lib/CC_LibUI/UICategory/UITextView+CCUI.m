//
//  UITextView+CCUI.m
//  bench_ios
//
//  Created by ml on 2019/9/9.
//

#import "UITextView+CCUI.h"

@implementation UITextView (CCUI)

- (UITextView *(^)(NSString *))cc_text{
    return ^(NSString *_) {
        if (_) {
            self.text = _;
        }
        return self;
    };
}

- (UITextView *(^)(UIFont *))cc_font{
    return ^(UIFont *_) { self.font = _; return self; };
}

- (UITextView *(^)(UIColor *))cc_textColor{
    return ^(UIColor *_){ self.textColor = _; return self; };
}

- (UITextView *(^)(NSRange))cc_selectedRange{
    return ^(NSRange _) { self.selectedRange = _; return self; };
}

- (UITextView *(^)(BOOL))cc_editable{
    return ^(BOOL _) { self.editable = _; return self; };
}

- (UITextView *(^)(BOOL))cc_selectable{
    return ^(BOOL _) { self.selectable = _; return self; };
}

- (UITextView *(^)(UIDataDetectorTypes))cc_dataDetectorTypes{
    return ^(UIDataDetectorTypes _) { self.dataDetectorTypes = _; return self; };
}

- (UITextView *(^)(NSTextAlignment))cc_textAlignment{
    return ^(NSTextAlignment _) { self.textAlignment = _; return self; };
}

- (UITextView *(^)(id<UITextViewDelegate>))cc_delegate{
    return ^(id<UITextViewDelegate> _) { self.delegate = _; return self; };
}

@end

@implementation UITextView (CCActions)

- (void)cc_cutWithMaxLength:(NSUInteger)maxLength {
    //1.获取标记的占位textRange(待确认输入的textRange)
    UITextRange *selectedRange = [self markedTextRange];
    
    //2.获取标记区域的字符串
    NSString *newText = [self textInRange:selectedRange];
    
    //3.如果nextText为空, 且self.text的字数超了 ==> 进行截取
    if (newText.length<1 && self.text.length>maxLength) {
        self.text = [self.text substringToIndex:maxLength];
    }
}

- (float)cc_heightForWidth:(float)width{
    CGSize sizeToFit = [self sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}

- (float)cc_widthForHeight:(float)height{
    CGSize sizeToFit = [self sizeThatFits:CGSizeMake(MAXFLOAT, height)];
    return sizeToFit.width;
}

@end
