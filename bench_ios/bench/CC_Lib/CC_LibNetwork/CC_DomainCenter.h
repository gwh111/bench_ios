//
//  CC_DomainCenter.h
//  bench_ios
//
//  Created by ml on 2019/9/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// TODO
@interface CC_DomainCenter : NSObject

@property (nonatomic,copy) NSArray *domainURLs;

+ (instancetype)defaultCenter;

@end

FOUNDATION_EXPORT NSNotificationName const CCDomainChangedNotification;

NS_ASSUME_NONNULL_END
