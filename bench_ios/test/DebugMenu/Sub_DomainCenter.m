//
//  Sub_DomainCenter.m
//  bench_ios
//
//  Created by ml on 2019/9/27.
//

#import "Sub_DomainCenter.h"
#import "CC_HttpHelper.h"
#import "ccs.h"

@implementation Sub_DomainCenter

+ (void)load {
    [ccs registerAppDelegate:self];
}

- (BOOL)cc_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setURLsAction:) name:CCDomainLaunchNotification object:nil];
    return YES;
}

- (void)setURLsAction:(NSNotification *)sender {
    if ([sender.name isEqualToString:CCDomainLaunchNotification]) {
        if ([sender.object isKindOfClass:NSArray.class]) {
            _domainURLs = [sender.object copy];
        }
    }
}

@end
