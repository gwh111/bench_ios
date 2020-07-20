//
//  Test_LibViewController.m
//  bench_ios
//
//  Created by relax on 2019/8/27.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "Test_LibViewController.h"
#import "TestDataBaseModel.h"
#import "ccs.h"

@interface Test_LibViewController ()

@end

@implementation Test_LibViewController

- (void)cc_viewWillLoad {
    
    self.cc_displayView.cc_backgroundColor(UIColor.whiteColor);
    self.cc_title = @"Test_LibViewController";

//    [self test_libSecurity];
//    [self test_libStorage];
//    [self test_LibWebImage];
    [self test_LibDataBase];
}

- (void)test_libSecurity
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"123" forKey:@"123"];
    
    NSString *str1 = [ccs.tool MD5SignWithDic:dic andMD5Key:@"123"];
    CCLOG(@" function_MD5SignWithDic %@",str1);
    
    NSString *str2 = [ccs.tool MD5SignValueWithDic:dic andMD5Key:@"123"];
    CCLOG(@" function_MD5SignValueWithDic %@",str2);
}

- (void)test_libStorage
{
    //KeyChain
    CCLOG(@" ccs.keychainUUID %@",ccs.keychainUUID);
    [ccs saveKeychainKey:@"xin" value:@"yi"];
    CCLOG(@" keychainKey xin %@",[ccs keychainValueForKey:@"xin"]);
    
    //NSUserDefaults
    [ccs saveDefaultKey:@"haha" value:@"hahaha"];
    id defaultKeyObj = [ccs defaultValueForKey:@"haha"];
    CCLOG(@" defaultKeyObj %@",defaultKeyObj);
    
    [ccs saveSafeDefaultKey:@"wawa" value:@"wawawa"];
    id safeDefaultKeyObj = [ccs safeDefaultValueForKey:@"wawa"];
    CCLOG(@" safeDefaultKeyObj %@",safeDefaultKeyObj);
    
    //NSBundle
    CCLOG(@" ccs.appName %@",ccs.appName);
    CCLOG(@" ccs.appBid  %@",ccs.appBid);
    CCLOG(@" ccs.appVersion %@",ccs.appVersion);
    CCLOG(@" ccs.appBundle %@",ccs.appBundle);
    CCLOG(@" ccs.appBundleVersion %@",ccs.appBundleVersion);
    
    NSData *bundleData = [ccs bundleFileWithPath:@"IMG_3058" type:@"JPG"];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageWithData:bundleData]];
    
    NSDictionary *bundleDict = [ccs bundlePlistWithPath:@"testList"];
    CCLOG(@" bundlePlistWithPath %@",bundleDict);
    
    BOOL isCopy = [ccs copyBundleFileToSandboxToPath:@"testList" type:@"plist"];
    CCLOG(@" copyBunldFileToSandboxToPath %@",@(isCopy));
    
    //Sandbox
    NSData *sbData = [ccs sandboxFileWithPath:@"testList" type:@"plist"];
    NSDictionary *sbDict = [NSJSONSerialization JSONObjectWithData:sbData options:NSJSONReadingMutableLeaves error:nil];
    CCLOG(@" sandboxFileWithPath %@",sbDict);
    
//    BOOL isDelete = [ccs deleteSandboxFileWithName:@"testList"];
//    CCLOG(@" deleteSandboxFileWithName %@",@(isDelete));
}

