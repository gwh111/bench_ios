//
//  TestVideoVC.m
//  bench_ios
//
//  Created by gwh on 2019/12/10.
//

#import "TestVideoVC.h"
#import "ccs.h"
#import <AVKit/AVKit.h>

@interface TestVideoVC ()

@property (nonatomic, strong) NSString *videoUrl;
@property (nonatomic, strong)AVPlayerViewController *playerVC;

@end

@implementation TestVideoVC

- (void)cc_viewWillLoad {
    
    self.videoUrl = @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4";
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"big_buck_bunny" ofType:@"mp4"];
    self.videoUrl = filePath;
    /*
     因为是 http 的链接，所以要去 info.plist里面设置
     App Transport Security Settings
     Allow Arbitrary Loads  = YES
     */
    self.playerVC = [[AVPlayerViewController alloc] init];
    self.playerVC.player = [AVPlayer playerWithURL:[self.videoUrl hasPrefix:@"http"] ? [NSURL URLWithString:self.videoUrl]:[NSURL fileURLWithPath:self.videoUrl]];
    self.playerVC.view.frame = CGRectMake(0, 100, 300, 300);
    self.playerVC.showsPlaybackControls = YES;
//self.playerVC.entersFullScreenWhenPlaybackBegins = YES;//开启这个播放的时候支持（全屏）横竖屏哦
//self.playerVC.exitsFullScreenWhenPlaybackEnds = YES;//开启这个所有 item 播放完毕可以退出全屏
    [self.view addSubview:self.playerVC.view];
    
    if (self.playerVC.readyForDisplay) {
        [self.playerVC.player play];
    }
}

- (void)cc_viewDidLoad {
	 // Do any additional setup after loading the view.
    
    CC_Button *button =
    ccs.Button
    .cc_frame(100, 500, 100,100)
    .cc_backgroundColor(UIColor.orangeColor)
    .cc_addToView(self);
    [button cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {

        [self.playerVC.player play];
    }];
    
}


@end
