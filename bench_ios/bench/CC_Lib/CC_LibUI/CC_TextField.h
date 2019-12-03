//
//  CC_TextField.h
//  bench_ios
//
//  Created by gwh on 2018/3/27.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "UIView+CCUI.h"
#import "UITextField+CCUI.h"

@interface CC_TextField : UITextField <CC_TextFieldChainProtocol,CC_TextFieldChainExtProtocol>

@end

@interface CC_TextField (CCActions)

- (void)bindText:(NSString *)text;
- (void)bindAttText:(NSAttributedString *)attText;

@end
