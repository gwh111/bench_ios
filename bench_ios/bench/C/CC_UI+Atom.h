//
//  CC_ShareUI+CC.h
//  bench_ios
//
//  Created by gwh on 2019/11/28.
//

#import "ccs.h"
#import "CC_UI.h"

NS_ASSUME_NONNULL_BEGIN

// Basic shared UI, you can add more by CC_ShareUI's category.
@interface CC_UI (Atom)

- (CC_View *)grayLine;
- (CC_View *)alphaBackground;
- (CC_View *)alphaBackgroundWithAnimation;

- (CC_Label *)dateLabel;
- (CC_Label *)itemTitleLabel;
- (CC_Label *)itemDesLabel;

- (CC_Button *)closeButton;
- (CC_Button *)doneButton;
- (CC_Button *)warningButton;
- (CC_Button *)wordButton;

- (CC_ImageView *)figureImageView;

@end

NS_ASSUME_NONNULL_END
