//
//  Test_EncryptViewController.m
//  bench_ios
//
//  Created by 路飞 on 2019/9/23.
//

#import "Test_EncryptViewController.h"
#import "ccs.h"
#import "CC_HttpEncryption.h"

@interface Test_EncryptViewController ()

@end

@implementation Test_EncryptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CC_HttpEncryption *encryption = ccs.httpEncryption;
    CC_HttpConfig *config = ccs.httpConfig;
    NSMutableDictionary *headers = ccs.mutDictionary;
    [headers setObject:@"qyys" forKey:@"appCode"];
    [headers setObject:@"yiliao_doctor_ios" forKey:@"appName"];
    [headers setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"appVersion"];
    [headers setObject:ccs.keychainUUID forKey:@"appDeviceId"];
    config.httpHeaderFields = headers;
    config.encryptDomain=@"xxx";
    CC_HttpTask.shared.configure = config;
    
    [encryption prepare:^{
        //1.生成AESCode，并保存
        //2.获取RSAPublicKey
        //3.使用RSAPublicKey加密AESCode，并上传服务端
        //4.每次请求使用AESCode对请求参数进行加密
        
        //加密配置完成
        
    }];
    
}
@end
