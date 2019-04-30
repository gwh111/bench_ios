//
//  ViewController.m
//  bench_ios
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"

#import "CC_Share.h"

#import "CC_3DWindow.h"

#import <objc/runtime.h>
#import<SystemConfiguration/CaptiveNetwork.h>

#import "CC_YCFloatWindow.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *nameArr;
    NSArray *controArr;
    
    NSArray *testList;
}


@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //get
    [[CC_HttpTask getInstance]get:@"https://www.baidu.com/" params:nil model:nil finishCallbackBlock:^(NSString *error, ResModel *result) {
        
    }];
    //post
    [[CC_HttpTask getInstance]post:@"https://www.baidu.com/" params:@{@"getDate":@""} model:nil finishCallbackBlock:^(NSString *error, ResModel *result) {
        
    }];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

+ (BOOL)isFromJailbrokenChannel
{
    NSString *bundleId = [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey];
    if (![bundleId isEqualToString:@"your bundle id"]) {
        return YES;
    }
    //取出embedded.mobileprovision这个描述文件的内容进行判断
    NSString *mobileProvisionPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    NSData *rawData = [NSData dataWithContentsOfFile:mobileProvisionPath];
    NSString *rawDataString = [[NSString alloc] initWithData:rawData encoding:NSASCIIStringEncoding];
    NSRange plistStartRange = [rawDataString rangeOfString:@"<plist"];
    NSRange plistEndRange = [rawDataString rangeOfString:@"</plist>"];
    if (plistStartRange.location != NSNotFound && plistEndRange.location != NSNotFound) {
        NSString *tempPlistString = [rawDataString substringWithRange:NSMakeRange(plistStartRange.location, NSMaxRange(plistEndRange))];
        NSData *tempPlistData = [tempPlistString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *plistDic =  [NSPropertyListSerialization propertyListWithData:tempPlistData options:NSPropertyListImmutable format:nil error:nil];
        
//        NSArray *applicationIdentifierPrefix = [plistDic getArrayValueForKey:@"ApplicationIdentifierPrefix" defaultValue:nil];
//        NSDictionary *entitlementsDic = [plistDic getDictionaryValueForKey:@"Entitlements" defaultValue:nil];
//        NSString *mobileBundleID = [entitlementsDic getStringValueForKey:@"application-identifier" defaultValue:nil];
//        if (applicationIdentifierPrefix.count > 0 && mobileBundleID != nil) {
//            if (![mobileBundleID isEqualToString:[NSString stringWithFormat:@"%@.%@",[applicationIdentifierPrefix firstObject],@"your applicationId"]]) {
//                return YES;
//            }
//        }
    }
    
    return NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=COLOR_WHITE;
    
    int isj=[CC_Validate isJailBreak];
    
#if DEBUG
    [CC_Share getInstance].ccDebug=1;
    [CC_FloatWindow addWindowOnTarget:self];
#endif

#pragma mark demo测试控制器
    
    testList=[ccs getPlistDic:@"testList"][@"list"];
    
    UITableView *tab=[[UITableView alloc]initWithFrame:CGRectMake(0, self.view.height/2, self.view.width, self.view.height/2)];
    [self.view addSubview:tab];
    tab.delegate=self;
    tab.dataSource=self;
    tab.backgroundColor=[UIColor whiteColor];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

//tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [testList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: CellIdentifier];
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.textLabel.text=[testList objectAtIndex:indexPath.section][@"title"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    NSDictionary *dic = testList[indexPath.section];
    NSString *name = dic[@"className"];
    Class cls = NSClassFromString(name);
    if (!cls) {
        [CC_Notice show:@"找不到class"];
        return;
    }
    UIViewController *vc = [[cls alloc]init];
    vc.view.backgroundColor=COLOR_WHITE;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
