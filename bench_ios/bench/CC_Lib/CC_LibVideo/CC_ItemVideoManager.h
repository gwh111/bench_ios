//
//  CC_ItemVideoManager.h
//  bench_ios
//
//  Created by gwh on 2020/5/6.
//

#import "CC_Object.h"
#import "CC_ItemVideo.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_ItemVideoManager : CC_Object

@property (nonatomic, retain) NSMutableSet *videos;

+ (instancetype)shared;

- (void)addVideo:(CC_ItemVideo *)video;
- (void)removeVideo:(CC_ItemVideo *)video;

- (void)addPlayVideoUrl:(NSString *)url;
- (void)removePlayVideoUrl:(NSString *)url;

- (void)playVideoUrl:(NSString *)url;

- (void)pauseAllVideos;
- (void)recoverPlayVideo;

- (void)clean;

@end

NS_ASSUME_NONNULL_END
