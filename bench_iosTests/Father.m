//
//  Father.m
//  bench_iosTests
//
//  Created by gwh on 2020/1/5.
//

#import "Father.h"

@implementation Father

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _name = @"father";
        
        _x = 10;
        [self add:2];
        
        NSLog(@"father super=%@",[super class]);
        // 我们都知道 self 是类的隐藏参数,指向调用方法的这个类的实例，是一个 指针。而 super 跟 self 不一样,并不是指向父类的指针，只是一个 编译器修饰符 作用。
        // 用 self 调用方法是从该类的方法列表当中找对应方法调用，如果没有就从父类当中找；而 super 关键词是从父类的方法列表当中找，调用父类的那个方法。但是这两种方式的事件调用者都是当前的实例 Son ,最终都是找到了 NSObject 中的 class 的方法。
        
    }
    return self;
}

- (void)add:(int)y {
    _x = _x + y;
}

// 重写get
//- (NSString *)name {
//    return @"getName=father";
//}

@end
