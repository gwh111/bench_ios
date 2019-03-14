//
//  NSMutableDictionary+CCExtention.h
//  bench_ios
//
//  Created by gwh on 2018/11/8.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary(CCCat)

/**
 *  key or v空时不闪退
 */
- (void)safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey;

/**
 *  修正使用NSJSONSerialization将NSString转换为Dictionary后 有小数部分出现如8.369999999999999问题
 例子:
 NSString *html = @"{\"71.40\":71.40,\"8.37\":8.37,\"80.40\":80.40,\"188.40\":188.40}";此段html转换成NSMutableDictionary后使用correctNumberLoss处理耗时0.000379秒
 */
- (NSMutableDictionary *)correctDecimalLoss:(NSMutableDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
