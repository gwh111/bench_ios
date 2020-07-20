//
//  CC_DetailVideo.h
//  bench_ios
//
//  Created by gwh on 2020/5/4.
//

#import "CC_Object.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CC_DetailVideo : CC_Object

@property (nonatomic, strong) UIView *displayView;//播放器显示视图
@property (nonatomic, strong) NSURL *videoUrl;
@property (nonatomic, strong) NSString *coverImageUrl;

+ (CC_DetailVideo *)video;

- (void)updateURL:(NSURL *)url;
- (void)addToView:(id)view;

- (void)play;
- (void)pause;

- (void)soundOn;
- (void)soundOff;

- (void)remove;

// 下面控制条显示和消失回调
- (void)addControlsHiddenChangeBlock:(void(^)(BOOL hidden))block;

@end

NS_ASSUME_NONNULL_END
