//
//  CC_WebVC.h
//  bench_ios
//
//  Created by gwh on 2019/5/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CC_ViewController.h"
#import "CC_WebView.h"
#import "CC_Button.h"
#import "CC_NavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_WebViewController : CC_ViewController

@property(nonatomic,retain) NSString *urlStr;
@property(nonatomic,retain) NSString *htmlContent;

@end

NS_ASSUME_NONNULL_END
