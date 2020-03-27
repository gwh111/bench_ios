//
//  Test_FunctionViewController.m
//  bench_ios
//
//  Created by relax on 2019/8/29.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "Test_FunctionViewController.h"
#import "ccs.h"

@interface Test_FunctionViewController ()

@end

@implementation Test_FunctionViewController

- (void)cc_viewWillLoad {
    
    self.cc_displayView.cc_backgroundColor(UIColor.whiteColor);
    self.cc_title = @"Test_FunctionViewController";
    
    [self test_function];
}

- (void)test_function
{
    /*
     CC_Function
     */
    // data json
    CCLOG(@"%@",[ccs.tool dataWithInt:1234566]);
    // validate
    BOOL isEmpty = [ccs.tool isEmpty:nil];
    CCLOG(@" function_isEmpty %@",@(isEmpty));
    
    //是否从appstore下载的
    CCLOG(@" function_isInstallFromAppStore %@",@([ccs.tool isInstallFromAppStore]));
    //是否越狱
    CCLOG(@" function_isJailBreak %@",@([ccs.tool isJailBreak]));
    //版本号对比 return 1 前者大 0 相等 -1 前者小
    CCLOG(@" function_compareVersion %d",[ccs.tool compareVersion:@"1.2.0" cutVersion:@"1.2.1"]);
    //date format
    CCLOG(@" function_formatDate %@",[ccs.tool formatDate:@"2019-08-08 00:00:00" nowDate:@"2019-08-20 00:00:00"]);
    
    /*
     CC_String
     */
    // html 去掉标签 留下字符串 trimSpace 过滤空格
    NSString *replaceHtmlStr = [ccs.tool replaceHtmlLabel:@"<p><span style=\"font-family:宋体\">劳动是人类创造物质或精神财富的活动，有体力的，也有脑力的。我们自己是劳动者，也是别人劳动的见证者。劳动存在于现在，也存在于过去和未来。劳动的人有不同，劳动的对象有不同，劳动的方式有不同，劳动的环境有不同</span></p>"
                                                    labelName:@""
                                                  toLabelName:@""
                                                    trimSpace:YES];
    CCLOG(@"replaceHtml = %@",replaceHtmlStr);
    // html 分割
    NSArray *groupArray = [ccs.tool getHtmlLabel:@"<p><span style=\"font-family:宋体\">劳动是人类创造物质或精神财富的活动</span></p><p><span style=\"font-family:宋体\">劳动是人类创造物质或精神财富的活动</span></p>"
                                               start:@"<p>"
                                                 end:@"</p>"
                                     includeStartEnd:YES];
    CCLOG(@"html groupArray = %@",groupArray);
    
    // Sign Dic
    NSMutableString *mutableString = [ccs.tool MD5SignWithDic:[NSMutableDictionary dictionaryWithDictionary:@{@"name":@"张三",@"sex":@"男"}]
                                                        andMD5Key:@"123456"];
    CCLOG(@"MD5SignWithDic mutableString = %@",mutableString);
    
    //sign value
    NSMutableString *valueMutableString = [ccs.tool MD5SignValueWithDic:[NSMutableDictionary dictionaryWithDictionary:@{@"name":@"张三",@"sex":@"男"}]
                                                                  andMD5Key:@"123456"];
    CCLOG(@"MD5SignWithDic valueMutableString = %@",valueMutableString);
    
    /*
     CC_Array
    */
    // 中文排序
    NSMutableArray *sortArray = [ccs.tool sortChineseArr:[NSMutableArray arrayWithArray:
                                            @[@{@"name":@"李三",@"sex":@"男"},
                                              @{@"name":@"张四",@"sex":@"男"},
                                              @{@"name":@"王五",@"sex":@"男"}]]
                                                    depthArr:@[@"name"]];
    CCLOG(@"sortArray = %@",sortArray);
    
    /*
     CC_Data
     */
    NSData *data = [ccs.tool archivedDataWithObject:@[@"xinyi"]];
    CCLOG(@" function_unarchivedObjectWithData %@",[ccs.tool unarchivedObjectWithData:data]);
    
    /*
     CC_Date
     */
    // compare date
    NSTimeInterval interval = [ccs.tool compareDate:[NSDate date] cut:[NSDate date]];
    CCLOG(@"function_compareDate interval = %f",interval);
    
    /*
     CC_Object
     */
    CCLOG(@"origin = %@ function_copyObject = %@",[NSDate date],NSDate.date.cc_copy);
    
    
//    NSMutableArray *parr=[ccs function_mapParser:@[@{@"name":@"李三",@"sex":@"男"},
//                                                   @{@"name":@"张四",@"sex":@"男"},
//                                                   @{@"name":@"王五",@"sex":@"男"}]
//                                           idKey:@"name"
//                                         keepKey:YES
//                                         pathMap:@{@"name":@"王五",@"sex":@"女"}];
//
//    CCLOG(@"sortArray = %@",parr);
}

@end
