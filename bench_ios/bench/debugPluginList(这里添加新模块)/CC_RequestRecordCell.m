//
//  RequestRecordCell.m
//  bench_ios
//
//  Created by admin on 2019/4/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CC_RequestRecordCell.h"

@implementation RequestRecordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
    
}

- (void)initView {
    
    [self addSubview:self.paramsLabel];
    [self addSubview:self.domainLabel];
//    [self addSubview:self.localTimeLabel];
    
}

-(UILabel *)paramsLabel {
    
    if (!_paramsLabel) {
        _paramsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 375, 22)];;
        _paramsLabel.font = [UIFont systemFontOfSize:17];
        _paramsLabel.numberOfLines = 0;
    }
    return _paramsLabel;
    
}

-(UILabel *)domainLabel {
    
    if (!_domainLabel) {
        _domainLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 375, 20)];
        _domainLabel.textColor = [UIColor grayColor];
        _domainLabel.font = [UIFont systemFontOfSize:15];
    }
    return _domainLabel;
    
}

//-(UILabel *)localTimeLabel {
//
//    if (!_localTimeLabel) {
//        _localTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 375, 20)];
//        _localTimeLabel.font = [UIFont systemFontOfSize:15];
//        _localTimeLabel.textColor = [UIColor grayColor];
//    }
//    return _localTimeLabel;
//
//}

@end
