//
//  RequestRecordDetailViewController.h
//  bench_ios
//
//  Created by admin on 2019/4/8.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "YCTextView.h"
@class YCTextView;
@interface RequestRecordDetailViewController : UIViewController

@property (nonatomic, strong)YCTextView *urlTV;
@property (nonatomic, strong)YCTextView *resultTV;

@end

@interface YCTextView : UITextView

@end

