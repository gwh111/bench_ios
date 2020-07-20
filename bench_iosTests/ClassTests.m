//
//  TestClass.m
//  bench_iosTests
//
//  Created by gwh on 2020/1/5.
//

#import <XCTest/XCTest.h>
#import "ccs.h"
#import "CC_Runtime.h"
#import <objc/runtime.h>
#import "Father.h"
#import "Son.h"

@interface ClassTests : XCTestCase

@end

@implementation ClassTests

- (void)testExample {
    
}

- (void)testFatherSon {
    
    Father *f = Son.new;
    NSLog(@"%d",f.x);
    // father init
    // son add
    // son init
    // son add
}

- (void)testSonSon {
    
    Son *f = Son.alloc.init2;
    NSLog(@"%d",f.x);
    
}

- (void)testClassCompare {

    Father *f = Father.new;
    
    Son *s = Son.new;
    NSLog(@"%@ %@",f.class,s.class);
    NSLog(@"%d %d",[f isKindOfClass:s.class],[f isMemberOfClass:s.class]);
    NSLog(@"%d %d",[s isKindOfClass:f.class],[s isMemberOfClass:f.class]);
    NSLog(@"%d %d",[f isKindOfClass:f.class],[f isMemberOfClass:f.class]);
    
    
}

- (void)testMeta {
    ClassTests *cat = [[ClassTests alloc] init];
        
    Class cls = object_getClass(cat); //TestThread(Class)
    const char *name1 = class_getName(cls);               //"TestThread"
    int is1 = class_isMetaClass(cls);           //NO

    Class meta = object_getClass(cls); //TestThread(meta-class)
    const char *name2 = class_getName(meta);               //"TestThread"
    int is2 = class_isMetaClass(meta);            //YES

    Class meta_meta = object_getClass(meta); //TestThread(meta-class)
    const char *name3 = class_getName(meta_meta);                //"NSObject"
    int is3 = class_isMetaClass(meta_meta);            //YES
        
    NSLog(@"%d %d %d %s %s %s",is1,is2,is3,name1,name2,name3);
}

@end
