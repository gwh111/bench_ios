//
//  Test_FundationViewController.h
//  bench_ios
//
//  Created by relax on 2019/9/2.
//

#import "CC_ViewController.h"
@class Test_subModel;
NS_ASSUME_NONNULL_BEGIN

@interface Test_FundationViewController : CC_ViewController

@end

@interface Test_model : CC_Model

@property (nonatomic, copy) NSString *str1;

@property (nonatomic, copy) NSString *str2;

@property (nonatomic, strong) Test_subModel *subModel;

@end

@interface Test_subModel : CC_Model

@property (nonatomic, copy) NSString *subStr1;

@property (nonatomic, copy) NSString *subStr2;

@end

NS_ASSUME_NONNULL_END
