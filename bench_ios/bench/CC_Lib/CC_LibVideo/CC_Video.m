//
//  CC_Video.m
//  bench_ios
//
//  Created by gwh on 2020/4/12.
//

#import "CC_Video.h"
#import <AVKit/AVKit.h>
#import "ccs.h"

@interface CC_Video ()

@property (nonatomic, strong) AVPlayerViewController *playerVC;
@property (nonatomic, weak) id timeObserve;
@property (nonatomic, strong) CC_Button *soundBtn;
@property (nonatomic, strong) CC_View *slideLine;
@property (nonatomic, strong) CC_ImageView *coverImageView;
@property (nonatomic, assign) BOOL muted;

@end

@implementation CC_Video

- (void)start {
    
//self.playerVC.entersFullScreenWhenPlaybackBegins = YES;//开启这个播放的时候支持（全屏）横竖屏哦
//self.playerVC.exitsFullScreenWhenPlaybackEnds = YES;//开启这个所有 item 播放完毕可以退出全屏
    
}

+ (CC_Video *)videoWithURL:(NSURL *)url {
    CC_Video *video = CC_Video.new;
    video.videoUrl = url;
    [video setup];
    return video;
}

- (void)setup {
    
    _playerVC = AVPlayerViewController.new;
    _playerVC.player = [AVPlayer playerWithURL:_videoUrl];
    _playerVC.view.frame = CGRectMake(0, 100, 300, 300);
    _playerVC.player.accessibilityElementsHidden = NO;
    _playerVC.showsPlaybackControls = YES;
    _playerVC.videoGravity = AVLayerVideoGravityResizeAspectFill;
}

- (UIView *)displayView {
    return _playerVC.view;
}

- (void)updateURL:(NSURL *)url {
    _videoUrl = url;
    _playerVC.player = [AVPlayer playerWithURL:_videoUrl];
    _playerVC.player.muted = YES;

    if (_coverImageUrl) {
        _coverImageView.hidden = NO;
        _coverImageView.frame = self.displayView.frame;
        [_coverImageView cc_setImageWithURL:[NSURL URLWithString:_coverImageUrl]];
    }
}

- (void)soundOn {
    _muted = NO;
    _playerVC.player.muted = NO;
    if (_soundBtn) {
        _soundBtn.selected = YES;
    }
}

- (void)soundOff {
    _muted = YES;
    _playerVC.player.muted = YES;
    if (_soundBtn) {
        _soundBtn.selected = NO;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                   change:(NSDictionary *)change context:(void *)context {

    if ([keyPath isEqualToString:@"readyForDisplay"]) {
        if (_playWhenReady) {
            [_playerVC.player play];
        }
    }

}

- (void)play {

    if (_type == CC_VideoFinishTypeBackTo1) {
        _playerVC.showsPlaybackControls = YES;
    } else {
        _playerVC.showsPlaybackControls = NO;
        _slideType = CC_VideoSlideTypeLine;
    }
    
    WS(weakSelf)
    if (_slideType == CC_VideoSlideTypeLine) {
        if (!_soundBtn) {
            UIImage *imageoff = IMAGE(@"product_sound_off");
            UIImage *imageon = IMAGE(@"product_sound_on");
            _soundBtn = ccs.Button
            .cc_setImageForState(imageoff,UIControlStateNormal)
            .cc_setImageForState(imageon,UIControlStateSelected);
        }
        [ccs delay:.1 block:^{
            self.soundBtn
            .cc_frame(self.displayView.width-RH(30),RH(4),RH(26),RH(26))
            .cc_addToView(self.displayView);
        }];
        [_soundBtn addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {
            
            if (btn.selected) {
                [weakSelf soundOff];
            } else {
                [weakSelf soundOn];
            }
        }];
        if (!_slideLine) {
            _slideLine = ccs.ui.grayLine
            .cc_backgroundColor(COLOR_WHITE)
            .cc_w(0)
            .cc_h(3)
            .cc_addToView(self.displayView);
        }
        if (!_coverImageView) {
            if (_coverImageUrl) {
                _coverImageView = ccs.ImageView
                .cc_addToView(self.displayView);
            }
        }
    }
    
    _playWhenReady = YES;
    
    if (_playerVC.readyForDisplay) {
        [_playerVC.player play];
    } else {
    }
    [self addObserver];
}

- (void)addObserver {
    
    [self removeObserver];
    
    [_playerVC addObserver:self forKeyPath:@"readyForDisplay" options:0 context:NULL];
    WS(weakSelf)
    _timeObserve = [_playerVC.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, NSEC_PER_SEC) queue:nil usingBlock:^(CMTime time) {
        CGFloat progress = CMTimeGetSeconds(weakSelf.playerVC.player.currentItem.currentTime) / CMTimeGetSeconds(weakSelf.playerVC.player.currentItem.duration);
        if (progress < 1) {
            if (weakSelf.slideLine) {
                weakSelf.slideLine.width = weakSelf.displayView.width * progress;
                weakSelf.slideLine.bottom = weakSelf.displayView.height;
                [weakSelf.displayView addSubview:weakSelf.slideLine];
                [weakSelf.displayView addSubview:weakSelf.soundBtn];
            }
        }
        if (progress > 0) {
            
            weakSelf.coverImageView.hidden = YES;
        }
        if (progress == 1.0f) {
            CCLOG(@"%@",weakSelf.videoUrl);
            //播放百分比为1表示已经播放完毕
            [weakSelf.playerVC.player seekToTime:kCMTimeZero];
            if (weakSelf.type == CC_VideoFinishTypeBackTo1) {
                [weakSelf updateURL:weakSelf.videoUrl];
                [weakSelf pause];
            } else {
                if (weakSelf.playerVC.player.isMuted) {
                    [weakSelf playMutely];
                } else {
                    [weakSelf play];
                }
            }
            [weakSelf addObserver];
        }

    }];
}

- (void)playMutely {
    [self soundOff];
    [self play];
}

- (void)pause {
    _playWhenReady = NO;
    [_playerVC.player pause];
    if (_type == CC_VideoFinishTypeRepeat) {
        _playerVC.showsPlaybackControls = false;
    }
    [self removeObserver];
}

- (void)addToView:(id)view {
    [view addSubview:_playerVC.view];
}

- (void)removeObserver {
    
    if (_timeObserve) {
        @try {
            [_playerVC removeObserver:self forKeyPath:@"readyForDisplay"];
            [_playerVC.player removeTimeObserver:_timeObserve];
        } @catch(id anException) {
            //do nothing, obviously it wasn't attached because an exception was thrown
            CCLOG(@"anException");
        }
        _timeObserve = nil;
    }
    
}

@end
