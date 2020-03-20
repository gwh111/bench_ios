//
//  ccs+Domain.h
//  bench_ios
//
//  Created by Shepherd on 2019/10/10.
//

#import "ccs.h"

NS_ASSUME_NONNULL_BEGIN

@interface ccs (DebugMenu)

@end

@interface CC_Label (DebugMenu)

/// 是否出现调试菜单 [参数](YES/NO)
- (__kindof CC_Label* (^)(BOOL))cc_enableDebugMode;

@end

NS_ASSUME_NONNULL_END
