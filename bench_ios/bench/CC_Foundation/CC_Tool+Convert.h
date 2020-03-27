//
//  CC_Tool+Convert.h
//  bench_ios
//
//  Created by gwh on 2020/3/23.
//

#import <UIKit/UIKit.h>
#import "CC_Tool.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_Tool (Convert)

- (id)jsonWithString:(NSString *)jsonString;
- (NSString *)stringWithJson:(id)object;
- (NSData *)dataWithInt:(int)i;
- (UIImage *)imageWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
