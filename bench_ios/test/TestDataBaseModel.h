//
//  TestDataBaseModel.h
//  bench_ios
//
//  Created by relax on 2019/9/29.
//

#import "TestDataBaseSuperModel.h"

@class TestCar,TestCity,TestSchool;

NS_ASSUME_NONNULL_BEGIN

@interface TestDataBaseModel : TestDataBaseSuperModel

@property (nonatomic, assign) char sex;
@property (nonatomic, assign) unsigned char unsignedSex;
@property (nonatomic, assign) long longAge;
@property (nonatomic, assign) unsigned long unsignedlongAge;
@property (nonatomic, assign) long long longlongAge;
@property (nonatomic, assign) unsigned long long unsignedlonglongAge;
@property (nonatomic, assign) short age;
@property (nonatomic, assign) unsigned short unsignedshortAge;
@property (nonatomic, assign) int intAge;
@property (nonatomic, assign) unsigned int unsignedintAge;
@property (nonatomic, assign) float weight;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) BOOL isDeveloper;

@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) NSInteger integer;
@property (nonatomic, assign) NSUInteger uinteger;
@property (nonatomic, copy)   NSString *xx;
@property (nonatomic, copy)   NSString *yy;
@property (nonatomic, copy)   NSString *ww;
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, strong) TestCar *car;
@property (nonatomic, strong) TestSchool *school;
@property (nonatomic, strong) NSNumber *zz;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSArray <TestCar *>*array;
@property (nonatomic, strong) NSArray *carArray;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSDictionary *dictCar;

@end

@interface TestSchool : CC_Model

@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) NSUInteger personCount;
@property (nonatomic, strong) TestCity *city;

@end

@interface TestCity : CC_Model

@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) NSInteger personCount;

@end

@interface TestCar : CC_Model

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *brand;

@end

NS_ASSUME_NONNULL_END
