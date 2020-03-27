//
//  CC_Tool+Validate.h
//  bench_ios
//
//  Created by gwh on 2020/3/23.
//

#import "CC_Tool.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_Tool (Validate)

- (BOOL)isSimuLator;
- (BOOL)isEmpty:(id)obj;
- (BOOL)isJailBreak;
- (BOOL)isInstallFromAppStore;

@end

NS_ASSUME_NONNULL_END
