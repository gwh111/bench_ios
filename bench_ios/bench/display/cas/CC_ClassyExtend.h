//
//  CC_ClassyExtend.h
//  testautoview2
//
//  Created by gwh on 2018/7/17.
//  Copyright © 2018年 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+ClassyCat.h"

@interface CC_ClassyExtend : NSObject

@property(nonatomic,retain) NSDictionary *ccCasDic;

+ (instancetype)getInstance;

/**
 *  初始化布局
 */
+ (void)initSheet:(NSString *)path;

/**
 *  解析布局模块路径
 */
+ (NSArray *)parseCasList;
/**
 *  解析对应控件属性
 */
+ (void)parseCas;

@end