- (void)test_LibWebImage
{
    [ccs.ImageView
     .cc_frame(100, 100, 200, 200)
     .cc_addToView(self)
     .cc_backgroundColor(UIColor.blackColor) cc_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566999335305&di=22c5663904d50bd2d434666f94676e5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201505%2F03%2F20150503095835_zmSRT.jpeg"]];
    
    [ccs.ImageView
     .cc_frame(100, 300, 200, 200)
     .cc_addToView(self)
     .cc_backgroundColor(UIColor.blackColor) cc_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566999335305&di=22c5663904d50bd2d434666f94676e5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201505%2F03%2F20150503095835_zmSRT.jpeg"] placeholderImage:[UIImage imageNamed:@""] showProgressView:YES completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {

     }];
    
    [ccs.ImageView
     .cc_frame(100, 500, 200, 200)
     .cc_addToView(self)
     .cc_backgroundColor(UIColor.blackColor) cc_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566999335305&di=22c5663904d50bd2d434666f94676e5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201505%2F03%2F20150503095835_zmSRT.jpeg"] placeholderImage:[UIImage imageNamed:@""] processBlock:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
         CCLOG(@" setImageWithURL process receivedSize = %ld expectedSize = %ld targetURL = %@",(long)receivedSize,(long)expectedSize,targetURL);
     } completed:^(UIImage * _Nullable image, NSError * _Nullable error, BOOL finished) {
         CCLOG(@" setImageWithURL error %@",error);
     }];
    
    [ccs.ImageView
     .cc_frame(100, 700, 200, 200)
     .cc_addToView(self)
     .cc_backgroundColor(UIColor.blackColor) cc_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
}

- (void)test_LibDataBase
{
    
    [[ccs dataBaseStore]  removeDBFile];
    
    /// 1.存储模型对象到数据库演示代码
    TestDataBaseModel * person = [TestDataBaseModel new];
    person.name = @"辛夷";
    person.age = 18;
    person.height = 180.01;
    person.weight = 90.02;
    person.isDeveloper = YES;
    person.sex = 'm';
    person.zz = @(100);
    person.type = @"iOS";
    
    /// 测试继承属性存储
    person.typeName = @"人";
    person.eat = YES;
    
    /// 测试NSArray属性存储
    TestCar * tempCar = [TestCar new];
    tempCar.name = @"Benz";
    tempCar.brand = @"Tesla";
    person.array = @[@"1",@"2"];
    person.carArray = @[tempCar];
    
    /// 测试NSDictionary属性存储
    person.dict = @{@"1":@"2"};
    person.dictCar = @{@"car": tempCar};
    
    /// 存储图片
    person.data = UIImagePNGRepresentation([UIImage imageNamed:@"tabbar_mine_high"]);
    
    person.car = [TestCar new];
    person.car.name = @"撼路者";
    person.car.brand = @"大路虎";
    
    person.school = [TestSchool new];
    person.school.name = @"NB大学";
    person.school.personCount = 5000;
    person.school.city = [TestCity new];
    person.school.city.name = @"杭州";
    person.school.city.personCount = 1000;
    
    /// 插入model
    [[ccs dataBaseStore] insert:person];
    /// 插入model 数组
    [[ccs dataBaseStore] inserts:@[person,person]];
    /// 自定义表名称 插入model
    [[ccs dataBaseStore] insert:person tableName:@"CustomDataBaseModel"];
    /// 自定义表名称 插入model数组
    [[ccs dataBaseStore] inserts:@[person,person] tableName:@"CustomDataBaseModel"];
    
    /// 查询model 数据
    NSArray *modelArray = [[ccs dataBaseStore] query:TestDataBaseModel.class];
    /// 根据表名称 查询model 数据
    NSArray *customModelArray = [[ccs dataBaseStore] query:TestDataBaseModel.class tableName:@"CustomDataBaseModel"];

//    [[ccs dataBaseStore]  update:person where:@"name = '辛夷'"];
//    [[ccs dataBaseStore]  update:person where:@"name = '辛夷'" tableName:@"personcustom"];
    
//    [[ccs dataBaseStore]  update:TestDataBaseModel.class value:@"name = 'xiaoxinyi'" where:@"name = '辛夷'"];
//    [[ccs dataBaseStore]  updateWithTableName:@"CustomDataBaseModel" value:@"name = 'xiaoxinyi'" where:@"name = '辛夷'"];

    NSArray *arrayWhere = [[ccs dataBaseStore]  query:TestDataBaseModel.class where:@"name = '辛夷'"];
    NSArray *customArrayWhere = [[ccs dataBaseStore]  query:TestDataBaseModel.class where:@"name = '辛夷'" tableName:@"CustomDataBaseModel"];

//    [[ccs dataBaseStore]  delete:@"CustomDataBaseModel" where:@"name = 'xiaoxinyi'"];
//    [[ccs dataBaseStore]  clear:@"CustomDataBaseModel"];
    
}



@end
