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

/**
 上传多张图片
 
 @param images 图片数组
 @param url URL
 @param paramsDic 参数
 @param imageScale 上传图片缩放比例
 @param times 上传失败-重新上传次数
 @param uploadImageBlock 回调函数
 */
+(void)uploadImages:(NSArray<UIImage *> *)images url:(id)url params:(id)paramsDic imageScale:(CGFloat)imageScale reConnectTimes:(NSInteger)times finishBlock:(void (^)(NSArray<NSString*> *errorStrArr, NSArray<ResModel*> *modelArr))uploadImageBlock;

@end

NS_ASSUME_NONNULL_END
