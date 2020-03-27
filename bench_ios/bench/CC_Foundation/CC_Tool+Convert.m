//
//  CC_Tool+Convert.m
//  bench_ios
//
//  Created by gwh on 2020/3/23.
//

#import "CC_Tool+Convert.h"

@implementation CC_Tool (Convert)

- (id)jsonWithString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        CCLOG(@"json解析失败：%@",error);
        return nil;
    }
    return object;
}

- (NSString *)stringWithJson:(id)object {
    if (!object) {
        return @"";
    }
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    }
    NSError *error;
    // Pass 0 if you don't care about the readability of the generated string
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonStr=@"";
    if (!jsonData){
        CCLOG(@"error: %@",error);
    }else{
        jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    jsonStr = [jsonStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return jsonStr;
}

- (NSData *)dataWithInt:(int)i {
    int j = ntohl(i);
    NSData *data = [NSData dataWithBytes: &j length: sizeof(i)];
    return data;
}

- (UIImage *)imageWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height {
    CGRect r = CGRectMake(0.0f, 0.0f, width,height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
