//
//  ThreadTests.m
//  bench_iosTests
//
//  Created by gwh on 2020/1/4.
//

#import <XCTest/XCTest.h>
//#import "ccs.h"

@interface ThreadTests : XCTestCase

@end

@implementation ThreadTests


- (void)testApply {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"apply---begin");
    dispatch_apply(6, queue, ^(size_t index) {
        
        NSLog(@"%zd---%@",index, [NSThread currentThread]);
        
    });
    NSLog(@"apply---end");

}

- (void)testExample {
    
    @synchronized (self) {
        // syncList 全局的表 syncData
        // struct SyncList 的定义。正如我在上面提过，你可以把 SyncData 当做是链表中的节点。每个 SyncList 结构体都有个指向 SyncData 节点链表头部的指针，也有一个用于防止多个线程对此列表做并发修改的锁。
        // 每个 SyncData 包含一个 threadCount，这个 SyncData 对象中的锁会被一些线程使用或等待，threadCount 就是此时这些线程的数量。它很有用处，因为 SyncData 结构体会被缓存，threadCount==0 就暗示了这个 SyncData 实例可以被复用。
        // TLS 线程局部存储空间 线程1 线程2..
        // 先找线程 线程里找不到再全局遍历表 对象相等 拿对象锁的次数
    }

    dispatch_queue_t queue = dispatch_queue_create("aa", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_async(queue, ^{
        NSLog(@"2");
        NSLog(@"4");
//        dispatch_sync(queue, ^{
//            NSLog(@"3");
//        });
    });
    sleep(1);
    NSLog(@"5");
}

- (void)testRunloop {

    [NSRunLoop.currentRunLoop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [NSRunLoop.currentRunLoop run];
}

// 限制最大并发数
void dispatch_asyn_limit_3(dispatch_queue_t queue, dispatch_block_t block){
    //控制并发数的信号量
    static dispatch_semaphore_t limitSemaphore;
    //专门控制并发等待的线程
    static dispatch_queue_t receiveQueue;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        limitSemaphore = dispatch_semaphore_create(3);
        receiveQueue = dispatch_queue_create("receiver", DISPATCH_QUEUE_SERIAL);
    });
    
    dispatch_async(receiveQueue, ^{
        //若信号量小于0，则会阻塞receiveQueue的线程，控制添加到queue里的任务不会超过三个。
        dispatch_semaphore_wait(limitSemaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(queue, ^{
            if (block) {
                block();
            }
            //block执行完后增加信号量
            dispatch_semaphore_signal(limitSemaphore);
        });
    });
}

- (void)testQueues {
    for (int i = 0; i < 20; i++) {

        dispatch_queue_t sQ1 = dispatch_queue_create([NSString stringWithFormat:@"st%d",i].UTF8String, DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(sQ1, ^{
            NSLog(@"sQ1=%p %d",sQ1,i);
        });
        NSLog(@"sQ2=%p %d",sQ1,i);
    }
    
    
}

- (void)testDeadLock {
    // 串行队列死锁crash的例子（在同个线程的串行队列任务执行过程中，再次发送dispatch_sync 任务到串行队列，会crash）
    //==============================
//    dispatch_queue_t sQ = dispatch_queue_create("st0", 0);
//    dispatch_async(sQ, ^{
//        NSLog(@"Enter");
//        dispatch_sync(sQ, ^{   //  这里会crash
//            NSLog(@"sync task");
//        });
//    });

    // 串行死锁的例子（这里不会crash，在线程A执行串行任务task1的过程中，又在线程B中投递了一个task2到串行队列同时使用dispatch_sync等待，死锁，但GCD不会测出）
    //==============================
    dispatch_queue_t sQ1 = dispatch_queue_create("st01", 0);
    dispatch_async(sQ1, ^{
        NSLog(@"Enter");
        dispatch_sync(dispatch_get_main_queue(), ^{
            dispatch_sync(sQ1, ^{
                NSArray *a = [NSArray new];
                NSLog(@"Enter again %@", a);
            });
        });
        NSLog(@"Done");
    });
    
}

- (void)testAsyncMain {
    NSLog(@"1");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
    // 1 3 2
}

- (void)test_sync_global {
    
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t aHQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_queue_t aLQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    
    NSLog(@"1 %@",aQueue);
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        NSLog(@"2 %@",aQueue);
    });
    NSLog(@"3");
    // 1 2 3
}

- (void)test_async_global {
    NSLog(@"1");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
    // 1 3 2
}

- (void)test_async_mulity {
    static int ii = 0;
    for (int i = 0; i < 5; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            sleep(1);
            ii++;
            // 线程会重复
            // 执行顺序不一定
            NSLog(@"i=%d ii=%d thread=%@", i, ii, [NSThread currentThread]);
    //        iii++;// Variable is not assignable (missing __block type specifier)
        });
//        [self performSelector:@selector(test)];
//        NSLog(@"test=%d", i);
//        [self performSelectorInBackground:@selector(testBackground) withObject:nil];
//        [self performSelector:@selector(testBackground) withObject:nil afterDelay:1];
    }
    NSLog(@"ii=%d thread=%@", ii, [NSThread currentThread]);
    // i=1 ii=2 thread=<NSThread: 0x600002c22ec0>
    // ii=0 thread=<NSThread: 0x600002ceb480> // 位置不确定
    // i=2 ii=3 thread=<NSThread: 0x600002c49980>
    // i=3 ii=4 thread=<NSThread: 0x600002ce7c40>
    // i=0 ii=1 thread=<NSThread: 0x600002cfa280>
    // i=4 ii=5 thread=<NSThread: 0x600002cbd540>
}

- (void)test_sync_mulity {
    static int ii = 0;
    for (int i = 0; i < 5; i++) {
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
//            sleep(1);
            ii++;
            // 线程会重复
            // 按顺序执行
            NSLog(@"i=%d ii=%d thread=%@", i, ii, [NSThread currentThread]);
    //        iii++;// Variable is not assignable (missing __block type specifier)
        });
//        [self performSelector:@selector(test)];
//        NSLog(@"test=%d", i);
//        [self performSelectorInBackground:@selector(testBackground) withObject:nil];
//        [self performSelector:@selector(testBackground) withObject:nil afterDelay:1];
    }
    NSLog(@"ii=%d thread=%@", ii, [NSThread currentThread]);
    // i=1 ii=2 thread=<NSThread: 0x600002c22ec0>
    // i=2 ii=3 thread=<NSThread: 0x600002c49980>
    // i=3 ii=4 thread=<NSThread: 0x600002ce7c40>
    // i=0 ii=1 thread=<NSThread: 0x600002cfa280>
    // i=4 ii=5 thread=<NSThread: 0x600002cbd540>
    // ii=5 thread=<NSThread: 0x6000000e1580> // 确定最后执行
}

- (void)testSynchronized {
    NSObject *obj = [[NSObject alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(self) {
            NSLog(@"需要线程同步的操作1 开始");
            sleep(3);
            NSLog(@"需要线程同步的操作1 结束");
        }
    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        @synchronized(obj) {
            NSLog(@"需要线程同步的操作2");
        }
        @synchronized(self) {
            NSLog(@"需要线程同步的操作3");
        }
    });
    // 需要线程同步的操作1 开始
    // 需要线程同步的操作2
    // 需要线程同步的操作1 结束
    // 需要线程同步的操作3
    // synchronized中传入的object的内存地址，被用作key，通过hash map对应的一个系统维护的递归锁。
    // 如果object 被外部访问变化，则就失去了锁的作用。所以最好本类声明一个对象属性来当做key

    
}

@end
