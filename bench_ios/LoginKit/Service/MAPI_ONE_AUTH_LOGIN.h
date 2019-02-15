//
//  MAPI_ONE_AUTH_LOGIN.h
//  bench_ios
//
//  Created by gwh on 2019/2/14.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAPI_ONE_AUTH_LOGIN : NSObject

/**
 *  手机号
 */
@property (nonatomic,retain) NSString * _Nonnull cell;
/**
 *  登录密码
 */
@property (nonatomic,retain) NSString * _Nonnull loginPassword;
/**
 *使用默认角色登录
 */
@property (nonatomic,assign) BOOL selectedDefaultUserToLogin;


@property (nonatomic,retain) NSString * _Nullable xxx;

- (instancetype)initWithCell:(NSString *)cell loginPassword:(NSString *)loginPassword selectedDefaultUserToLogin:(BOOL)selectedDefaultUserToLogin;

- (void)requestAtView:(UIView *)view mask:(BOOL)mask block:(void (^)(NSDictionary *modifiedDic, ResModel *result))block;

@end

NS_ASSUME_NONNULL_END
