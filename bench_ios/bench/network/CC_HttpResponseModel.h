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

@property(nonatomic,retain) NSString *resultStr;
@property(nonatomic,retain) NSDictionary *resultDic;

@property(nonatomic,retain) NSString *errorStr;

- (void)parsingError:(NSError *)error;
- (void)parsingResult:(NSString *)resultStr;

@end
