//
//  CC_DomainController.m
//  bench_ios
//
//  Created by ml on 2019/10/9.
//

#import "CC_DomainController.h"
#import "CC_View.h"
#import "CC_TableView.h"
#import "Sub_DomainCenter.h"
#import "CC_HttpHelper.h"
#import "ccs.h"
#import "CC_CoreBase.h"

@interface CC_DomainController () <UITableViewDataSource,UITableViewDelegate> {
    NSArray *_domainURLs;
    BOOL _isSingle;
}

@end

@implementation CC_DomainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ccs TableViewWithStyle:UITableViewStyleGrouped]
    .cc_backgroundColor(HEX(DCDCDC))
    .cc_addToView(self.cc_displayView)
    .cc_dataSource(self)
    .cc_delegate(self)
    .cc_frame(0,0,WIDTH(),self.view.height);
    
    _domainURLs = [[CC_CoreBase.shared.sharedAppDelegate[@"Sub_DomainCenter"] domainURLs] copy];
    if ([_domainURLs.firstObject isKindOfClass:NSArray.class]) {
        _isSingle = NO;
    }else {
        _isSingle = YES;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_isSingle) {
        return 1;
    }
  
    return _domainURLs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isSingle) {
        return _domainURLs.count;
    }else {
        return [_domainURLs[section] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *domainURL = _isSingle ? _domainURLs[indexPath.row] : _domainURLs[indexPath.section][indexPath.row];
    
    UITableViewCell *cell = UITableViewCell.new;
    cell.textLabel.text = domainURL;
    cell.textLabel.textColor = HEX(333333);
    cell.backgroundColor = HEX(FFFFFF);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *domainURL = _isSingle ? _domainURLs[indexPath.row] : _domainURLs[indexPath.section][indexPath.row];
    
    HttpModel *model = [CC_Base.shared cc_init:HttpModel.class];
    model.forbiddenEncrypt = YES;
    [CC_HttpTask.shared get:domainURL params:nil model:model finishBlock:^(NSString *error, HttpModel *result) {
        if (error) {
            
        }else {
            [[NSNotificationCenter defaultCenter] postNotificationName:CCDomainChangedNotification object:result];
        }
    }];
}

@end
