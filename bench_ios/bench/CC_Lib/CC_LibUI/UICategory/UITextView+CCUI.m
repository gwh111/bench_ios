//
//  UITextView+CCUI.m
//  bench_ios
//
//  Created by ml on 2019/9/9.
//

#import "UITextView+CCUI.h"

@implementation UITextView (CCUI)

- (__kindof UITextView *(^)(NSString *))cc_text{
    return ^(NSString *text){
        self.text = text;
        return self;
    };
}

- (__kindof UITextView *(^)(UIFont *))cc_font{
    return ^(UIFont *font){
        self.font = font;
        return self;
    };
}

- (__kindof UITextView *(^)(UIColor *))cc_textColor{
    return ^(UIColor *textColor){
        self.textColor = textColor;
        return self;
    };
}

- (__kindof UITextView *(^)(NSRange))cc_selectedRange{
    return ^(NSRange selectedRange){
        self.selectedRange = selectedRange;
        return self;
    };
}

- (__kindof UITextView *(^)(BOOL))cc_editable{
    return ^(BOOL editable){
        self.editable = editable;
        return self;
    };
}

- (__kindof UITextView *(^)(BOOL))cc_selectable{
    return ^(BOOL selectable){
        self.selectable = selectable;
        return self;
    };
}

- (__kindof UITextView *(^)(UIDataDetectorTypes))cc_dataDetectorTypes{
    return ^(UIDataDetectorTypes dataDetectorTypes){
        self.dataDetectorTypes = dataDetectorTypes;
        return self;
    };
}

- (__kindof UITextView *(^)(NSTextAlignment))cc_textAlignment{
    return ^(NSTextAlignment textAlignment){
        self.textAlignment = textAlignment;
        return self;
    };
}

- (__kindof UITextView *(^)(id<UITextViewDelegate>))cc_delegate{
    return ^(id<UITextViewDelegate> delegate){
        self.delegate = delegate;
        return self;
    };
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
