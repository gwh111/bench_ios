//
//  CCServerURLManager.h
//  LYServerChange
//
//  Created by ml on 2019/5/31.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CC_ServerURLManager : NSObject
/// 关键词
@property (nonatomic,copy) NSString *keyword;
@property (nonatomic,strong,readonly) NSMutableArray *infoM;

+ (instancetype)cc_defaultManager;

/**
 配置服务器

 @{
    @"分支环境":@{
        @"xjq_url":@"https://www.google.com",
        @"IM_url":@"https://www.baidu.com",
        @"jjx_url":@"https://www.baidu23.com",
        @"bt_url":@"https://developer.apple.com",
        @"ft_url":@"https://developer.apple123.com"
    },
    @"生产环境":
    ...
 }
 
 @param urlDic 配置信息
 
 @note name 用于在回调方法中判断是哪个URL
 */
- (void)cc_setupWithURLDic:(NSDictionary *)urlDic;


- (void)cc_setCompletion:(void (^)(NSArray *servers))completion;

@end

NS_ASSUME_NONNULL_END
