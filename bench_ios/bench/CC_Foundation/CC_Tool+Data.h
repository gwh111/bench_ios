//
//  CC_Tool+Data.h
//  bench_ios
//
//  Created by gwh on 2020/3/23.
//

#import "CC_CoreFoundation.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_Tool (Data)

#pragma mark compare
//  版本号对比 如1.3.2 比 1.4.1版本低 返回-1
//  1 v1>v2
//  0 v1=v2
// -1 v1<v2
- (int)compareVersion:(NSString *)v1 cutVersion:(NSString *)v2;

- (NSData *)archivedDataWithObject:(id)object;
- (id)unarchivedObjectWithData:(id)data;

@end

NS_ASSUME_NONNULL_END
