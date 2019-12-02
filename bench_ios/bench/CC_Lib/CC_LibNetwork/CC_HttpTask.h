//
//  GHttpSessionTask.h
//  NSURLSessionTest
//
//  Created by apple on 15/11/24.
//  Copyright © 2015年 apple. All rights reserved.
//

/*
 需求：
 1、配置http头
    setHttpHeader
 2、登录成功后配置signKeyStr，额外参数extreDic
 3、添加其他地方登录回调
 */

#import "CC_Foundation.h"
#import "CC_Function.h"
#import "CC_HttpResponseModel.h"
#import "CC_HttpConfig.h"

@interface CC_HttpTask : NSObject<NSURLSessionDelegate>

+ (instancetype)shared;

//加密域名
//@property (nonatomic, copy) NSString *encryptDomain;

@property(nonatomic,retain) CC_HttpConfig *configure;

// 网络请求回调
@property(strong) void (^finishBlock)(NSString *error, HttpModel *result);

// 上传图片完成回调
@property(strong) void (^finishUploadImagesBlock)(NSArray<HttpModel*> *errorModelArr, NSArray<HttpModel*> *successModelArr);

- (void)start;

#pragma mark 加密必须添加 CC_HttpEncryption文件
- (void)post:(id)url params:(id)paramsDic model:(HttpModel *)model finishBlock:(void (^)(NSString *error, HttpModel *result))block;

- (void)get:(id)url params:(id)paramsDic model:(HttpModel *)model finishBlock:(void (^)(NSString *error, HttpModel *result))block;

- (void)sendRequest:(NSURLRequest *)request model:(HttpModel *)model finishBlock:(void (^)(NSString *error, HttpModel *result))block;

/**
 *  设置通用响应结果特殊处理回调逻辑
 *  logicName  给这个逻辑处理起一个名字
 *  logicStr  判断条件语句  提供两种判断
    可连续配置多种不同的特殊处理回调逻辑用‘,’分隔嵌套字段
    1 根据响应某字段aaa=bbb   如response,error=third
    2 根据响应有无某字段aaa    如response,error
 *  stop 是否立即停止只跑回调方法 即正常的回调不再回调过去
    应用场景：弹出其他地方登录后 黑底白字的提示不用弹 统一不回调回去 stop=YES
 *  popOnce 是否只回调一次
    应用场景：进入一个页面连续调3个接口 3个接口回调都会报在其他地方登录 只要一次回调弹窗提示 需要过滤其他两个时 popOnce=YES
 *  logicBlock 符合条件后的回调，回调的逻辑，需要在appDelegate里配置
 *
 *  例子:
 *  [[CC_HttpTask shared] cc_addResponseLogic:@"PARAMETER_ERROR" logicStr:@"response,error,name=PARAMETER_ERROR" stop:YES popOnce:YES logicBlock:^(ResModel *result) {
    //在这里添加处理代码
    }];
 */
- (void)addResponseLogic:(NSString *)logicName logicStr:(NSString *)logicStr stop:(BOOL)stop popOnce:(BOOL)popOnce logicBlock:(void (^)(HttpModel *result, void (^finishBlock)(NSString *error,HttpModel *result)))block;

/**
 *  logicName  添加时起的名字
 *  重置只回调一次的设置
 *  应用场景：其他地方登陆后点确定后需重置 因为下一次调就又要弹窗了
 *  例子：
 *  [[CC_HttpTask shared]resetResponseLogicPopOnce:@"PARAMETER_ERROR"];
 */
- (void)resetResponseLogicPopOnce:(NSString *)logicName;

/**
 上传多张图片-指定图片压缩比例
 @param images 图片数组
 @param url URL
 @param paramsDic 参数
 @param imageScale 上传图片缩放比例
 @param times 上传失败-重新上传次数
 @param uploadImageBlock 回调函数
 */
- (void)imageUpload:(NSArray<id> *)images url:(id)url params:(id)paramsDic imageScale:(CGFloat)imageScale reConnectTimes:(NSInteger)times finishBlock:(void (^)(NSArray<HttpModel*> *errorModelArr, NSArray<HttpModel*> *successModelArr))uploadImageBlock;

/**
 上传多张图片-指定图片大小 单位 兆
 @param images 图片数组
 @param url URL
 @param paramsDic 参数
 @param imageSize 指定图片大小 单位 兆
 @param times 上传失败-重新上传次数
 @param uploadImageBlock 回调函数
 */
- (void)imageUpload:(NSArray<id> *)images url:(id)url params:(id)paramsDic imageSize:(NSUInteger)imageSize reConnectTimes:(NSInteger)times finishBlock:(void (^)(NSArray<HttpModel*> *errorModelArr, NSArray<HttpModel*> *successModelArr))uploadImageBlock;

/**
 上传多张图片-NSData
 @param images 图片数组-NSData类型
 @param url URL
 @param paramsDic 参数
 @param times 上传失败-重新上传次数
 @param uploadImageBlock 回调函数
 */
- (void)imageUpload:(NSArray<id> *)images url:(id)url params:(id)paramsDic reConnectTimes:(NSInteger)times finishBlock:(void (^)(NSArray<HttpModel*> *errorModelArr, NSArray<HttpModel*> *successModelArr))uploadImageBlock;

///  根据文件路径上传文件
/// @param filepath 文件路径
/// @param paramsDic 上传参数
/// @param progress 进度回调
/// @param finishHandler 响应回调
- (void)uploadFileWithPath:(NSString *)filepath
                    params:(id)paramsDic
                  progress:(void(^)(double progress))progress
             finishHandler:(void(^)(NSString *error, NSDictionary *result))finishHandler;

/// 文件上传k接口
/// @param data 文件二进制数据
/// @param name 文件名
/// @param url 上传路径
/// @param mimeType MIMEType
/// @param paramsDic 参数
/// @param progress 上传进度回调
/// @param finishHandler 响应回调
- (void)uploadFileData:(NSData *)data
              fileName:(NSString *)name
                   url:(NSURL *)url
              mimeType:(NSString *)mimeType
                params:(id)paramsDic
              progress:(void (^)(double))progress
         finishHandler:(void (^)(NSString *error, NSDictionary *result))finishHandler;

/// 文件下载接口
/// @param urlStr 下载路径
/// @param progress 下载进度回调
/// @param finishHandler 响应回调
- (void)downloadDataWithUrl:(NSString *)urlStr
                   progress:(void(^)(double progress))progress
              finishHandler:(void (^)(NSError *error, NSDictionary *result))finishHandler;




@end
