//
//  CC_HookTrack.h
//  bench_ios
//
//  Created by gwh on 2018/8/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CC_HookTrack : NSObject

@property(nonatomic,assign) int debug;

/**
 *  堆栈中所有的控制器名字们
 */
@property(nonatomic,retain) NSMutableArray *lastVCs;

/**
 *  目前所在控制器名
 */
@property(nonatomic,retain) NSString *currentVCStr;

/**
 *  预制记录
 *  意思是接口请求成功后会有控制器进入的动作
 */
@property(nonatomic,retain) NSString *prePushActionStr;

/**
 *  预制记录
 *  意思是接口请求成功后会有控制器退出的动作
 */
@property(nonatomic,retain) NSString *prePopActionStr;

/**
 *  记录控制器进出的记录
 */
@property(nonatomic,retain) NSString *pushPopActionStr;

/**
 *  记录动作点击触发的记录
 */
@property(nonatomic,retain) NSString *triggerActionStr;

+ (instancetype)getInstance;

/**
 *  toVC 将要进入的控制器名称
 *  这个接口请求成功后 将要进入的控制器
 *  需要在接口请求前预制
 */
+ (void)willPushTo:(NSString *)toVC;

/**
 *  index 控制器将后退的层数
 *  这个接口请求成功后 将要后退的层数
 *  需要在接口请求前预制
 */
+ (void)willPopOfIndex:(int)index;

/**
 *  抓取这个请求发起时触发的路径
 */
+ (void)catchTrack;

@end
