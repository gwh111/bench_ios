//
//  Test_FundationViewController.m
//  bench_ios
//
//  Created by relax on 2019/9/2.
//

#import "Test_FundationViewController.h"
#import "ccs.h"


@interface Test_FundationViewController ()

@end

@implementation Test_FundationViewController

- (void)cc_viewWillLoad {
    self.cc_displayView.cc_backgroundColor(UIColor.whiteColor);
    self.cc_title = @"Test_FunctionViewController";
    
    [self test_foundationModel];
    [self test_foundationCoreTimer];
    [self test_foundationCoreThread];
    [self test_foundationCategory];
}

- (void)test_foundationModel
{
    //CC_Model
    Test_model *modelObj = [ccs init:[Test_model class]];
//    [modelObj cc_setProperty:@{@"str1":@"xin",@"str2":@"yi",@"Test_subModel":@{@"subStr1":@"ha",@"subStr2":@"哈哈哈"}}];
    [modelObj cc_setProperty:@{@"str1":@"xin",@"str2":@"yi"}];
    [modelObj cc_update];
    CCLOG(@" modelObj subModel propety %@",modelObj.subModel.subStr1);
    
    //replace Property name 
    [modelObj cc_setProperty:@{@"str1":@"xin",@"id":@"b"} modelKVDic:@{@"str2":@"id"}];
    [modelObj cc_update];
    
    //CC_Lib+NSObject
    CCLOG(@" getClassKVDic %@",[modelObj cc_getClassKVDic]);
    CCLOG(@" getClassKVDic_ %@",[modelObj cc_getClassKVDicWithout_]);
    CCLOG(@" getClassNameList %@",[modelObj cc_getClassNameList]);
    CCLOG(@" getClassTypeList %@",[modelObj cc_getClassTypeList]);
}

- (void)test_foundationCoreTimer
{
    //CC_CoreTimer
    [ccs timerRegister:@"testTimer1" interval:1 block:^{
        CCLOG(@"CC_CoreTimer block 1 ");
    }];
    [ccs timerRegister:@"testTimer2" interval:2 block:^{
        CCLOG(@"CC_CoreTimer block 2 ");
    }];
    [ccs timerRegister:@"testTimer3" interval:5 block:^{
        CCLOG(@"CC_CoreTimer block 3 ");
    }];
    
    [ccs timerCancel:@"testTimer2"];
    
    CCLOG(@"CC_CoreTimer uniqueNowTimestamp %@",[ccs uniqueNowTimestamp]);
    CCLOG(@"CC_CoreTimer uniqueNowTimestamp %@",[ccs nowTimeTimestamp]);
}

- (void)test_foundationCoreThread
{
    //CC_CoreTimer
    //    CCLOG(@"%@",[ccs nowTimeTimestamp]);
}

- (void)test_foundationCategory
{
    //CC_Lib+NSData
    //data to string, utf8编码
    CCLOG(@"data to string, utf8编码 %@",[[NSData new] cc_convertToUTF8String]);
    CCLOG(@"data to string, base64 %@",[[NSData new] cc_convertToBase64String]);
    
    //CC_Lib+NSDate
    CCLOG(@"date weekday = %@",[[NSDate date] cc_weekday]);
    CCLOG(@"date to String = %@",[[NSDate date] cc_convertToString]);
    CCLOG(@"date to String with formatter  = %@",[[NSDate date] cc_convertToStringWithformatter:@"yyyy-MM-dd HH:mm:ss"]);
    CCLOG(@"date second = %ld",(long)[NSDate date].cc_second);
    CCLOG(@"date minute = %ld",(long)[NSDate date].cc_minute);
    CCLOG(@"date hour = %ld",(long)[NSDate date].cc_hour);
    CCLOG(@"date day = %ld",(long)[NSDate date].cc_day);
    CCLOG(@"date month = %ld",(long)[NSDate date].cc_month);
    CCLOG(@"date year = %ld",(long)[NSDate date].cc_year);
    
    //CC_Lib+NSDictionary
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic cc_setKey:@"name" value:@"xinyi"];
    [dic cc_setKey:@"money" value:@"8.9999999999999999999"];
    CCLOG(@"dic setKey %@",dic);
    
    [dic cc_formatToString];
    CCLOG(@"dic formatToString %@",dic);
    
    [dic cc_correctDecimalLoss:dic];
    CCLOG(@"dic correctDecimal %@",dic);
    
    [dic cc_removeKey:@"name"];
    CCLOG(@"dic removeKey %@",dic);
    
    //CC_Lib+NSArray
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"ad",@"ee"]];
    [array cc_addObject:@(5)];
    CCLOG(@"array addObject %@",array);
    
    [array cc_ascending];
    CCLOG(@"array ascend %@",array);
    
    [array cc_descending];
    CCLOG(@"array descend %@",array);
    
    //CC_Lib+NSString
    NSString *string = @"xin yi";
    CCLOG(@"string convertToWord %@",[string cc_convertToWord]);
    CCLOG(@"string convertToUrlString %@",[string cc_convertToUrlString]);
    CCLOG(@"string convertToUTF8data %@",[string cc_convertToUTF8data]);
    CCLOG(@"string convertToBase64data %@",[string cc_convertToBase64data]);
    CCLOG(@"string convertToDate %@",[NSDate.date.cc_convertToString cc_convertToDate]);
    CCLOG(@"string convertToDateWithformatter %@",[NSDate.date.cc_convertToString cc_convertToDateWithformatter:@"YYYY-MM-dd HH:mm:ss"]);
    CCLOG(@"string convertToDecimalLosslessString %@",[string cc_convertToDecimalLosslessString]);
    
//    @param roundingMode 进位模式
//    NSRoundPlain 四舍五入
//    NSRoundDown 舍去
//    NSRoundUp 进位
//    NSRoundBankers 四舍六入五成双
//    @param scale 保留小数位数
    
    CCLOG(@"string convertToDecimalStr %@",[@"1.254" cc_convertToDecimalStr:NSRoundPlain scale:1]);
    
    //check bool
    CCLOG(@"string isPureInt %@",@([@"1.254" cc_isPureInt]));
    CCLOG(@"string isPureChinese %@",@([@"1.254" cc_isPureChinese]));
    CCLOG(@"string isNumberWordChinese %@",@([@"1=嗯嗯" cc_isNumberWordChinese]));
    CCLOG(@"string hasChinese %@",@([@"1=嗯嗯" cc_hasChinese]));
    CCLOG(@"string isMobileCell %@",@([@"15055555555" cc_isMobileCell]));
    CCLOG(@"string isEmail %@",@([@"xinyi@163.com" cc_isEmail]));
}

@end

@implementation Test_model

- (void)cc_update
{
    CCLOG(@"update Test_model key value %@",self.cc_modelDictionary);
}

@end

@implementation Test_subModel

- (void)cc_update
{
    CCLOG(@"update Test_model key value %@",self.cc_modelDictionary);
}

@end
