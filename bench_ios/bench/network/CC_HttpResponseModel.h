//
//  CC_HttpResponseModel.h
//  bench_ios
//
//  Created by gwh on 2018/3/19.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResModel : NSObject

@property(nonatomic,assign) BOOL debug;
@property(nonatomic,retain) NSString *serviceStr;
@property(nonatomic,retain) NSString *requestUrlStr;
@property(nonatomic,retain) NSString *requestStr;

@property(nonatomic,retain) NSString *resultStr;
@property(nonatomic,retain) NSDictionary *resultDic;

@property(nonatomic,retain) NSString *errorStr;
//Thu, 19 Apr 2018 02:18:39 GMT
@property(nonatomic,retain) NSString *responseDateFormatStr;
@property(nonatomic,retain) NSDate *responseDate;

- (void)parsingError:(NSError *)error;
- (void)parsingResult:(NSString *)resultStr;

@end
