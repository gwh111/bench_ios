//
//  CC_DetailVideo.m
//  bench_ios
//
//  Created by gwh on 2020/5/4.
//

#import "CC_DetailVideo.h"
#import <AVKit/AVKit.h>
#import "ccs.h"

@interface CC_DetailVideoCore : CC_Object

@property (nonatomic, assign) BOOL playWhenReady;

@end

@interface CC_DetailVideoCore ()

@property (nonatomic, strong) UIView *displayView;
@property (nonatomic, strong) AVPlayerViewController *playerVC;
@property (nonatomic, weak) id timeObserve;
@property (nonatomic, strong) CC_View *slideLine;

@property (nonatomic, strong) CC_View *toolBar;
@property (nonatomic, strong) CC_Button *startPauseBtn;
@property (nonatomic, strong) CC_Label *currentTimeLabel;
@property (nonatomic, strong) CC_Label *totalTimeLabel;
@property (nonatomic, strong) CC_Button *enlargeBtn;
@property (nonatomic, strong) CC_Button *soundBtn;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) CC_Button *closeBtn;
@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, strong) void(^controlsHiddenChangeBlock)(BOOL);
@property (nonatomic, assign) BOOL isHiddenMark;

@end

@implementation CC_DetailVideoCore

//+ (instancetype)shared {
//    return [ccs registerSharedInstance:self block:^{
//        [CC_DetailVideoCore.shared setup];
//    }];
//}

