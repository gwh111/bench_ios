//
//  CC_WebImageConfig.h
//  CCWebImageDemo
//
//  Created by 路飞 on 2019/4/19.
//  Copyright © 2019 路飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CC_Share.h"

@protocol CC_WebImageOperationDelegate <NSObject>

- (void)cancelOperation;

@end

#ifndef CC_WebImageConfig_h
#define CC_WebImageConfig_h

#ifndef dispatch_queue_async_safe
#define dispatch_queue_async_safe(queue, block)\
if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(queue)) {\
block();\
} else {\
dispatch_async(queue, block);\
}
#endif

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block) dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif

#endif /* CC_WebImageConfig_h */
