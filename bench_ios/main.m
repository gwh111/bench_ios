//
//  main.m
//  testbenchios
//
//  Created by gwh on 2019/7/26.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char * argv[]) {
    return UIApplicationMain(argc, argv, nil, @"CC_AppDelegate");
}

//clang -rewrite-objc main.m -0 main.cpp
//a : 如果是模拟器 ：$  xcrun -sdk iphonesimulator clang -rewrite-objc main.m
//b：真机 ： $ xcrun -sdk iphoneos clang -rewrite-objc main.m
//c : 真机 +模拟器 有默认版本的 ：$  xcrun -sdk iphonesimulator9.3 clang -rewrite-objc main.m

//#import <Foundation/Foundation.h>
//int main(int argc,char * argv[])
//{
//    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
//    //int a;
//    //scanf("%d", &a);
//    //printf("%d\n", a);
//    printf("Hello World!\n");
//    [pool drain];
//    return 0;
//}
