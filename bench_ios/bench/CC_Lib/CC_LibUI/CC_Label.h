//
//  CC_Label.h
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"
#import "CC_View.h"

#import "UIView+CCUI.h"
#import "UILabel+CCUI.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_Label : UILabel <CC_LabelChainProtocol,CC_LabelChainExtProtocol>

@end

// MARK: - Actions -

@interface CC_Label (CCActions)

- (void)bindText:(NSString *)text;
- (void)bindAttText:(NSAttributedString *)attText;

@end

NS_ASSUME_NONNULL_END
