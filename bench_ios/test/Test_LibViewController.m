//
//  Test_LibViewController.m
//  bench_ios
//
//  Created by relax on 2019/8/27.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "Test_LibViewController.h"
#import "ccs.h"

@interface Test_LibViewController ()

@end

@implementation Test_LibViewController

- (void)cc_viewWillLoad {
    
    self.cc_baseView.cc_backgroundColor(UIColor.whiteColor);
    self.title = @"Test_LibViewController";

//    [self test_libSecurity];
//    [self test_libStorage];
//    [self test_LibWebImage];
}

- (void)test_libSecurity
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"123" forKey:@"123"];
    
    NSString *str1 = [ccs function_MD5SignWithDic:dic andMD5Key:@"123"];
    CCLOG(@" function_MD5SignWithDic %@",str1);
    
    NSString *str2 = [ccs function_MD5SignValueWithDic:dic andMD5Key:@"123"];
    CCLOG(@" function_MD5SignValueWithDic %@",str2);
}

- (void)test_libStorage
{
    //KeyChain
    CCLOG(@" ccs.keychainUUID %@",ccs.keychainUUID);
    [ccs saveKeychainKey:@"xin" value:@"yi"];
    CCLOG(@" keychainKey xin %@",[ccs keychainKey:@"xin"]);
    
    //NSUserDefaults
    [ccs saveDefaultKey:@"haha" value:@"hahaha"];
    id defaultKeyObj = [ccs defaultKey:@"haha"];
    CCLOG(@" defaultKeyObj %@",defaultKeyObj);
    
    [ccs saveSafeDefaultKey:@"wawa" value:@"wawawa"];
    id safeDefaultKeyObj = [ccs safeDefaultKey:@"wawa"];
    CCLOG(@" safeDefaultKeyObj %@",safeDefaultKeyObj);
    
    //NSBundle
    CCLOG(@" ccs.appName %@",ccs.appName);
    CCLOG(@" ccs.appBid  %@",ccs.appBid);
    CCLOG(@" ccs.appVersion %@",ccs.appVersion);
    CCLOG(@" ccs.appBundle %@",ccs.appBundle);
    CCLOG(@" ccs.appBundleVersion %@",ccs.appBundleVersion);
    
    NSData *bundleData = [ccs bundleFileWithPath:@"IMG_3058" type:@"JPG"];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageWithData:bundleData]];
    CCLOG(@" image %@",image);
    
    NSDictionary *bundleDict = [ccs bundlePlistWithPath:@"testList"];
    CCLOG(@" bundlePlistWithPath %@",bundleDict);
    
    BOOL isCopy = [ccs copyBunldFileToSandboxToPath:@"testList" type:@"plist"];
    CCLOG(@" copyBunldFileToSandboxToPath %@",@(isCopy));
    
    //Sandbox
    NSData *sbData = [ccs sandboxFileWithPath:@"testList" type:@"plist"];
    NSDictionary *sbDict = [NSJSONSerialization JSONObjectWithData:sbData options:NSJSONReadingMutableLeaves error:nil];
    CCLOG(@" sandboxFileWithPath %@",sbDict);
    
    BOOL isDelete = [ccs deleteSandboxFileWithName:@"testList"];
    CCLOG(@" deleteSandboxFileWithName %@",@(isDelete));
}

- (void)test_LibWebImage
{
    [ccs.imageView
     .cc_frame(100, 100, 200, 200)
     .cc_addToView(self)
     .cc_backgroundColor(UIColor.blackColor) cc_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566999335305&di=22c5663904d50bd2d434666f94676e5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201505%2F03%2F20150503095835_zmSRT.jpeg"]];
    
    [ccs.imageView
     .cc_frame(100, 300, 200, 200)
     .cc_addToView(self)
     .cc_backgroundColor(UIColor.blackColor) cc_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566999335305&di=22c5663904d50bd2d434666f94676e5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201505%2F03%2F20150503095835_zmSRT.jpeg"] placeholderImage:[UIImage imageNamed:@""] showProgressView:YES completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {

     }];
    
    [ccs.imageView
     .cc_frame(100, 500, 200, 200)
     .cc_addToView(self)
     .cc_backgroundColor(UIColor.blackColor) cc_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566999335305&di=22c5663904d50bd2d434666f94676e5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201505%2F03%2F20150503095835_zmSRT.jpeg"] placeholderImage:[UIImage imageNamed:@""] processBlock:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
         CCLOG(@" setImageWithURL process receivedSize = %ld expectedSize = %ld targetURL = %@",(long)receivedSize,(long)expectedSize,targetURL);
     } completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {
         CCLOG(@" setImageWithURL error %@",error);
     }];
    
    [ccs.imageView
     .cc_frame(100, 700, 200, 200)
     .cc_addToView(self)
     .cc_backgroundColor(UIColor.blackColor) cc_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
}


@end
