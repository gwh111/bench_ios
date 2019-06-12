//
//  RequestRecordCell.h
//  bench_ios
//
//  Created by admin on 2019/4/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HitBlock)(void);
@interface RequestRecordCell : UITableViewCell

@property (nonatomic, strong) UILabel *domainLabel;
@property (nonatomic, strong) UILabel *paramsLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, copy) HitBlock block;

@end

