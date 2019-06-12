//
//  CC_WebVC.h
//  bench_ios
//
//  Created by gwh on 2019/5/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CC_WebVC : UIViewController

@property(nonatomic,retain) WKWebView *webV;
@property(nonatomic,retain) NSString *urlStr;

+ (void)presentWeb:(NSString *)urlStr;

@end

NS_ASSUME_NONNULL_END
