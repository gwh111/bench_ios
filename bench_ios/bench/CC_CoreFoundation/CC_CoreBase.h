//
//  CC_CoreBase.h
//  bench_ios
//
//  Created by gwh on 2019/8/30.
//

#import <Foundation/Foundation.h>
#import "CC_CoreMacro.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark this file is private, do not import
@interface CC_CoreBase : NSObject

// lifecycle/runloop for moduler
@property (nonatomic,retain) NSMutableDictionary *cc_sharedAppDelegate;

// dispatch_once
@property (nonatomic,retain) NSMutableDictionary *sharedInstanceDic;

@property (nonatomic,retain) NSMutableDictionary *sharedObjDic;
@property (nonatomic,retain) NSMutableDictionary *sharedObjBindDic;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
