//
//  CC_Envirnment.h
//  bench_ios
//
//  Created by gwh on 2017/12/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_Foundation.h"

@interface CC_Envirnment : NSObject

// return: true 为代理环境 可能被抓包 终止访问
+ (BOOL)cc_isProxyStatus;

@end
