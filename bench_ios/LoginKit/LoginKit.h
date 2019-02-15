//
//  LoginKit.h
//  bench_ios
//
//  Created by gwh on 2019/2/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAPI_ONE_AUTH_LOGIN.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginKit : NSObject

@property (nonatomic,retain) CC_HttpTask *httpTask;

+ (instancetype)getInstance;

- (void)setUrlStr:(NSString *)str;
- (NSURL *)getUrl;

- (CC_HttpTask *)getHttpTask;

@end

NS_ASSUME_NONNULL_END
