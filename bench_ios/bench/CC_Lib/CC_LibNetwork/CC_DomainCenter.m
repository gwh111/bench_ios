//
//  CC_DomainCenter.m
//  bench_ios
//
//  Created by ml on 2019/9/27.
//

#import "CC_DomainCenter.h"
#import "CC_HttpHelper.h"

@implementation CC_DomainCenter

+ (instancetype)defaultCenter {
    return [CC_Base.shared cc_registerSharedInstance:self];
}

- (void)setDomainURLs:(NSArray *)domainURLs {
    _domainURLs = domainURLs.copy;
}

@end

NSNotificationName const CCDomainChangedNotification = @"CCDomainChangedNotification";
