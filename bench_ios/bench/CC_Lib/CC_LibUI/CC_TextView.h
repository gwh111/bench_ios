//
//  CC_TextView.h
//  bench_ios
//
//  Created by gwh on 2018/3/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "UIView+CCUI.h"
#import "UIScrollView+CCUI.h"
#import "UITextView+CCUI.h"

@interface CC_TextView : UITextView <CC_TextViewChainProtocol,CC_TextViewChainExtProtocol,CC_TextViewChainSelfExtProtocol>

@end

@interface CC_TextView (CCActions)

- (void)bindText:(NSString *)text;
- (void)bindAttText:(NSAttributedString *)attText;

@end
