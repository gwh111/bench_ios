//
//  CC_GColor.m
//  bench_ios
//
//  Created by gwh on 2017/8/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CC_GColor.h"

@implementation CC_GColor

/**
 *  制定图片 特定位置获取颜色
 */
+ (UIColor*)getPixelColorAtLocation:(CGPoint)point inImage:(UIImage *)image{
    
    UIColor* color = nil;
    CGImageRef inImage = image.CGImage;
    CGContextRef cgctx = [self createARGBBitmapContextFromImage:
                          inImage];
    
    if (cgctx == NULL) { return nil; /* error */ }
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    CGRect rect = {{0,0},{w,h}};
    
    CGContextDrawImage(cgctx, rect, inImage);
    
    unsigned char* data = CGBitmapContextGetData (cgctx);
    
    if (data != NULL) {
        int offset = 4*((w*round(point.y))+round(point.x));
        int alpha =  data[offset];
        int red = data[offset+1];
        int green = data[offset+2];
        int blue = data[offset+3];
//        NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,blue,alpha);
        
//        NSLog(@"x:%f y:%f", point.x, point.y);
        
        color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:
                 (blue/255.0f) alpha:(alpha/255.0f)];
    }
    
    CGContextRelease(cgctx);
    
    if (data) { free(data); }
    
    return color;
    
}

/**
 * 获得图片中churc除白色最可能的特征色
 */
+ (UIColor* )getImageMayColor:(UIImage *)image{
    float imgW=image.size.width;
    float imgH=image.size.height;
    
    NSMutableArray *chooseArr=[[NSMutableArray alloc]init];
    for (int i=0; i<10; i++) {
        CGPoint p=CGPointMake(imgW/2, imgH/2);
        
        p=CGPointMake(imgW*i/10, imgH/2);
        
        UIColor *myColor=[self getPixelColorAtLocation:p inImage:image];
        const CGFloat* components = CGColorGetComponents(myColor.CGColor);
        CGFloat Red, Green, Blue, Alpha;
        Alpha = components[0];
        Red = components[0+1];
        Green = components[0+2];
        Blue = components[0+3];
        //white?
        if (((1-Red)<.1)&&((1-Green)<.1)&&((1-Blue)<.1)) {
            
        }else{
            [chooseArr addObject:myColor];
        }
        
    }
    if (chooseArr.count>0) {
        return chooseArr[0];
    }else{
        return [UIColor whiteColor];
    }
}

/**
 * 判断两个颜色是否相近
 */
+ (float)judgeColorA:(UIColor *)colorA andColorB:(UIColor *)colorB{
    const CGFloat* components = CGColorGetComponents(colorA.CGColor);
    CGFloat Red, Green, Blue, Alpha;
    Alpha = components[0];
    Red = components[0+1];
    Green = components[0+2];
    Blue = components[0+3];
    
    const CGFloat* components2 = CGColorGetComponents(colorB.CGColor);
    CGFloat Red2, Green2, Blue2, Alpha2;
    Alpha2 = components2[0];
    Red2 = components2[0+1];
    Green2 = components2[0+2];
    Blue2 = components2[0+3];
    //向量比较
    float difference = pow( pow((Red - Red2), 2) + pow((Green - Green2), 2) +
                           pow((Blue - Blue2), 2), 0.5 );
    
    return difference;
}


+ (CGContextRef)createARGBBitmapContextFromImage:(CGImageRef)inImage {
    
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    bitmapBytesPerRow   = (int)(pixelsWide * 4);
    bitmapByteCount     = (int)(bitmapBytesPerRow * pixelsHigh);
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL)
    {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    CGColorSpaceRelease( colorSpace );
    return context;
}

@end
