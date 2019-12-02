//
//  CC_UploadImagesTool.h
//  AFNetworking
//
//  Created by 路飞  on 2019/3/12.
//

#import "CC_UIKit.h"
#import "CC_HttpResponseModel.h"
#import "CC_HttpConfig.h"

@class CC_HttpTask;
@interface CC_ImageUploadTask : NSObject

/**
 上传多张图片-指定图片压缩比例
 @param images 图片数组
 @param url URL
 @param paramsDic 参数
 @param imageScale 上传图片缩放比例
 @param times 上传失败-重新上传次数
 @param uploadImageBlock 回调函数
 */
- (void)uploadImages:(NSArray<UIImage *> *)images url:(id)url params:(id)paramsDic imageScale:(CGFloat)imageScale reConnectTimes:(NSInteger)times configure:(CC_HttpConfig *)configure finishBlock:(void (^)(NSArray<HttpModel *> *, NSArray<HttpModel *> *))uploadImageBlock;

/**
 上传多张图片-指定图片大小 单位 兆
 @param images 图片数组
 @param url URL
 @param paramsDic 参数
 @param imageSize 指定图片大小 单位 兆
 @param times 上传失败-重新上传次数
 @param uploadImageBlock 回调函数
 */
- (void)uploadImages:(NSArray<UIImage *> *)images url:(id)url params:(id)paramsDic imageSize:(NSUInteger)imageSize reConnectTimes:(NSInteger)times configure:(CC_HttpConfig *)configure finishBlock:(void (^)(NSArray<HttpModel *> *, NSArray<HttpModel *> *))uploadImageBlock;

/**
 上传多张图片-NSData
 @param imageDatas 图片数组 NSData类型
 @param url URL
 @param paramsDic 参数
 @param times 上传失败-重新上传次数
 @param uploadImageBlock 回调函数
 */
- (void)uploadImages:(NSArray<NSData *> *)imageDatas url:(id)url params:(id)paramsDic reConnectTimes:(NSInteger)times configure:(CC_HttpConfig *)configure finishBlock:(void (^)(NSArray<HttpModel *> *, NSArray<HttpModel *> *))uploadImageBlock;
@end

