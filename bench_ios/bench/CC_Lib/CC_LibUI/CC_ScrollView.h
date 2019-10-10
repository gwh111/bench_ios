//
//  CC_ScrollView.h
//  testbenchios
//
//  Created by gwh on 2019/8/5.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CC_ScrollView : UIScrollView

- (__kindof CC_ScrollView *(^)(id<UIScrollViewDelegate>))cc_delegate;

@end

NS_ASSUME_NONNULL_END
