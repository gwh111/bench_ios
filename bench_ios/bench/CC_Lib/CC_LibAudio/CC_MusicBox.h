//
//  CC_MusicBox.h
//  bench_ios
//
//  Created by gwh on 2018/5/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_Foundation.h"
#import <AVFoundation/AVFoundation.h>

@interface CC_MusicBox : NSObject<AVAudioPlayerDelegate>{
    int fadeTimeCount;
    int isMusic;
}

+ (instancetype)shared;

@property(nonatomic,assign) BOOL cc_forbiddenMusic;
@property(nonatomic,assign) BOOL cc_forbiddenSound;

@property(nonatomic,retain) AVAudioPlayer *cc_audioPlayer;

// 淡入淡出
// 使背景音乐过渡不突兀 当切换场景时检查是否有背景音乐在播放 如果有将它淡出 然后将新的背景音乐淡入 起到平滑作用
@property(nonatomic,assign) BOOL cc_fadeIn;

// 音效循环次数
@property(nonatomic,assign) int cc_soundReplayTimes;

// 音乐循环次数
@property(nonatomic,assign) int cc_musicReplayTimes;

// 设置最大音量
// 注意：如不设置 最大音量为手机设置的音量
@property(nonatomic,assign) float cc_defaultVolume;

// 停止播放
- (void)cc_stopMusic;
// 播放音乐
- (void)cc_playMusic:(NSString *)name type:(NSString *)type;
// 播放音效
- (void)cc_playSound:(NSString *)name type:(NSString *)type;

@end
