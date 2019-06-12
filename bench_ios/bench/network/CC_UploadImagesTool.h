//
//  CC_UploadImagesTool.h
//  AFNetworking
//
//  Created by 路飞  on 2019/3/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CC_HttpResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CC_HttpTask;
@interface CC_UploadImagesTool : NSObject

+(instancetype)shareInstance;

/**
 上传多张图片-指定图片压缩比例
 
 @param images 图片数组
 @param url URL
 @param paramsDic 参数
 @param imageScale 上传图片缩放比例
 @param times 上传失败-重新上传次数
 @param uploadImageBlock 回调函数
 */
-(void)uploadImages:(NSArray<UIImage *> *)images url:(id)url params:(id)paramsDic imageScale:(CGFloat)imageScale reConnectTimes:(NSInteger)times task:(CC_HttpTask*)task finishBlock:(void (^)(NSArray<ResModel*> *errorModelArr, NSArray<ResModel*> *successModelArr))uploadImageBlock;

/**
 上传多张图片-指定图片大小 单位 兆

 @param images 图片数组
 @param url URL
 @param paramsDic 参数
 @param imageSize 指定图片大小 单位 兆
 @param times 上传失败-重新上传次数
 @param uploadImageBlock 回调函数
 */
-(void)uploadImages:(NSArray<UIImage *> *)images url:(id)url params:(id)paramsDic imageSize:(NSUInteger)imageSize reConnectTimes:(NSInteger)times task:(CC_HttpTask*)task finishBlock:(void (^)(NSArray<ResModel*> *errorModelArr, NSArray<ResModel*> *successModelArr))uploadImageBlock;

@end

NS_ASSUME_NONNULL_END
