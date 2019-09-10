//
//  CC_CoreFoundation.h
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#ifndef CC_CoreFoundation_h
#define CC_CoreFoundation_h

#define BENCH_IOS_VERSION @"2.0.0"
#define BENCH_IOS_VERSION_URL @"http://bench-ios.oss-cn-shanghai.aliyuncs.com/bench_ios_verion.json"

#define BENCH_IOS_NET_TEST_URL @"http://d.net/"
#define BENCH_IOS_NET_TEST_CONTAIN @"http://d.net/"
#define BENCH_IOS_NET_TEST_SERVICE @"/client/service.json?service=TEST"// 测试域名是否可用的服务端地址

#include <CoreFoundation/CoreFoundation.h>
#import "CC_Monitor.h"
#import "CC_CoreMacro.h"
#import "CC_Base.h"
#import "CC_Message.h"
#import "CC_Runtime.h"

#import "CC_Delegate.h"
#import "CC_Int.h"
#import "CC_Float.h"
#import "CC_Double.h"

#endif /* CC_CoreFoundation_h */
