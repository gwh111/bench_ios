//
//  TestVideoVC.m
//  bench_ios
//
//  Created by gwh on 2019/12/10.
//

#import "TestVideoVC.h"
#import "ccs.h"
#import <AVKit/AVKit.h>
#include <malloc/malloc.h>

@interface TestVideoVC ()

@property (nonatomic, strong) NSString *videoUrl;
@property (nonatomic, strong)AVPlayerViewController *playerVC;

@property (nonatomic, strong) CC_Video *video;
@property (nonatomic, strong) CC_Video *video2;

@end

@implementation TestVideoVC

- (void)dealloc
{
    NSLog(@"%@ dealloc",@"TestVideoVC");
}

- (void)cc_viewWillDisappear {
    
    [_video removeObserver];
    [_video2 removeObserver];
}

- (void)cc_viewWillLoad {
    
    self.cc_interactivePopDisabled = YES;
    self.videoUrl = @"https://gwhweb.oss-cn-hangzhou.aliyuncs.com/big_buck_bunny.mp4";
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"big_buck_bunny" ofType:@"mp4"];
//    self.videoUrl = filePath;
    /*
     因为是 http 的链接，所以要去 info.plist里面设置
     App Transport Security Settings
     Allow Arbitrary Loads  = YES
     */
//    self.playerVC = [[AVPlayerViewController alloc] init];
//    self.playerVC.player = [AVPlayer playerWithURL:[self.videoUrl hasPrefix:@"http"] ? [NSURL URLWithString:self.videoUrl]:[NSURL fileURLWithPath:self.videoUrl]];
//    self.playerVC.view.frame = CGRectMake(0, 100, 300, 300);
//    self.playerVC.showsPlaybackControls = YES;
////self.playerVC.entersFullScreenWhenPlaybackBegins = YES;//开启这个播放的时候支持（全屏）横竖屏哦
////self.playerVC.exitsFullScreenWhenPlaybackEnds = YES;//开启这个所有 item 播放完毕可以退出全屏
//    [self.view addSubview:self.playerVC.view];
//
//    if (self.playerVC.readyForDisplay) {
//        [self.playerVC.player play];
//    }
    
    CC_ImageView *img = ccs.ImageView
    .cc_frame(0,100,100,100)
    .cc_addToView(self);
    [img cc_setImageWithURL:[NSURL URLWithString:@"https://hbimg.huabanimg.com/255ae4c380538c6761f80e260533e0e2208a65d913312-NPwftS_fw658"]];
    
    [self testDetailVideo];
    
//    _video = [CC_Video videoWithURL:[NSURL URLWithString:@"https:\/\/sssyn-prod-haichi.hibao77.com\/goods.core.base\/VIDEO\/4007338923893010210081497135_VIDEO?version=1"]];
//    _video.displayView.frame = CGRectMake(0, 400, 100, 100);
//    [_video addToView:self.view];
////    [_video playMutely];
//
//    _video2 = [CC_Video videoWithURL:[NSURL URLWithString:@"https:\/\/test-haichi.oss-cn-hangzhou.aliyuncs.com\/goods.core.base\/VIDEO\/4007067452261301700161221090_VIDEO?version=0"]];
//    _video2.displayView.frame = CGRectMake(150, 400, 300, 300);
//    _video2.type = CC_VideoFinishTypeBackTo1;
//    [_video2 addToView:self.view];
//    [_video2 playMutely];
//NSNumber *size = @(malloc_size((__bridge const void *)_video2));
//
//    [CC_VideoManager.shared addVideo:_video];
//    [CC_VideoManager.shared addVideo:_video2];
    
//    [CC_VideoManager.shared playVideoUrl:_video2.videoUrl];
    
//    [ccs delay:2 block:^{
//        [self.video updateURL:[NSURL URLWithString:@"https://gwhweb.oss-cn-hangzhou.aliyuncs.com/big_buck_bunny.mp4"]];
//        [self.video playMutely];
//
//        [ccs.mask resume];
//        [ccs maskStart];
//    }];
//    [ccs delay:4 block:^{
//        [self.video updateURL:[NSURL URLWithString:@"https://gwhweb.oss-cn-hangzhou.aliyuncs.com/big_buck_bunny.mp4"]];
//        [self.video playMutely];
//    }];
//    [ccs delay:5 block:^{
//        [self.video updateURL:[NSURL URLWithString:@"https://gwhweb.oss-cn-hangzhou.aliyuncs.com/big_buck_bunny.mp4"]];
//        [self.video playMutely];
//    }];
}

