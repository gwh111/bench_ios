//
//  CC_ImageView.h
//  CCUILib
//
//  Created by ml on 2019/9/2.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface CC_ImageView : UIImageView

- (__kindof CC_ImageView *)cc_recursive:(void (^)(__kindof UIView *item))closure;

@end

NS_ASSUME_NONNULL_END
