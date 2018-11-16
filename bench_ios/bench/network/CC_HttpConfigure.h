//
//  CC_HttpConfigure.h
//  bench_ios
//
//  Created by gwh on 2018/11/5.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Confi : NSObject

@property(nonatomic,assign) int net;//0线上 1线下 2线下第二个地址 ...
@property(nonatomic,assign) BOOL showLog;

/**
 *  key:bundId+bundleVersion
    {"com.app.bench-ios1.11":{"net": "2","debugLog": "1"}}
    key:build+bundId+buildVersion 优先级高
    {"buildcom.app.bench-ios1.112":{"net": "2","debugLog": "1"}}
    http://bench-ios.oss-cn-shanghai.aliyuncs.com/bench.json
 */
@property(nonatomic,retain) NSDictionary *resultDic;

@end

NS_ASSUME_NONNULL_END
