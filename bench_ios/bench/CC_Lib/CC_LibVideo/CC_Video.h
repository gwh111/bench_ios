//
//  CC_Video.h
//  bench_ios
//
//  Created by gwh on 2020/4/12.
//

#import "CC_Object.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CC_VideoFinishType) {
    CC_VideoFinishTypeBackTo1 = -1,//回到第一帧
    CC_VideoFinishTypeRepeat = 0,//重复播放
};

typedef NS_ENUM(NSInteger, CC_VideoSlideType) {
    CC_VideoSlideTypeLine = -1,
    CC_VideoSlideTypeDefault = 0,
};

@interface CC_Video : CC_Object

// 模拟器无法播放真机可以
@property (nonatomic, readonly) UIView *displayView;//播放器显示视图
@property (nonatomic, assign) CC_VideoFinishType type;
@property (nonatomic, assign) CC_VideoSlideType slideType;
@property (nonatomic, strong) NSString *coverImageUrl;
@property (nonatomic, strong) NSURL *videoUrl;
@property (nonatomic, assign) BOOL playWhenReady;

+ (CC_Video *)videoWithURL:(NSURL *)url;

// 销毁时需要释放
// 播放观察者释放
- (void)removeObserver;

// 添加到视图
- (void)addToView:(id)view;

// 更新视频地址
- (void)updateURL:(NSURL *)url;

// 播放
- (void)play;

// 静音
- (void)soundOff;
// 恢复声音
- (void)soundOn;

// 静音播放
- (void)playMutely;

// 暂停
- (void)pause;

@end

NS_ASSUME_NONNULL_END
