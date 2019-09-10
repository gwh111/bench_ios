//
//  CC_Delegate.m
//  bench_ios
//
//  Created by gwh on 2019/8/29.
//

#import "CC_Delegate.h"
#import "CC_Message.h"

@implementation CC_Delegate
@synthesize delegate;

- (void)cc_performSelector:(SEL)selector params:(id)param,...{
    if (delegate && [delegate respondsToSelector:selector]) {
        NSMethodSignature *signature = [delegate methodSignatureForSelector:selector];
        NSInteger paramsCount = signature.numberOfArguments - 2;
        NSMutableArray *paramsList = NSMutableArray.new;
        va_list params;
        va_start(params, param);
        int i = 0;
        for (id tmpObject = param; (id)tmpObject; tmpObject = va_arg(params, id)) {
            if (tmpObject) {
                [paramsList addObject:tmpObject];
            }else{
                [paramsList addObject:NSNull.new];
            }
            i++;
            if (i >= paramsCount) {
                break;
            }
        }
        va_end(params);
        [cc_message cc_instance:delegate method:selector paramList:paramsList];
    }
}

@end
