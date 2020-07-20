//
//  TempTests.m
//  bench_iosTests
//
//  Created by gwh on 2020/1/10.
//

#import <XCTest/XCTest.h>
#import "ccs.h"
#import "Son.h"

extern void instrumentObjcMessageSends(BOOL flag);

@interface TempTests : XCTestCase

@end

@implementation TempTests


- (void)testFrame {
    UIView *_viewA = [[UIView alloc] init];
    CGRect rectA = CGRectMake(10, 60, 100, 100);
    _viewA.frame = rectA;
    _viewA.bounds = CGRectMake(10, 0, 200, 20);
    CGRect temp = _viewA.frame;
    NSLog(@"%f",temp.origin.x);
    NSLog(@"%f",temp.origin.y);
    NSLog(@"%f",_viewA.bounds.origin.x);
    NSLog(@"%f",_viewA.bounds.origin.y);
    
    UIView *view = UIView.new;
    view.frame = CGRectMake(10, 10, 200, 20);
    [_viewA addSubview:view];
    NSLog(@"%f",view.frame.origin.x);
    NSLog(@"%f",view.frame.origin.y);
    NSLog(@"%f",view.bounds.origin.x);
    NSLog(@"%f",view.bounds.origin.y);
}

- (void)testTimeConsume {
    
     [self measureBlock:^{
         for (int i =0; i<1000; i++) {
             NSLog(@"this is a example");
         }
     }];
}

- (void)testBlock {
    NSMutableArray *arr1 = @[@"aaa"].mutableCopy;
    WS(weakSelf);
    id __weak weakArr = arr1;
    int (^block)(NSArray *arr) = ^(NSArray *arr) {
//        [arr1 removeAllObjects];
        NSLog(@"aaa=1%@",weakArr);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"bbb=%@",weakArr);
        });
        return 0;
    };
    block(@[]);
//    NSLog(@"aa=%@ %@",arr1,weakArr);
    
}

// p/t 二进制打印
// p/o 八进制打印
// p/d 十进制打印
// x/4gx

- (void)testA {
    int a[5]={1,2,3,4,5};
    int *ptr=(int *)(&a+1);
    printf("0=%d",*(ptr-4));
    //*(a+1)就是a[1]，*(ptr-1)就是a[4],执行结果是2，5
    
//    则ptr实际 是&(a[5]),也就是a+5
//    原因如下:
//    &a是数组指针，其类型为 int (*)[5];
//    而 指针加1要根据指针类型加上一定的值，不同类型的指针+1之后增 加的大小不同。
//    a是长度为5的int数组指针，所以要加 5*sizeof(int) 所以ptr实际是a[5] 但是prt与(&a+1)类型是不一样的(这点很重要) 所以prt-1只会减去sizeof(int*) a,&a的地址是一样的，但意思不一样 a是数组首地址，也就是a[0]的地址，&a是对象(数组)首地址，
//    a+1是数组下一元素的地址，即a[1],&a+1是下一个对象的地址， 即a[5].
    printf("1=%d,2=%d",*(a+1),*(ptr-1));
}

//+ (BOOL)isMemberOfClass:(Class)cls {
//    // 元类 VS 类
//    return object_getClass((id)self) == cls;
//}
//
//- (BOOL)isMemberOfClass:(Class)cls {
//    return [self class] == cls;
//}
//
//+ (BOOL)isKindOfClass:(Class)cls {
//    for (Class tcls = object_getClass((id)self); tcls; tcls = tcls->superclass) {
//        if (tcls == cls) return YES;
//    }
//    return NO;
//}
//
//- (BOOL)isKindOfClass:(Class)cls {
//    // 类  - NSObject 类 vs 父类 nil
//    for (Class tcls = [self class]; tcls; tcls = tcls->superclass) {
//        if (tcls == cls) return YES;
//    }
//    return NO;
//}

- (void)testClass {
    
    NSMutableDictionary *mutDic = NSMutableDictionary.new;
    BOOL isd = [mutDic isKindOfClass:NSDictionary.class];
    NSLog(@"isd %d %@ %@",isd,mutDic.class,NSDictionary.class);
    
    Son *son = Son.new;
    son.superclass;
    Son.superclass;
    
    // superclass
    if ([son isKindOfClass:Son.class]) {
        NSLog(@"ins isclass");
        //类/父类... 类
    }
    if ([son isMemberOfClass:Son.class]) {
        NSLog(@"ins isMemberOfClass");
        //类 类
    }
    if ([Son.class isKindOfClass:NSObject.class]) {
        NSLog(@"Sonclass isclass");
        //元类/父类...NSObject 类
    }
    
    instrumentObjcMessageSends(true);
    BOOL is = [son isMemberOfClass:NSObject.class];
    NSLog(@"is = %d",is);
    instrumentObjcMessageSends(false);
}

- (void)test1 {
    NSString *str = @"hi";
    NSString *str2 =[str substringFromIndex:2];
    NSLog(@"s=%@",str2);
}

