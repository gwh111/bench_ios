//
//  RBDeviceName.h
//  Rainbow
//
//  Created by yaya on 2019/8/13.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Foundation.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CC_Device : NSObject

// 获取设备型号名称 只查询一次然后缓存
// @return 设备型号名称，如 iPhone 7、iPhone X、iPad Pro 10.5-inch 等
+ (NSString *)cc_deviceName;

@end

NS_ASSUME_NONNULL_END