- (void)testItemVideo {
    CC_ItemVideo *itemVideo = CC_ItemVideo.video;
    itemVideo.displayView.frame = CGRectMake(0, 400, 200, 200);
    [itemVideo addToView:self.view];
    itemVideo.coverImageUrl = @"https://hbimg.huabanimg.com/255ae4c380538c6761f80e260533e0e2208a65d913312-NPwftS_fw658";
    [itemVideo updateURL:[NSURL URLWithString:@"https:\/\/sssyn-prod-haichi.hibao77.com\/goods.core.base\/VIDEO\/4007338923893010210081497135_VIDEO?version=1"]];
    [ccs delay:1 block:^{
        [itemVideo play];
    }];
    [ccs delay:5 block:^{
        [itemVideo play];
    }];
    
    CC_ItemVideo *itemVideo2 = CC_ItemVideo.video;
    itemVideo2.displayView.frame = CGRectMake(200, 400, 200, 200);
    [itemVideo2 addToView:self.view];
    itemVideo2.coverImageUrl = @"https://hbimg.huabanimg.com/255ae4c380538c6761f80e260533e0e2208a65d913312-NPwftS_fw658";
    [itemVideo2 updateURL:[NSURL URLWithString:@"https:\/\/test-haichi.oss-cn-hangzhou.aliyuncs.com\/goods.core.base\/VIDEO\/4007067452261301700161221090_VIDEO?version=0"]];
    [ccs delay:3 block:^{
        [itemVideo2 play];
    }];
    [self 我是周毅];
}

- (void)我是周毅 {
    
    CCLOG(@"1");
}

- (void)testDetailVideo {
    CC_DetailVideo *itemVideo = CC_DetailVideo.video;
    itemVideo.displayView.frame = CGRectMake(0, 400, WIDTH(), WIDTH());
    [itemVideo addToView:self.view];
    itemVideo.coverImageUrl = @"https://hbimg.huabanimg.com/255ae4c380538c6761f80e260533e0e2208a65d913312-NPwftS_fw658";
    [itemVideo updateURL:[NSURL URLWithString:@"https:\/\/sssyn-prod-haichi.hibao77.com\/goods.core.base\/VIDEO\/4007338923893010210081497135_VIDEO?version=1"]];
    //@"https://test-haichi.oss-cn-hangzhou.aliyuncs.com/goods.core.base/VIDEO/10204007151189089308890100181038_VIDEO_ORIGIN?version=1"
    [itemVideo play];
//    [ccs delay:1 block:^{
//        [itemVideo play];
//    }];
//    [ccs delay:5 block:^{
//        [itemVideo play];
//    }];
    
    CC_DetailVideo *itemVideo2 = CC_DetailVideo.video;
    itemVideo2.displayView.frame = CGRectMake(200, 400, 200, 200);
    [itemVideo2 addToView:self.view];
    itemVideo2.coverImageUrl = @"https://hbimg.huabanimg.com/255ae4c380538c6761f80e260533e0e2208a65d913312-NPwftS_fw658";
    [itemVideo2 updateURL:[NSURL URLWithString:@"https:\/\/sssyn-prod-haichi.hibao77.com\/goods.core.base\/VIDEO\/4007338923893010210081497135_VIDEO?version=1"]];
    [itemVideo2 play];
    [ccs delay:3 block:^{
        [itemVideo2 pause];
        [itemVideo2 remove];
    }];
}

- (void)cc_viewDidLoad {
	 // Do any additional setup after loading the view.
    
    CC_Button *button =
    ccs.Button
    .cc_frame(100, 500, 100,100)
    .cc_backgroundColor(UIColor.orangeColor)
    .cc_addToView(self);
    [button cc_addTappedOnceDelay:.1 withBlock:^(CC_Button *btn) {

//        self.playerVC.player.muted = YES;
//        [self.playerVC.player play];
    }];
    
}


@end
