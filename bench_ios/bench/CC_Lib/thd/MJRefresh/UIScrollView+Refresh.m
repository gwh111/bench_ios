//
//  UIScrollView+Refresh.m
// 
//
//  Created by david on 15/4/11.
//  Copyright © 2015年 GW. All rights reserved.
//

#import "UIScrollView+Refresh.h"

@implementation UIScrollView (Refresh)

#pragma mark - add
/** 添加S简单的头部刷新 没有上次刷新时间,没有状态 */
- (void)addSimpleHeaderRefresh:(MJRefreshComponentRefreshingBlockCopy)block {
    id mj_header = [cc_message cc_targetClass:@"MJRefreshNormalHeader" method:@"headerWithRefreshingBlock:" params:block];
    if (!mj_header) {
        CCLOGAssert(@"pod MJRefresh");
    }
    id lastUpdatedTimeLabel = [cc_message cc_targetInstance:mj_header method:@"lastUpdatedTimeLabel" params:nil];
    [cc_message cc_targetInstance:lastUpdatedTimeLabel method:@"setHidden:" params:CC_INT(YES)];
    id stateLabel = [cc_message cc_targetInstance:mj_header method:@"stateLabel" params:nil];
    [cc_message cc_targetInstance:stateLabel method:@"setHidden:" params:CC_INT(YES)];
    [cc_message cc_targetInstance:self method:@"setMj_header:" params:mj_header];
}

/** 添加头部刷新 */
- (void)addHeaderRefresh:(MJRefreshComponentRefreshingBlockCopy)block {
    
    id mj_header = [cc_message cc_targetClass:@"MJRefreshNormalHeader" method:@"headerWithRefreshingBlock:" params:block];
    if (!mj_header) {
        CCLOGAssert(@"pod MJRefresh");
    }
    [cc_message cc_targetInstance:self method:@"setMj_header:" params:mj_header];
}

/** 添加脚部自动刷新 */
- (void)addAutoFooterRefresh:(MJRefreshComponentRefreshingBlockCopy)block {
    
    id mj_footer = [cc_message cc_targetClass:@"MJRefreshAutoNormalFooter" method:@"footerWithRefreshingBlock:" params:block];
    if (!mj_footer) {
        CCLOGAssert(@"pod MJRefresh");
    }
    [cc_message cc_targetInstance:self method:@"setMj_footer:" params:mj_footer];
}

/** 添加脚部自动刷新 */
- (void)addAutoFooterRefreshWithPercent:(CGFloat)percent block:(MJRefreshComponentRefreshingBlockCopy)block {
    
    if (percent<0 || percent>1.0) {
        percent = 1.0;
    }
    id mj_footer = [cc_message cc_targetClass:@"MJRefreshAutoNormalFooter" method:@"footerWithRefreshingBlock:" params:block];
    if (!mj_footer) {
        CCLOGAssert(@"pod MJRefresh");
    }
    [cc_message cc_targetInstance:mj_footer method:@"setTriggerAutomaticallyRefreshPercent:" params:CC_FLOAT(percent)];
    [cc_message cc_targetInstance:self method:@"setMj_footer:" params:mj_footer];
}

/** 添加脚步返回刷新 */
- (void)addBackFooterRefresh:(MJRefreshComponentRefreshingBlockCopy)block {
    
    id mj_footer = [cc_message cc_targetClass:@"MJRefreshBackNormalFooter" method:@"footerWithRefreshingBlock:" params:block];
    [cc_message cc_targetInstance:self method:@"setMj_footer:" params:mj_footer];
}

/** 设置脚部title */
- (void)setStateFooterTitle:(NSString *)title forState:(MJRefreshStateCopy)state {
    
    id mj_footer = [cc_message cc_targetInstance:self method:@"mj_footer" params:nil];
    if (!mj_footer) {
        CCLOGAssert(@"pod MJRefresh");
    }else{
        [cc_message cc_targetInstance:mj_footer method:@"setTitle:forState:" params:title,CC_NSUINTEGER(state)];
    }
}

/** 设置头部title */
- (void)setStateHeaderTitle:(NSString *)title forState:(MJRefreshStateCopy)state {
    
    id mj_header = [cc_message cc_targetInstance:self method:@"mj_header" params:nil];
    if (!mj_header) {
        CCLOGAssert(@"pod MJRefresh");
    }else{
        if ([mj_header isKindOfClass:NSClassFromString(@"MJRefreshStateHeader")]) {
            [cc_message cc_targetInstance:mj_header method:@"setTitle:forState:" params:title,CC_NSUINTEGER(state)];
        }
    }
}

#pragma mark - begin/end
/** 开始头部刷新 */
- (void)beginHeaderRefresh {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        id mj_header = [cc_message cc_targetInstance:self method:@"mj_header" params:nil];
        [cc_message cc_targetInstance:mj_header method:@"beginRefreshing" params:nil];
    }];
}

/** 开始脚部刷新 */
- (void)beginFooterRefresh {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        id mj_footer = [cc_message cc_targetInstance:self method:@"mj_footer" params:nil];
        [cc_message cc_targetInstance:mj_footer method:@"beginRefreshing" params:nil];
    }];
}

/** 结束头部刷新 */
- (void)endHeaderRefresh {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        id mj_header = [cc_message cc_targetInstance:self method:@"mj_header" params:nil];
        [cc_message cc_targetInstance:mj_header method:@"endRefreshing" params:nil];
    }];
}

/** 结束脚部刷新 */
- (void)endFooterRefresh {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        id mj_footer = [cc_message cc_targetInstance:self method:@"mj_footer" params:nil];
        [cc_message cc_targetInstance:mj_footer method:@"endRefreshing" params:nil];
    }];
}

/** 结束脚步刷新并设置没有更多数据 */
- (void)endFooterRefreshWithNoMoreData {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        id mj_footer = [cc_message cc_targetInstance:self method:@"mj_footer" params:nil];
        [cc_message cc_targetInstance:mj_footer method:@"endRefreshingWithNoMoreData" params:nil];
    }];
}

@end












