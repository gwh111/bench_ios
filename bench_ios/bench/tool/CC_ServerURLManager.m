//
//  CC_ServerURLManager.m
//  LYServerChange
//
//  Created by ml on 2019/5/31.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CC_ServerURLManager.h"
#import <UIKit/UIKit.h>
#import "CC_ServerURLController.h"
#import "CC_UIViewExt.h"

#define CC_NOTIFICATION_CENTER  [NSNotificationCenter defaultCenter]
#define CC_ADD_NOFICATION(SEL,NAME) \
    [CC_NOTIFICATION_CENTER addObserver:self \
                               selector:@selector(SEL) \
                                   name:NAME \
                                 object:nil]
#define CC_REMOVE_NOTIFICATION(TARGET) [CC_NOTIFICATION_CENTER removeObserver:TARGET]

@interface CC_ServerURLManager () {
    NSMutableSet *_serverSet;
}

@property (nonatomic,weak) UIViewController *containVC;
@property (nonatomic,strong) NSMutableArray *infoM;
@property (nonatomic,copy) void (^completion)(NSArray *servers);

@end

@implementation CC_ServerURLManager

+ (instancetype)cc_defaultManager {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        [instance cc_configure];
    });
    return instance;
}

- (void)cc_configure {
    CC_ADD_NOFICATION(textFieldDidEndEditingAction:, UITextFieldTextDidEndEditingNotification);
    CC_ADD_NOFICATION(doneAction:, CCServerURLDoneNotification);
    
    self.infoM = [NSMutableArray array];
    _serverSet = [NSMutableSet set];
}

- (void)dealloc {
    CC_REMOVE_NOTIFICATION(self);
}

- (NSDictionary *)cc_setupWithURL:(NSString *)url name:(NSString *)name {
    NSParameterAssert(url);
    NSParameterAssert(name);
    
    return @{
             @"url":url,
             @"name":name,
           };
}

- (void)cc_setupWithGroup:(NSDictionary *)group
                     mode:(NSString *)mode {
    
    NSParameterAssert(mode);
    
    if ([_serverSet containsObject:mode]) { return; }
    
    NSMutableArray *internalInfoM = [NSMutableArray array];
    [group enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSDictionary *serverInfo = [self cc_setupWithURL:obj
                                                    name:key];
        [internalInfoM addObject:serverInfo];
    }];
    
    [_serverSet addObject:mode];
    
    NSDictionary *itemDic = @{
                              @"mode":mode,
                              @"items":[internalInfoM copy]
                            };
    
    [self.infoM addObject:itemDic];
    [internalInfoM removeAllObjects];
}

- (void)cc_setupWithURLDic:(NSDictionary *)urlDic {
    [urlDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [self cc_setupWithGroup:obj mode:key];
        }else {
            NSAssert(false, [NSString stringWithFormat:@"字段的值必须是NSDictionary类型"]);
        }
    }];
}

- (void)cc_setCompletion:(void (^)(NSArray * _Nonnull))completion {
    self.completion = completion;
}

#pragma mark - Actions -
- (void)textFieldDidEndEditingAction:(NSNotification *)sender {
    if (self.containVC.navigationController) {
        if ([self.containVC.navigationController.topViewController isKindOfClass:[CC_ServerURLController class]]) {            
            return;
        }
    }else {
        if ([self.containVC.presentedViewController isKindOfClass:[UINavigationController class]]) {
            return;
        }
    }
    [self _triggerWithTextField:sender.object];
}

- (void)doneAction:(NSNotification *)sender {
    if ([sender.name isEqualToString:CCServerURLDoneNotification]) {
        !self.completion ? : self.completion(sender.object);
    }
}

#pragma mark - Internal -
- (void)_triggerWithTextField:(UITextField *)td {
    if (td.text.length == 0)  { return ; }
    if ([td.text.uppercaseString isEqualToString:self.keyword.uppercaseString]) {
        self.containVC = [td viewController];
        [self _alert];
    }
}

- (void)_alert {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"调试菜单" message:@"[内部团队自用]" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"切换服务器" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        CC_ServerURLController *controller = [CC_ServerURLController new];
        controller.info = self.infoM.copy;
        if (self.containVC.navigationController) {
            [self.containVC.navigationController pushViewController:controller animated:YES];
        }else {
            UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:controller];
            [self.containVC presentViewController:navC animated:YES completion:nil];
        }
    }];
    
    [controller addAction:doneAction];
    [controller addAction:cancelAction];
    
    [self.containVC presentViewController:controller animated:YES completion:nil];
}

@end