+ (id)stringWithCString:(char *)nullTerminatedCString encoding:(NSStringEncoding)encoding {
    NSString *obj;
    obj = [self allocWithZone:NSDefaultMallocZone()];
    obj = [obj initWithCString:nullTerminatedCString encoding:encoding];
    return obj;
}

- (void)testObserve {
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {

        /*

         kCFRunLoopEntry = (1UL << 0), //即将进入Runloop 2^0 = 1

         kCFRunLoopBeforeTimers = (1UL << 1), //即将处理NSTimer 2^1 = 2

         kCFRunLoopBeforeSources = (1UL << 2), //即将处理Sources 2^2 = 4

         kCFRunLoopBeforeWaiting = (1UL << 5), //即将进入休眠  2^5 = 32

         kCFRunLoopAfterWaiting = (1UL << 6), //刚从休眠中唤醒  2^6 = 64

         kCFRunLoopExit = (1UL << 7), //即将退出runloop 2^7 = 128

         */

        //这里打印出来的数字是上面数字X的2^X

        NSLog(@"RunLoop状态  %zd", activity);

    });
}

- (void)testAuto {
    for (int i = 0; i < 10; i++) {
        NSLog(@"%@",[NSThread currentThread]);
        @autoreleasepool {
            NSString *str = @"ABc";
            NSString *string = [str lowercaseString];
            string = [string stringByAppendingString:@"xyz"];
            NSLog(@"%@",string);
            NSLog(@"%@",[NSThread currentThread]);
        }
    }
    
}
- (void)testKeyPath {
    NSArray *array = @[@{@"name": @"cookeee",@"code": @1},
                       @{@"name": @"jim",@"code": @2},
                       @{@"name": @"jim",@"code": @1},
                       @{@"name": @"jbos",@"code": @1}];
    NSLog(@"%@", [array valueForKeyPath:@"name"]);
    {
        NSArray *array = @[@{@"name": @"cookeee",@"code": @1},
                           @{@"name": @"jim",@"code": @2},
                           @{@"name": @"jim",@"code": @1},
                           @{@"name": @"jbos",@"code": @1}];
        NSLog(@"%@", [array valueForKeyPath:@"@distinctUnionOfObjects.name"]);
    }
    {
        // 大小写转换
        NSArray *array = @[@"name", @"w", @"aa", @"jimsa"];
        NSLog(@"%@", [array valueForKeyPath:@"uppercaseString"]);
    }
    {
        NSArray *array = @[@1, @2, @3, @4, @10];
        NSNumber *sum = [array valueForKeyPath:@"@sum.self"];
        NSNumber *avg = [array valueForKeyPath:@"@avg.self"];
        NSNumber *max = [array valueForKeyPath:@"@max.self"];
        NSNumber *min = [array valueForKeyPath:@"@min.self"];
        NSLog(@"sum = %@ %@ %@ %@",sum,avg,max,min);
    }
}

- (void)testSetKV {
    
    Son *son = Son.new;
    [son setValue:@(3) forKey:@"_y"];
    [son setValue:@"asd" forKey:@"_str"];
    NSLog(@"str=%@",son.str);
    [son setValue:@"asd1" forKey:@"p"];
    
//    NSLog(@"_p=%@",son.p);
    NSLog(@"isp=%@",son.isP);
    NSLog(@"y=%d",son._y);
}

- (void)testEncode {
    
    NSMutableCharacterSet *allowed = [NSMutableCharacterSet alphanumericCharacterSet];
    [allowed addCharactersInString:@"!*'();:@&=+$,/?%#[]<>&\\"];
    
    NSString *tempString = [@"!abc1" stringByAddingPercentEncodingWithAllowedCharacters:[allowed invertedSet]];
    
}

- (void)testExample {
    
    NSString *input = @"10030";
    NSString *output = [self output:input];
    NSLog(@"%@",output);
    
}

- (NSString *)output:(NSString *)input {
    NSDictionary *map = @{@"1":@"一",@"2":@"二",@"3":@"三",@"4":@"四",@"5":@"五",@"6":@"六",@"7":@"七",@"8":@"八",@"9":@"九",@"0":@"零",};
    NSArray *names = @[@"",@"十",@"百",@"千",@"万"];
    NSString *output = @"";
    
    NSArray *cs = [input cc_convertToWord];
    if (cs.count == 1) {
        output = map[[ccs string:cs[0]]];
    } else {
        for (int i = 0; i < cs.count; i++) {
            NSString *word = map[cs[i]];
            if ([output hasSuffix:@"零"] && [word isEqualToString:@"零"]) {
            } else {
                output = [ccs string:@"%@%@",output,word];
            }
            if (![word isEqualToString:@"零"]) {
                NSString *name = names[cs.count - i - 1];
                output = [ccs string:@"%@%@",output,name];
            }
        }
    }
    
    return output;
}

@end
