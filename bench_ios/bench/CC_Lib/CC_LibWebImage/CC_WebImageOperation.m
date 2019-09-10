//
//  CC_WebImageOperation.m
//  CCWebImageDemo
//
//  Created by 路飞 on 2019/4/19.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CC_WebImageOperation.h"

typedef NSMutableDictionary<NSString*, id> CC_WebImageCallBackDictionary;
static NSString *const kImageProgressCallback = @"kImageProgressCallback";
static NSString *const kImageCompletionCallback = @"kImageCompletionCallback";

@interface CC_WebImageOperation ()<NSURLSessionDataDelegate, NSURLSessionTaskDelegate>
@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) NSMutableArray *callbackBlocks;
@property (nonatomic, strong) dispatch_semaphore_t callbacksLock;
@property (nonatomic, assign, getter=isFinished) BOOL finished;
@property (nonatomic, assign) NSInteger expectedSize;
@property (nonatomic, strong) NSMutableData *imageData;
@end

@implementation CC_WebImageOperation
@synthesize finished = _finished;

- (instancetype)initWithRequest:(NSURLRequest *)request{
    if (self = [super init]) {
        self.request = request;
        self.callbackBlocks = [NSMutableArray new];
        self.callbacksLock = dispatch_semaphore_create(1);
    }
    return self;
}

- (id)addProgressHandler:(CC_WebImageDownloadProgressBlock)progressBlock withCompletionBlock:(CC_WebImageDownloadCompletionBlock)completionBlock{
    CC_WebImageCallBackDictionary *callBackDic = [[NSMutableDictionary alloc]init];
    if (progressBlock) {
        [callBackDic setObject:[progressBlock copy] forKey:kImageProgressCallback];
    }
    if(completionBlock) {
        [callBackDic setObject:[completionBlock copy] forKey:kImageCompletionCallback];
    }
    LOCK(self.callbacksLock);
    [self.callbackBlocks addObject:callBackDic];
    UNLOCK(self.callbacksLock);
    return callBackDic;
}

- (nullable NSArray *)callbacksForKey:(NSString *)key{
    LOCK(self.callbacksLock);
    NSMutableArray *callbacks = [[self.callbackBlocks valueForKey:key] mutableCopy];
    UNLOCK(self.callbacksLock);
    [callbacks removeObject:[NSNull null]];
    return [callbacks copy];
}

#pragma mark - cancel
- (BOOL)cancelWithToken:(id)token{
    BOOL shouldCancelTask = NO;
    LOCK(self.callbacksLock);
    [self.callbackBlocks removeObjectIdenticalTo:token];
    if (self.callbackBlocks.count == 0) {
        shouldCancelTask = YES;
    }
    UNLOCK(self.callbacksLock);
    if (shouldCancelTask) {
        [self cancel];
    }
    return shouldCancelTask;
}

#pragma mark - NSOperation
- (void)start{
    if (self.isCancelled) {
        self.finished = YES;
        [self reset];
        return;
    }
    
    if (!self.session) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    }
    self.dataTask = [self.session dataTaskWithRequest:self.request];
    [self.dataTask resume];
    
    for (CC_WebImageProgressBlock progressBlock in [self callbacksForKey:kImageProgressCallback]){
        progressBlock(0, NSURLResponseUnknownLength, self.request.URL);
    }
}

- (void)cancel{
    if (self.finished) {
        return;
    }
    [super cancel];
    if (self.dataTask) {
        [self.dataTask cancel];
    }
    [self reset];
}

- (void)reset{
    LOCK(self.callbacksLock);
    [self.callbackBlocks removeAllObjects];
    UNLOCK(self.callbacksLock);
    
    self.dataTask = nil;
    if (self.session) {
        [self.session invalidateAndCancel];
        self.session = nil;
    }
}

- (void)done{
    self.finished = YES;
    [self reset];
}

#pragma mark - NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    
    credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
    disposition = NSURLSessionAuthChallengeUseCredential;
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    NSInteger expectedSize = (NSInteger)response.expectedContentLength;
    self.expectedSize = expectedSize > 0 ? expectedSize : 0;
    for (CC_WebImageProgressBlock progressBlock in [self callbacksForKey:kImageProgressCallback]) {
        progressBlock(0, self.expectedSize, self.request.URL);
    }
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    if (!self.imageData) {
        self.imageData = [[NSMutableData alloc] initWithCapacity:self.expectedSize];
    }
    [self.imageData appendData:data];
    for (CC_WebImageProgressBlock progressBlock in [self callbacksForKey:kImageProgressCallback]) {
        progressBlock(self.imageData.length, self.expectedSize, self.request.URL);
    }
}

#pragma mark - NSURLSessionTaskDelgate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    for (CC_WebImageDownloadCompletionBlock completionBlock in [self callbacksForKey:kImageCompletionCallback]) {
        completionBlock(nil, [self.imageData copy], error, YES);
    }
    [self done];
}

#pragma mark - JImageOperation
- (void)cancelOperation{
    [self cancel];
}

#pragma mark - setter
- (void)setFinished:(BOOL)finished{
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

@end
