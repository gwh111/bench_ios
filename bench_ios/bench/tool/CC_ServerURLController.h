//
//  CC_ServerURLController.h
//  ServerChange
//
//  Created by ml on 2019/5/31.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CC_ServerURLController : UIViewController

@property (nonatomic,copy) NSArray *info;

@end

UIKIT_EXTERN NSNotificationName const CCServerURLDoneNotification;

NS_ASSUME_NONNULL_END
