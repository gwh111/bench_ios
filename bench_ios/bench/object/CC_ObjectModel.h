//
//  CC_ObjectModel.h
//  bench_ios
//
//  Created by gwh on 2018/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CC_Share.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_ObjectModel : NSObject

+ (void)showModels;

+ (void)showModel:(id)object;

+ (void)showModel:(id)object backColor:(int)color;



+ (id)getModel:(NSString *)name class:(Class)aClass;

+ (NSString *)saveModel:(UIView *)model name:(NSString *)name des:(NSString *)des hasSetLayer:(BOOL)hasSetLayer;

@end

NS_ASSUME_NONNULL_END
