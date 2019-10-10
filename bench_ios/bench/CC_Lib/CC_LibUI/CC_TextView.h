//
//  CC_TextView.h
//  bench_ios
//
//  Created by gwh on 2018/3/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "CCUIScaffold.h"
#import "UITextView+CCUI.h"

@interface CC_TextView : UITextView <CC_TextView>

@end

@interface CC_TextView (CCActions)

- (__kindof CC_TextView *(^)(NSString *))cc_bindText;
- (__kindof CC_TextView *(^)(NSAttributedString *))cc_bindAttText;

- (void)bindText:(NSString *)text;
- (void)bindAttText:(NSAttributedString *)attText;

@end
