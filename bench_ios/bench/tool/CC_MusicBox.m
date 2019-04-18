//
//  CC_MusicBox.m
//  bench_ios
//
//  Created by gwh on 2018/5/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_MusicBox.h"

@implementation CC_MusicBox

static CC_MusicBox *instance = nil;
static dispatch_once_t onceToken;

+ (instancetype)getInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[CC_MusicBox alloc] init];
    });
    return instance;
}

- (void)remove{
    instance=nil;
    onceToken=0;
}

- (void)playEffect:(NSString *)name type:(NSString *)type{
    if (_forbiddenEffect) {
        return;
    }
    isMusic=0;
    NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:name ofType:type];
    if (!strSoundFile) {
        NSLog(@"strSoundFile=nil");
        return;
    }
    NSURL *musicURL = [NSURL fileURLWithPath:strSoundFile];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    [_audioPlayer setDelegate:self];
    if (_defaultVolume>0) {
        _audioPlayer.volume = _defaultVolume;
    }
    [_audioPlayer prepareToPlay];
    [_audioPlayer play];
}

- (void)stopMusic{
    [_audioPlayer stop];
}

- (void)playMusic:(NSString *)name type:(NSString *)type{
    if (_forbiddenMusic) {
        return;
    }
    if (_audioPlayer) {
        fadeTimeCount=0;
        [self soundFadeOut:name type:type];
        return;
    }
    isMusic=1;
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    if (!musicPath) {
        NSLog(@"musicPath=nil");
        return;
    }
    NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    [_audioPlayer setDelegate:self];
    if (_defaultVolume>0) {
        _audioPlayer.volume = _defaultVolume;
    }
    if (_fade) {
        fadeTimeCount=0;
        _audioPlayer.volume = 0.05;
        [self soundFadeIn];
    }
    [_audioPlayer prepareToPlay];
    [_audioPlayer play];
}

- (void)soundFadeOut:(NSString *)name type:(NSString *)type{
    if (fadeTimeCount<10) {
        fadeTimeCount++;
        double delayInSeconds = 0.25;
        __block CC_MusicBox *blockSelf=self;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            blockSelf->_audioPlayer.volume = 1-blockSelf->fadeTimeCount*0.1;
            [self soundFadeOut:name type:type];
        });
    }else{
        [_audioPlayer stop];
        _audioPlayer=nil;
        [self playMusic:name type:type];
    }
}

- (void)soundFadeIn{
    if (fadeTimeCount<20) {
        fadeTimeCount++;
        double delayInSeconds = 0.25;
        __block CC_MusicBox *blockSelf=self;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds *   NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            blockSelf->_audioPlayer.volume = blockSelf->fadeTimeCount*0.05;
            [self soundFadeIn];
        });
    }
}

//播放完后
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                       successfully:(BOOL)flag{
    if (isMusic) {
        if (_musicReplayTimes>0) {
            _musicReplayTimes--;
            [_audioPlayer play];
        }
    }else{
        if (_effectReplayTimes>0) {
            _effectReplayTimes--;
            [_audioPlayer play];
        }
    }
    
}

@end
