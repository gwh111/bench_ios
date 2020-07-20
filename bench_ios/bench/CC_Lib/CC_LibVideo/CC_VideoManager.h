//
//  CC_VideoManager.h
//  bench_ios
//
//  Created by gwh on 2020/4/25.
//

#import "CC_Object.h"
#import "CC_Video.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_VideoManager : CC_Object

@property (nonatomic, retain) NSMutableSet *videos;

+ (instancetype)shared;

- (void)addVideo:(CC_Video *)video;
- (void)removeVideo:(CC_Video *)video;

- (void)addPlayVideoUrl:(NSString *)url;
- (void)removePlayVideoUrl:(NSString *)url;

- (void)playVideoUrl:(NSString *)url;

- (void)pauseAllVideos;
- (void)recoverPlayVideo;

- (void)clean;

@end

NS_ASSUME_NONNULL_END
