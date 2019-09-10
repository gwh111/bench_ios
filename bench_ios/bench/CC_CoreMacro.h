//
//  CC_CoreMacro.h
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#ifndef CC_CoreMacro_h
#define CC_CoreMacro_h

#import <Foundation/NSException.h>

#ifdef TARGET_IPHONE_SIMULATOR
//XXXXX  模拟器时会编译的代码
#else
//XXXXX  不是模拟器才会编译的代码
#endif

#ifdef DEBUG
#   define CCLOG(fmt, ...) NSLog((@"%s [Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define CCLOG(...)
#endif

#ifdef DEBUG
#   define CCLOGAssert(fmt, ...) NSLog((@"%@: " fmt), @"error", ##__VA_ARGS__);NSAssert(0,nil);
#else
#   define CCLOGAssert(...)
#endif

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SS(strongSelf)  __strong __typeof(&*weakSelf)strongSelf = weakSelf;

#define CC_DEPRECATED(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

#define SAFE_CALL_BLOCK(blockFunc, ...)    \
if (blockFunc) {                        \
blockFunc(__VA_ARGS__);              \
}

#define LOCK(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
#define UNLOCK(lock) dispatch_semaphore_signal(lock);

#endif /* CC_CoreMacro_h */
