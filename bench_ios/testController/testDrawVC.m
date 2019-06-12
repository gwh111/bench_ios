//
//  testDrawVC.m
//  bench_ios
//
//  Created by gwh on 2019/5/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import "testDrawVC.h"
#import "CC_SpriteMakerVC.h"

@implementation testDrawVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=COLOR_WHITE;
    
    [CC_SpriteMakerVC presentVC];
    
    UIFont *f=[ccui getUIFontWithType:@"超大标题"];
    
}

- (void)testbitmap{
    
    UIImage *image=[UIImage imageNamed:@"test4"];
    float shapW=100;
    float shapH=100;
    //初始化新的图片需要的data
    unsigned char* shapeData = malloc(shapW * shapH * 4);
    //    for (int i = 0; i < shapH -1; i ++) {
    //        for (int j = 0; j < shapW -1; j++) {
    //            int offset = (i * shapW + j) * 4;
    //            shapeData[offset] = 0;
    //            shapeData[offset + 1] = 0;
    //            shapeData[offset + 2] = 0;
    //            shapeData[offset + 3] = 0;
    //        }
    //    }
    CGContextRef newContext = CGBitmapContextCreate(shapeData, shapW, shapH, 8, shapW * 4, CGImageGetColorSpace(image.CGImage), CGImageGetAlphaInfo(image.CGImage));
    CGContextDrawImage(newContext, CGRectMake(0, 0, shapW, shapH), image.CGImage);
    shapeData = CGBitmapContextGetData(newContext);
    
    for (int i = 0; i < 11350 -1; i ++) {
        shapeData[i] = 100;
    }
    
    newContext = CGBitmapContextCreate(shapeData, shapW, shapH, 8, shapW * 4, CGImageGetColorSpace(image.CGImage), CGImageGetAlphaInfo(image.CGImage));
    
    CGImageRef cgImage = CGBitmapContextCreateImage(newContext);
    
    UIImageView *imgV=[[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 100, 100)];
    [self.view addSubview:imgV];
    imgV.backgroundColor=[UIColor clearColor];
    imgV.image = [UIImage imageWithCGImage:cgImage];
    CGContextRelease(newContext);
    CGImageRelease(cgImage);
}

@end
