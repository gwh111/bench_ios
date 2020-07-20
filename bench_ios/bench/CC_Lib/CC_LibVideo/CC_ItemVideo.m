//
//  CC_ItemVideo.m
//  bench_ios
//
//  Created by gwh on 2020/5/4.
//

#import "CC_ItemVideo.h"
#import <AVKit/AVKit.h>
#import "ccs.h"

@interface CC_ItemVideoCore : CC_Object

@property (nonatomic, assign) BOOL playWhenReady;

@end

@interface CC_ItemVideoCore ()

@property (nonatomic, strong) AVPlayerViewController *playerVC;
@property (nonatomic, weak) id timeObserve;
@property (nonatomic, strong) CC_View *slideLine;
@property (nonatomic, strong) CC_Button *soundBtn;

@end

@implementation CC_ItemVideoCore

+ (instancetype)shared {
    return [ccs registerSharedInstance:self block:^{
        [CC_ItemVideoCore.shared setup];
    }];
}

- (void)setup {

    AVPlayerViewController *playerVC;
    
    playerVC = AVPlayerViewController.new;
    playerVC.view.frame = CGRectMake(0, 100, 300, 300);
    playerVC.player.accessibilityElementsHidden = NO;
    playerVC.showsPlaybackControls = YES;
    playerVC.videoGravity = AVLayerVideoGravityResizeAspectFill;
    playerVC.showsPlaybackControls = NO;
    
    _playerVC = playerVC;
    
    _slideLine = ccs.ui.grayLine
    .cc_backgroundColor(COLOR_WHITE)
    .cc_w(0)
    .cc_h(3)
    .cc_addToView(playerVC.view);
    
    UIImage *imageoff = [ccs benchBundleImage:@"item_video_sound_off@2x"];
    UIImage *imageon = [ccs benchBundleImage:@"item_video_sound_on@2x"];
    _soundBtn = ccs.Button
    .cc_setImageForState(imageoff,UIControlStateNormal)
    .cc_setImageForState(imageon,UIControlStateSelected);
    WS(weakSelf)
    [_soundBtn addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
        
        btn.selected = !btn.selected;
        AVPlayer *player = weakSelf.playerVC.player;
        player.muted = !btn.selected;
    }];
}

- (void)addObserver {
    
    [_playerVC addObserver:self forKeyPath:@"readyForDisplay" options:0 context:NULL];
    
    WS(weakSelf)
    _timeObserve = [_playerVC.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, NSEC_PER_SEC) queue:nil usingBlock:^(CMTime time) {
        
        AVPlayer *player = weakSelf.playerVC.player;
        CC_View *slideLine = weakSelf.slideLine;
        AVPlayerViewController *vc = weakSelf.playerVC;
        
        CGFloat progress = CMTimeGetSeconds(player.currentItem.currentTime) / CMTimeGetSeconds(player.currentItem.duration);
        if (progress < 1) {
            slideLine.width = vc.view.width * progress;
            slideLine.bottom = vc.view.height;
            [vc.view addSubview:slideLine];
        }
        if (progress >= 0.99) {
            //播放百分比为1表示已经播放完毕
            [player seekToTime:kCMTimeZero];
            [ccs delay:0.5 block:^{
                [player play];
            }];
        }

    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                   change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"readyForDisplay"]) {
        [self realPlay];
    }

}

- (void)realPlay {
    if (!_playWhenReady) {
        return;
    }
    _soundBtn
    .cc_frame(_playerVC.view.width-RH(30),RH(4),RH(26),RH(26))
    .cc_addToView(_playerVC.view);
    _playerVC.view.hidden = NO;
    [_playerVC.player play];
}

@end

@interface CC_ItemVideo ()

@property (nonatomic, strong) CC_ImageView *coverImageView;

@end

@implementation CC_ItemVideo

+ (CC_ItemVideo *)video {
    CC_ItemVideo *video = CC_ItemVideo.new;
    [video setup];
    return video;
}

- (void)setup {
    
    _coverImageView = ccs.ImageView;
}

- (UIView *)displayView {
    if (!_displayView) {
        _displayView = ccs.View;
    }
    return _displayView;
}

- (void)updateURL:(NSURL *)url {
    _videoUrl = url;
    
    if (_coverImageUrl) {
        _coverImageView.size = _displayView.size;
        _coverImageView.backgroundColor = UIColor.grayColor;
        [_displayView addSubview:_coverImageView];
        [_coverImageView cc_setImageWithURL:[NSURL URLWithString:_coverImageUrl]];
    }
}

- (void)addToView:(id)view {
    [view addSubview:_displayView];
}

- (void)play {
    AVPlayerViewController *playerVC = CC_ItemVideoCore.shared.playerVC;
    playerVC.view.frame = _displayView.frame;
    playerVC.view.top = 0;
    playerVC.view.left = 0;
    
    playerVC.player = [AVPlayer playerWithURL:_videoUrl];
    playerVC.player.muted = YES;
    playerVC.view.hidden = !playerVC.readyForDisplay;
    
    CC_ItemVideoCore.shared.playWhenReady = YES;
    if (playerVC.readyForDisplay) {
        [CC_ItemVideoCore.shared realPlay];
    }
    
    [_displayView addSubview:playerVC.view];
    [CC_ItemVideoCore.shared addObserver];
}

- (void)pause {
    CC_ItemVideoCore.shared.playWhenReady = NO;
    AVPlayerViewController *playerVC = CC_ItemVideoCore.shared.playerVC;
    [playerVC.player pause];
    playerVC.showsPlaybackControls = false;
}

- (void)soundOn {
    CC_ItemVideoCore.shared.playerVC.player.muted = NO;
    CC_ItemVideoCore.shared.soundBtn.selected = YES;
}

- (void)soundOff {
    CC_ItemVideoCore.shared.playerVC.player.muted = YES;
    CC_ItemVideoCore.shared.soundBtn.selected = NO;
}

@end
