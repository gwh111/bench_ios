//
//  CC_CoreBase.h
//  bench_ios
//
//  Created by gwh on 2019/8/30.
//

#import <Foundation/Foundation.h>
#import "CC_CoreMacro.h"
#import "CC_Object.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark this file is private, do not import
@interface CC_CoreBase : CC_Object

// lifecycle/runloop for moduler
@property (nonatomic,retain) NSMutableDictionary *sharedAppDelegate;

// dispatch_once
@property (nonatomic,retain) NSMutableDictionary *sharedInstanceDic;

@property (nonatomic,retain) NSMutableDictionary *sharedObjDic;
@property (nonatomic,retain) NSMutableDictionary *sharedObjBindDic;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
