//
//  CC_CodeClass.m
//  bench_ios
//
//  Created by gwh on 2017/8/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_CodeClass.h"

@implementation CC_Code

+ (UINavigationController *)getRootNav{
    // return (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    /* keywindow会出现bug,参考:
     https://stackoverflow.com/questions/21698482/diffrence-between-uiapplication-sharedapplication-delegate-window-and-u/42996156#42996156
     http://www.jianshu.com/p/ae84cd31d8f0
     */
    
    if ([[UIApplication sharedApplication].delegate.window.rootViewController isKindOfClass:[UINavigationController class]])
    {
        return (UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    }
    else if ([[UIApplication sharedApplication].delegate.window.rootViewController isKindOfClass:[UITabBarController class]])
    {
        UIViewController *selectVc = [((UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController) selectedViewController];
        if ([selectVc isKindOfClass:[UINavigationController class]])
        {
            return (UINavigationController *)selectVc;
        }
    }
    
    return nil;
}

+ (UIViewController *)getCurrentVC
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    UIViewController *rootVC = window.rootViewController;
    UIViewController *presentedViewController = rootVC.presentedViewController;
    if (presentedViewController != nil) {
        if ([presentedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nv = (UINavigationController *)presentedViewController;
            return [nv.viewControllers lastObject];
        }else{
            return presentedViewController;
        }
    }
    return nil;
}
    
+ (UIWindow *)getLastWindow{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds)&&window.hidden==NO){
            return window;
        }
    }
    
    return [UIApplication sharedApplication].keyWindow;
}

+ (UIView *)getAView{
    UIView *showV=[CC_Code getCurrentVC].view;
    if (!showV) {
        showV=[CC_Code getLastWindow];
    }
    return showV;
}

+ (void)setRadius:(float)radius view:(UIView *)view{
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:radius];
}

+ (void)setShadow:(UIColor *)color view:(UIView *)view offset:(CGSize)size opacity:(float)opacity{
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOffset = size;
    view.layer.shadowOpacity = opacity;
}

+ (void)setShadow:(UIColor *)color view:(UIView *)view{
    [self setShadow:color view:view offset:CGSizeMake(2, 5) opacity:0.5];
}

+ (void)setLineColor:(UIColor *)color width:(float)width view:(UIView *)view{
    [view.layer setBorderWidth:width];
    view.layer.borderColor = [color CGColor];
}

+ (void)setFade:(UIView *)view{
    CAGradientLayer *_gradLayer = [CAGradientLayer layer];
    NSArray *colors = [NSArray arrayWithObjects:
                       (id)[[UIColor colorWithWhite:0 alpha:0] CGColor],
                       (id)[[UIColor colorWithWhite:0 alpha:1] CGColor],
                       (id)[[UIColor colorWithWhite:0 alpha:1] CGColor],
                       (id)[[UIColor colorWithWhite:0 alpha:1] CGColor],
                       (id)[[UIColor colorWithWhite:0 alpha:1] CGColor],
                       (id)[[UIColor colorWithWhite:0 alpha:1] CGColor],
                       nil];
    [_gradLayer setColors:colors];
    //渐变起止点，point表示向量
    [_gradLayer setStartPoint:CGPointMake(0.0f, 1.0f)];
    [_gradLayer setEndPoint:CGPointMake(0.0f, 0.0f)];
    
    [_gradLayer setFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    [view.layer setMask:_gradLayer];
}

@end

@implementation CC_Convert

+ (float)duToHuDu:(float)du{
    if (du==0) {
        return 0;
    }
    return M_PI/(180/du);
}

+ (float)huDuTodu:(float)huDu{
    return huDu*180/M_PI;
}

+ (NSString *)encodeUrlParameter:(NSString *)originalPara{
    CFStringRef encodeParaCf=CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)originalPara, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8);
    NSString *encodePara = (__bridge NSString *)(encodeParaCf);
    CFRelease(encodeParaCf);
    return encodePara;
}

+ (NSData *)strToData_utf8:(NSString *)str{
    if (!str) {
        return nil;
    }
    return [str dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSData *)strToData_base64:(NSString *)str{
    if (!str) {
        return nil;
    }
    NSData *ciphertextdata=[[NSData alloc]initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return ciphertextdata;
}

+ (NSString *)dataToStr_utf8:(NSData *)data{
    if (!data) {
        return nil;
    }
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)dataToStr_base64:(NSData *)data{
    if (!data) {
        return nil;
    }
    return [data base64EncodedStringWithOptions:0];
}

+ (NSData *)intToData:(int)i{
    int j=ntohl(i);
    NSData *data = [NSData dataWithBytes: &j length: sizeof(i)];
    return data;
}

+ (NSString *)convertToJSONData:(id)object{
    if (!object) {
        return @"";
    }
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    }
    NSError *error;
    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:object
    options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
    error:&error];
    
    NSString *jsonStr=@"";
    
    if (!jsonData){
        NSLog(@"Got an error: %@",error);
    }else{
        jsonStr=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    jsonStr=[jsonStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    
    [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return jsonStr;
}

+ (id)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err){
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return object;
}

+ (UIColor *)colorwithHexString:(NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (NSString*)parseLabel:(NSString*)str start:(NSString *)startStr end:(NSString *)endStr includeStartEnd:(BOOL)includeStartEnd{
    NSScanner *theScanner;
    NSString *head = nil;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:str];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:startStr intoString:&head] ;
        // find end of tag
        [theScanner scanUpToString:endStr intoString:&text] ;
    }
    if (includeStartEnd) {
        text=[text stringByAppendingString:endStr];
    }else{
        text=[text stringByReplacingOccurrencesOfString:startStr withString:@""];
    }
    return text;
}

#pragma mark math
+ (float)getRPoint1:(CGPoint)point1 point2:(CGPoint)point2{
    float p=sqrt(pow((point1.x-point2.x), 2)+pow((point1.y-point2.y), 2));
    return p;
}

+ (float)getDuPoint1:(CGPoint)point1 point2:(CGPoint)point2{
    point1=CGPointMake(point1.x, -point1.y);
    point2=CGPointMake(point2.x, -point2.y);
    if (point1.x-point2.x==0) {
        if (point1.y-point2.y>0) {
            return 90;
        }
        return 270;
    }
    if (point1.y-point2.y==0) {
        if (point1.x-point2.x>0) {
            return 0;
        }
        return 180;
    }
    float dy=(point1.y-point2.y);
    float dx=(point1.x-point2.x);
    if (dy>0&&dx>0) {
        float p_ang=atan(dy/dx);
        return [CC_Convert huDuTodu:p_ang];
    }else if (dy>0&&dx<0){
        float p_ang=atan(dy/-dx);
        return 180-[CC_Convert huDuTodu:p_ang];
    }else if (dy<0&&dx<0){
        float p_ang=atan(dy/dx);
        return [CC_Convert huDuTodu:p_ang]+180;
    }else{
        float p_ang=atan(-dy/dx);
        return 360-[CC_Convert huDuTodu:p_ang];
    }
    
}

+ (CGPoint)getPointR:(float)r du:(float)du{
    
    float cos=cosf([CC_Convert duToHuDu:du+1]);
    float sin=sinf([CC_Convert duToHuDu:du+1]);
    float x=r*cos;
    float y=r*sin;
    CGPoint p=CGPointMake(x, -y);
    
    return p;
}


@end
