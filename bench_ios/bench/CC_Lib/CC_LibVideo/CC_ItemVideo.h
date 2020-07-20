//
//  CC_ItemVideo.h
//  bench_ios
//
//  Created by gwh on 2020/5/4.
//

#import "CC_Object.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CC_ItemVideo : CC_Object

@property (nonatomic, strong) UIView *displayView;//播放器显示视图
@property (nonatomic, strong) NSURL *videoUrl;
@property (nonatomic, strong) NSString *coverImageUrl;

+ (CC_ItemVideo *)video;

- (void)updateURL:(NSURL *)url;
- (void)addToView:(id)view;

- (void)play;
- (void)pause;

- (void)soundOn;
- (void)soundOff;

@end

NS_ASSUME_NONNULL_END
