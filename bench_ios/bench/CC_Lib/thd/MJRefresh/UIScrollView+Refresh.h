//
//  UIScrollView+Refresh.h
//  
//
//  Created by david on 15/4/11.
//  Copyright © 2015年 GW. All rights reserved.
//

#import "CC_Foundation.h"

typedef void (^MJRefreshComponentRefreshingBlockCopy)(void);

/** 刷新控件的状态 */
typedef NS_ENUM(NSInteger, MJRefreshStateCopy) {
    /** 普通闲置状态 */
    MJRefreshStateIdleCopy = 1,
    /** 松开就可以进行刷新的状态 */
    MJRefreshStatePullingCopy,
    /** 正在刷新中的状态 */
    MJRefreshStateRefreshingCopy,
    /** 即将刷新的状态 */
    MJRefreshStateWillRefreshCopy,
    /** 所有数据加载完毕，没有更多的数据了 */
    MJRefreshStateNoMoreDataCopy
};

@interface UIScrollView (Refresh)
#pragma mark - add
/** 添加简单的头部刷新 (没有上次刷新时间,没有状态) */
- (void)addSimpleHeaderRefresh:(MJRefreshComponentRefreshingBlockCopy)block;
/** 添加头部刷新 */
- (void)addHeaderRefresh:(MJRefreshComponentRefreshingBlockCopy)block;
/** 添加脚部自动刷新 */
- (void)addAutoFooterRefresh:(MJRefreshComponentRefreshingBlockCopy)block;
/** 添加脚部自动刷新 (当底部控件出现多少时就自动刷新 0~1.0) */
- (void)addAutoFooterRefreshWithPercent:(CGFloat)percent block:(MJRefreshComponentRefreshingBlockCopy)block;
/** 添加脚步返回刷新 */
- (void)addBackFooterRefresh:(MJRefreshComponentRefreshingBlockCopy)block;

/** 设置脚部title */
- (void)setStateFooterTitle:(NSString *)title forState:(MJRefreshStateCopy)state;
- (void)setStateHeaderTitle:(NSString *)title forState:(MJRefreshStateCopy)state;

#pragma mark - begin/end
/** 开始头部刷新 */
- (void)beginHeaderRefresh;
/** 开始脚部刷新 */
- (void)beginFooterRefresh;
/** 结束头部刷新 */
- (void)endHeaderRefresh;
/** 结束脚部刷新 */
- (void)endFooterRefresh;
/** 结束脚步刷新并设置没有更多数据 */
- (void)endFooterRefreshWithNoMoreData;

@end










