//
//  TestModel.h
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "CC_Model.h"
@class TestSubModel,TestSubArrayModel;
@interface TestModel : CC_Model

@property (nonatomic, copy) void(^block)(NSString *str);
- (void)addBlock:(void(^)(NSString *str))block;

@property (nonatomic,assign) int intv;
@property (nonatomic,retain) NSString *robots;

@property (nonatomic,retain) NSString *jumpLogin;

@property (nonatomic,retain) NSString *nowTimestamp;

@property (nonatomic,retain) NSString *success;

@property (nonatomic,retain) NSString *nowDate;

@property (nonatomic,retain) NSArray *group2;

@property (nonatomic,retain) NSArray <TestSubArrayModel *>*groupUsers;

@property (nonatomic,retain) TestSubModel *group;

- (void)nothing2;

@end

@interface TestSubModel : CC_Model

@property (nonatomic,retain) NSString *groupUserCount;

@property (nonatomic,retain) NSString *groupName;

@property (nonatomic,retain) NSString *groupLogoUrl;

@end

@interface TestSubArrayModel : CC_Model

@property (nonatomic,retain) NSString *groupId;

@end
