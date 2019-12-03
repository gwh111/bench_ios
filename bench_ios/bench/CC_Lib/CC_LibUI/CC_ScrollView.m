//
//  CC_ScrollView.m
//  testbenchios
//
//  Created by gwh on 2019/8/5.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_ScrollView.h"

@implementation CC_ScrollView

- (__kindof CC_ScrollView *(^)(id<UIScrollViewDelegate>))cc_delegate{
    return ^(id<UIScrollViewDelegate> _) { self.delegate = _; return self; };
}

@end
