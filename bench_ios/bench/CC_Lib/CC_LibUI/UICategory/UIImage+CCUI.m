//
//  UIImage+CCUI.m
//  bench_ios
//
//  Created by gwh on 2020/3/30.
//

#import "UIImage+CCUI.h"
#import "CC_AES.h"

@implementation UIImage (CCUI)

+ (UIImage *)cc_decodeImageNamed:(NSString *)name {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"data"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (!data) {
        CCLOG(@"文件路径错误");
        return nil;
    }
    id key = [CC_AES.shared.AESKey cc_convertToUTF8data];
    NSData *decodeData = [CC_AES decryptData:data key:key];
    if (!decodeData) {
        CCLOG(@"解码失败");
        return nil;
    }
    UIImage *image = [UIImage imageWithData:decodeData];
    return image;
}

@end
