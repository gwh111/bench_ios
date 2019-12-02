//
//  CC_ShareUI+CC.h
//  bench_ios
//
//  Created by gwh on 2019/11/28.
//

#import "ccs.h"
#import "CC_ShareUI.h"

NS_ASSUME_NONNULL_BEGIN

// Basic shared UI, you can add more by CC_ShareUI's category.
@interface CC_ShareUI (CC)

- (CC_View *)grayLine;

- (CC_Label *)dateLabel;

- (CC_Button *)closeButton;
- (CC_Button *)disabledDoneButton;

@end

NS_ASSUME_NONNULL_END
