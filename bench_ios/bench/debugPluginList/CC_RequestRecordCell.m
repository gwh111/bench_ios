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
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hitAction)];
        [self addGestureRecognizer:tap];
    }
    return self;
    
}

- (void)initView {
    
    [self addSubview:self.paramsLabel];
    [self addSubview:self.domainLabel];
    [self addSubview:self.timeLabel];

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

-(UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 65, 375, 20)];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font = [UIFont systemFontOfSize:15];
    }
    return _timeLabel;

}

-(void)hitAction {
    self.block();
}

@end
