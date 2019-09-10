//
//  CC_WebImageDownloader.m
//  CCWebImageDemo
//
//  Created by 路飞 on 2019/4/18.
//  Copyright © 2019 路飞. All rights reserved.
//

#import "CC_WebImageDownloader.h"

#define LOCK(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
#define UNLOCK(lock) dispatch_semaphore_signal(lock);

@implementation CC_WebImageDownloadToken
@end

@interface CC_WebImageDownloader ()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSMutableDictionary<NSURL *, CC_WebImageOperation *> *URLOperations;
@property (nonatomic, strong) dispatch_semaphore_t URLsLock;

@end

@implementation CC_WebImageDownloader

+ (instancetype)shared{
    return [CC_Base.shared cc_registerSharedInstance:self block:^{
        [CC_WebImageDownloader.shared setup];
    }];
}

- (void)setup{
    self.session = [NSURLSession sharedSession];
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.URLOperations = [NSMutableDictionary dictionary];
    self.URLsLock = dispatch_semaphore_create(1);
}

- (CC_WebImageDownloadToken *)downloadImageWithURL:(NSURL *)url progress:(CC_WebImageDownloadProgressBlock)progressBlock completed:(CC_WebImageDownloadCompletionBlock)completedBlock{
    if (!url || url.absoluteString.length == 0) {
        return nil;
    }
    LOCK(self.URLsLock);
    CC_WebImageOperation* operation = [self.URLOperations objectForKey:url];
    if (!operation || operation.isCancelled || operation.isFinished) {
        NSURLRequest* request = [[NSURLRequest alloc]initWithURL:url];
        operation = [[CC_WebImageOperation alloc]initWithRequest:request];
        __weak typeof(self)weakSelf = self;
        operation.completionBlock = ^{
            __strong typeof(weakSelf)strongSelf = weakSelf;
            if (!strongSelf) {
                return ;
            }
            LOCK(self.URLsLock);
            [strongSelf.URLOperations removeObjectForKey:url];
            UNLOCK(self.URLsLock);
        };
        [self.operationQueue addOperation:operation];
        [self.URLOperations setObject:operation forKey:url.absoluteString];
    }
    UNLOCK(self.URLsLock);
    id downloadToken = [operation addProgressHandler:progressBlock withCompletionBlock:completedBlock];
    CC_WebImageDownloadToken* token = [[CC_WebImageDownloadToken alloc]init];
    token.url = url;
    token.downloadToken = downloadToken;
    return token;
}

- (void)cancelWithToken:(CC_WebImageDownloadToken *)token{
    if (!token || !token.url) {
        return;
    }
    LOCK(self.URLsLock);
    CC_WebImageOperation* operation = [self.URLOperations objectForKey:token.url];
    UNLOCK(self.URLsLock);
    if (operation) {
        BOOL hasCancelTask = [operation cancelWithToken:token.downloadToken];
        if (hasCancelTask) {
            LOCK(self.URLsLock);
            [self.URLOperations removeObjectForKey:token.url];
            UNLOCK(self.URLsLock);
        }
    }
}

@end
