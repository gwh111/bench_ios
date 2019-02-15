//
//  MAPI_ONE_AUTH_LOGIN.m
//  bench_ios
//
//  Created by gwh on 2019/2/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MAPI_ONE_AUTH_LOGIN.h"
#import "LoginKit.h"

@interface MAPI_ONE_AUTH_LOGIN(){
    
}
@end

@implementation MAPI_ONE_AUTH_LOGIN

- (instancetype)initWithCell:(NSString *)cell loginPassword:(NSString *)loginPassword selectedDefaultUserToLogin:(BOOL)selectedDefaultUserToLogin
{
    self = [super init];
    if (self) {
        self.cell=cell;
        self.loginPassword=loginPassword;
        self.selectedDefaultUserToLogin=selectedDefaultUserToLogin;
    }
    return self;
}

- (void)requestAtView:(UIView *)view mask:(BOOL)mask block:(void (^)(NSDictionary *, ResModel *))block{
    
    if (mask) {
        UIView *showV;
        if (view) {
            showV=view;
        }else{
            showV=[CC_Code getAView];
        }
        [[CC_Mask getInstance]startAtView:showV];
    }
    
    NSMutableDictionary *para = [[NSMutableDictionary alloc] init];
    [para setObject:@"ONE_AUTH_LOGIN" forKey:@"service"];
    [para setObject:_loginPassword forKey:@"loginPassword"];
    [para setObject:_cell forKey:@"cell"];
    [para setObject:@(_selectedDefaultUserToLogin) forKey:@"selectedDefaultUserToLogin"];
    
    [[[LoginKit getInstance]getHttpTask] post:[[LoginKit getInstance]getUrl] params:para model:nil finishCallbackBlock:^(NSString *error, ResModel *resmodel) {
        
        if (error) {
            
            [self errorTask:error model:resmodel atView:view block:block];
            
        }else
        {
            block(nil,resmodel);
        }
        
        if (mask) {
            [[CC_Mask getInstance] stop];
        }
    }];
}

- (void)errorTask:(NSString *)error model:(ResModel *)resmodel atView:(UIView *)view block:(void (^)(NSDictionary *, ResModel *))block{
    if ([error isEqualToString:@"登录密码错误"]) {
        [CC_Notice showNoticeStr:@"账号或密码有误" atView:view];
    }else if([error isEqualToString:@"重试次数太多，拒绝认证"])
    {
        [CC_Notice showNoticeStr:resmodel.resultDic[@"response"][@"detailMessage"] atView:view];
    }else
    {
        [CC_Notice showNoticeStr:error atView:view];
    }
    
    if ([resmodel.resultDic[@"response"][@"error"][@"name"] isEqualToString:@"LOGIN_FORBIDDEN"]) {
        NSDictionary *responseDic = [resmodel.resultDic objectForKey:@"response"];
        NSString *forBidReasonStr = [NSString stringWithFormat:@"冻结理由：%@",[responseDic[@"resultMap"] objectForKey:@"forbiddenReason"]];
        NSString *gmtExpiredTimeStr = [NSString stringWithFormat:@"解冻时间：%@",[responseDic[@"resultMap"] objectForKey:@"gmtEnd"]];
        
        NSDictionary *errorDic=@{@"name":error,@"forBidReason":forBidReasonStr,@"gmtExpiredTime":gmtExpiredTimeStr};
        block(errorDic,resmodel);
    }else{
        
//        block(@{@"name":error},resmodel);
    }
}

@end