- (void)setup {

    AVPlayerViewController *playerVC;
    
    playerVC = AVPlayerViewController.new;
    playerVC.view.frame = CGRectMake(0, 100, 300, 300);
    playerVC.player.accessibilityElementsHidden = NO;
    playerVC.showsPlaybackControls = YES;
    playerVC.videoGravity = AVLayerVideoGravityResizeAspect;
    playerVC.showsPlaybackControls = NO;
    
    _playerVC = playerVC;
    
    _closeBtn = ccs.Button
    .cc_frame(RH(10),RH(10)+ccs.y,RH(30),RH(30))
    .cc_setBackgroundImageForState([ccs benchBundleImage:@"detail_video_close"],UIControlStateNormal);
    _closeBtn.hidden = YES;
    WS(weakSelf)
    [_closeBtn addTappedOnceDelay:1 withBlock:^(CC_Button *btn) {
        
        [weakSelf enlargeBtnAction:weakSelf.enlargeBtn];
    }];
    
    _slideLine = ccs.ui.grayLine
    .cc_backgroundColor(COLOR_WHITE)
    .cc_w(0)
    .cc_h(3)
    .cc_addToView(playerVC.view);
    
    [playerVC.view tappedInterval:1 withBlock:^(id  _Nonnull view) {
       
        CC_View *toolBar = self.toolBar;
        CC_View *slideLine = self.slideLine;
        CC_Button *closeBtn = self.closeBtn;
        if (toolBar.hidden) {
            if (self.isFullScreen) {
                closeBtn.hidden = NO;
            }
            toolBar.hidden = NO;
            slideLine.hidden = YES;
            [ccs delayStop:@"CC_DetailVideoCore"];
            [ccs delay:3 key:@"CC_DetailVideoCore" block:^{
                closeBtn.hidden = YES;
                toolBar.hidden = YES;
                if (!weakSelf.isFullScreen) {
                    slideLine.hidden = NO;
                }
            }];
        } else {
            closeBtn.hidden = YES;
            toolBar.hidden = YES;
            if (!weakSelf.isFullScreen) {
                slideLine.hidden = NO;
            }
            [ccs delayStop:@"CC_DetailVideoCore"];
        }
        if (self.controlsHiddenChangeBlock) {
            self.controlsHiddenChangeBlock(toolBar.hidden);
        }
    }];
    
    _toolBar = ccs.View
    .cc_h(RH(45))
    .cc_backgroundColor(HEXA(#000000, 0.3))
//    .cc_backgroundColor(HEXA(#ffffff, 0.3))
    .cc_addToView(playerVC.view);
    _toolBar.hidden = YES;
    {
        _startPauseBtn = ccs.Button
        .cc_frame(RH(5),RH(5),RH(35),RH(35))
        .cc_setImageForState([ccs benchBundleImage:@"detail_video_start@2x"],UIControlStateNormal)
        .cc_setImageForState([ccs benchBundleImage:@"detail_video_pause@2x"],UIControlStateSelected)
        .cc_addToView(_toolBar);
        WS(weakSelf)
        [_startPauseBtn addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {

            AVPlayer *player = weakSelf.playerVC.player;
            if (btn.selected) {
                btn.selected = NO;
                [player pause];
            } else {
                btn.selected = YES;
                [player play];
            }
        }];
        
        _currentTimeLabel = ccs.Label
        .cc_frame(_startPauseBtn.right + RH(10),RH(5),RH(100),RH(35))
        .cc_textColor(COLOR_WHITE)
        .cc_font(RF(11))
        .cc_text(@"00:00")
        .cc_addToView(_toolBar);
        
        float processWidth = RH(155);

        _totalTimeLabel = ccs.Label
        .cc_frame(RH(260),RH(5),RH(100),RH(35))
        .cc_textColor(COLOR_WHITE)
        .cc_font(RF(11))
        .cc_text(@"00:00")
        .cc_addToView(_toolBar);
        
        _slider = UISlider.new;
        _slider.frame = CGRectMake(RH(95),RH(20),processWidth,RH(4));
        _slider.minimumTrackTintColor = HEX(#DF5357);
        _slider.maximumTrackTintColor = HEXA(#FFFFFF,0.6);
        _slider.thumbTintColor = HEX(#DF5357);
//        [_slider setContinuous:NO];
        [_toolBar addSubview:_slider];
        [_slider setThumbImage:[ccs benchBundleImage:@"detail_video_slider"] forState:UIControlStateNormal];
        [_slider setThumbImage:[ccs benchBundleImage:@"detail_video_slider"] forState:UIControlStateHighlighted];
        [_slider addTarget:self action:@selector(sliderValueDidChanged:) forControlEvents:UIControlEventValueChanged];
        
        _enlargeBtn = ccs.Button
        .cc_setImageForState([ccs benchBundleImage:@"detail_video_full_screen"],UIControlStateNormal)
        .cc_setImageForState([ccs benchBundleImage:@"detail_video_back_screen"],UIControlStateSelected)
        .cc_frame(RH(305),RH(5),RH(35),RH(35))
        .cc_addToView(_toolBar);
        [_enlargeBtn addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
            
            [weakSelf enlargeBtnAction:btn];
        }];
        
        UIImage *imageoff = [ccs benchBundleImage:@"detail_video_sound_off@2x"];
        UIImage *imageon = [ccs benchBundleImage:@"detail_video_sound_on@2x"];
        _soundBtn = ccs.Button
        .cc_setImageForState(imageoff,UIControlStateNormal)
        .cc_setImageForState(imageon,UIControlStateSelected)
        .cc_frame(RH(340),RH(5),RH(35),RH(35))
        .cc_addToView(_toolBar);
        [_soundBtn addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
            
            btn.selected = !btn.selected;
            AVPlayer *player = weakSelf.playerVC.player;
            player.muted = !btn.selected;
        }];
    }
}

- (void)addControlsHiddenChangeBlock:(void(^)(BOOL hidden))block {
    _controlsHiddenChangeBlock = block;
}

- (void)enlargeBtnAction:(CC_Button *)btn {
    UIView *displayView = self.displayView;
    AVPlayerViewController *playerVC = self.playerVC;
    CC_View *toolBar = self.toolBar;
    CC_Button *closeBtn = self.closeBtn;
    if (btn.selected == NO) {
        closeBtn.hidden = NO;
        _isFullScreen = YES;
        _slideLine.hidden = YES;
        _slideLine.bottom = playerVC.view.height;
        [ccs presentViewController:(id)self.playerVC];
        toolBar.bottom = HEIGHT() - ccs.safeBottom;
    } else {
        closeBtn.hidden = YES;
        _isFullScreen = NO;
        [ccs dismissViewController];
        playerVC.view.height = displayView.height;
        [displayView addSubview:playerVC.view];
        toolBar.bottom = displayView.height;
    }
    btn.selected = !btn.selected;
}

- (void)sliderValueDidChanged:(UISlider *)slider {
    CMTime time1 = CMTimeMakeWithSeconds(slider.value, slider.maximumValue);
    [_playerVC.player seekToTime:time1];
}

- (void)addObserver {
    
    [_playerVC addObserver:self forKeyPath:@"readyForDisplay" options:0 context:NULL];
    
    WS(weakSelf)
    _timeObserve = [_playerVC.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, NSEC_PER_SEC) queue:nil usingBlock:^(CMTime time) {
        
        AVPlayerViewController *vc = weakSelf.playerVC;
        AVPlayer *player = vc.player;
        CC_View *slideLine = weakSelf.slideLine;
        CC_View *toolBar = weakSelf.toolBar;
        CC_Label *currentTimeLabel = weakSelf.currentTimeLabel;
        CC_Label *totalTimeLabel = weakSelf.totalTimeLabel;
        UISlider *slider = weakSelf.slider;
        CC_Button *startPauseBtn = weakSelf.startPauseBtn;
        CC_Button *closeBtn = weakSelf.closeBtn;
        
        float currentTime = CMTimeGetSeconds(player.currentItem.currentTime);
        float duration = CMTimeGetSeconds(player.currentItem.duration);
        if (currentTime <= 0 ||
            duration <= 0 ||
            duration < currentTime ||
            duration > 60 * 60 * 24) {
            return;
        }
        currentTimeLabel.text = [weakSelf fullTime:currentTime];
        totalTimeLabel.text = [weakSelf fullTime:duration];
        
        CGFloat progress = currentTime / duration;
        
        slider.value = progress * duration;
        slider.minimumValue = 0.0;
        slider.maximumValue = duration;
        
        if (progress <= 1) {
            slideLine.width = vc.view.width * progress;
            slideLine.bottom = vc.view.height;
            [vc.view addSubview:slideLine];
        }
        
        toolBar.width = vc.view.width;
        [vc.view addSubview:toolBar];
        [vc.view addSubview:closeBtn];
        if (progress >= 0.99) {
            //播放百分比为1表示已经播放完毕
            [player seekToTime:kCMTimeZero];
            [player pause];
            slider.value = 0;
            currentTimeLabel.text = @"00:00";
            startPauseBtn.selected = NO;
            if (weakSelf.isFullScreen) {
                [weakSelf enlargeBtnAction:weakSelf.enlargeBtn];
            }
        }

    }];
}

- (NSString *)fullTime:(float)seconds {
    NSString *time;
    if (seconds < 60) {
        NSString *second = [ccs string:@"%.0f",seconds];
        if (second.length == 1) {
            time = [ccs string:@"00:0%@",second];
        }
        if (second.length == 2) {
            time = [ccs string:@"00:%@",second];
        }
    } else {
        float min = seconds/60;
        seconds = seconds - min * 60;
        NSString *second = [ccs string:@"%.0f",seconds];
        if (min < 10) {
            if (second.length == 1) {
                time = [ccs string:@"0%.0f:0%@",min,second];
            }
            if (second.length == 2) {
                time = [ccs string:@"0%.0f:%@",min,second];
            }
        } else {
            if (second.length == 1) {
                time = [ccs string:@"%.0f:0%@",min,second];
            }
            if (second.length == 2) {
                time = [ccs string:@"%.0f:%@",min,second];
            }
        }
    }
    return time;
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
    _startPauseBtn.selected = YES;
    _playerVC.view.hidden = NO;
    [_playerVC.player play];
}

@end

@interface CC_DetailVideo ()

@property (nonatomic, strong) CC_ImageView *coverImageView;
@property (nonatomic, strong) CC_DetailVideoCore *videoCore;
@property (nonatomic, strong) void(^controlsHiddenChangeBlock)(BOOL);

@end

@implementation CC_DetailVideo

+ (CC_DetailVideo *)video {
    CC_DetailVideo *video = CC_DetailVideo.new;
    [video setup];
    return video;
}

- (void)setup {
    
    _videoCore = CC_DetailVideoCore.new;
    [_videoCore setup];
    WS(weakSelf)
    [_videoCore addControlsHiddenChangeBlock:^(BOOL hidden) {
       
        if (weakSelf.controlsHiddenChangeBlock) {
            weakSelf.controlsHiddenChangeBlock(hidden);
        }
    }];
    
    _coverImageView = ccs.ImageView;
    _displayView = ccs.View;
    
}

- (void)updateURL:(NSURL *)url {
    _videoUrl = url;
    
    if (_coverImageUrl) {
        _coverImageView.size = _displayView.size;
        _coverImageView.backgroundColor = UIColor.grayColor;
        [_displayView addSubview:_coverImageView];
        [_coverImageView cc_setImageWithURL:[NSURL URLWithString:_coverImageUrl]];
    }
    
    _videoCore.toolBar.bottom = _displayView.height;
}

- (void)addToView:(id)view {
    _videoCore.displayView = _displayView;
    [view addSubview:_displayView];
}

- (void)addControlsHiddenChangeBlock:(void(^)(BOOL hidden))block {
    _controlsHiddenChangeBlock = block;
}

- (void)play {
    AVPlayerViewController *playerVC = _videoCore.playerVC;
    playerVC.view.frame = _displayView.frame;
    playerVC.view.top = 0;
    playerVC.view.left = 0;
    
    if (!playerVC.player) {
        playerVC.player = [AVPlayer playerWithURL:_videoUrl];
    }
    playerVC.player.muted = YES;
//    playerVC.view.hidden = !playerVC.readyForDisplay;
    
    _videoCore.playWhenReady = YES;
    if (playerVC.readyForDisplay) {
        [_videoCore realPlay];
    }
    
    [_displayView addSubview:playerVC.view];
    [_videoCore addObserver];
}

- (void)pause {
    _videoCore.playWhenReady = NO;
    AVPlayerViewController *playerVC = _videoCore.playerVC;
    [playerVC.player pause];
    playerVC.showsPlaybackControls = false;
    _videoCore.startPauseBtn.selected = NO;
}

- (void)soundOn {
    _videoCore.playerVC.player.muted = NO;
    _videoCore.soundBtn.selected = YES;
}

- (void)soundOff {
    _videoCore.playerVC.player.muted = YES;
    _videoCore.soundBtn.selected = NO;
}

- (void)remove {
    
    [self pause];
    if (_videoCore.timeObserve) {
        @try {
            [_videoCore.playerVC removeObserver:_videoCore forKeyPath:@"readyForDisplay"];
            [_videoCore.playerVC.player removeTimeObserver:_videoCore.timeObserve];
        } @catch(id anException) {
            //do nothing, obviously it wasn't attached because an exception was thrown
            CCLOG(@"anException");
        }
        _videoCore.timeObserve = nil;
    }
    [_displayView removeFromSuperview];
}

@end
