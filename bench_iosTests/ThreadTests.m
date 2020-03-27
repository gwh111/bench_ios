//
//  ThreadTests.m
//  bench_iosTests
//
//  Created by gwh on 2020/1/4.
//

#import <XCTest/XCTest.h>
#import "ccs.h"

@interface ThreadTests : XCTestCase

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) dispatch_queue_t concurrentQueue;

@end

@implementation ThreadTests

- (void)testExample {

    
}

// 多线程情况下遍历
- (void)testDispatch_apply {
    dispatch_queue_t concurrent_queue = dispatch_queue_create("并行队列", DISPATCH_QUEUE_CONCURRENT);
    dispatch_apply(10, concurrent_queue, ^(size_t index) {
        NSLog(@"dispatch_apply==%zud===%@",index,[NSThread currentThread]);
    });
}

// barrier_sync会影响后续代码的执行 后跑end
- (void)testConcurrent_queue_barier_sync {
    NSLog(@"start");
    dispatch_queue_t concurrent_queue = dispatch_queue_create("并行队列", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_async(concurrent_queue, ^{
            NSLog(@"%d===%@",i,[NSThread currentThread]);
        });
        if (i == 5) {
            NSLog(@"barrier sync");
            dispatch_barrier_sync(concurrent_queue, ^{
                sleep(1);
                NSLog(@"dispatch_barrier_sync===%d===%@",i,[NSThread currentThread]);
            });
        }
    }
    NSLog(@"end");
}

// barrier_async不会影响后续代码的执行 先跑end
- (void)testConcurrent_queue_barier_async {
    NSLog(@"start");
    dispatch_queue_t concurrent_queue = dispatch_queue_create("并行队列", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_async(concurrent_queue, ^{
            NSLog(@"%d===%@",i,[NSThread currentThread]);
        });
        if (i == 5) {
            NSLog(@"barrier async");
            dispatch_barrier_async(concurrent_queue, ^{
                sleep(0.1);
                NSLog(@"dispatch_barrier_async===%d===%@",i,[NSThread currentThread]);
            });
        }
    }
    NSLog(@"end");
}

// 阻塞发请求的线程
- (void)testSemaStop {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [ccs delay:1 block:^{
            //请求回调
            dispatch_semaphore_signal(sema);
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    });
}

// 限制线程的最大并发数
- (void)testSema {
    int M = 10;
    int N = 20;
    dispatch_semaphore_t sema = dispatch_semaphore_create(M);
    for (NSInteger i = 0; i < N; i++) {
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             // 如果该信号量的值大于0，则使其信号量的值-1，否则，阻塞线程直到该信号量的值大于0或者达到等待时间。
             dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
             // task
             NSLog(@"doing %ld", (long)i);
             // task end
             dispatch_semaphore_signal(sema);
        });
    }
}

// 线程/队列死锁
- (void)testOperationWaitUntilFinishedDead {
    NSOperationQueue *operationQueue = [NSOperationQueue mainQueue];
    NSBlockOperation *blockOperation3 = [NSBlockOperation blockOperationWithBlock:^{
    //    sleep(3);
        NSLog(@"操作3执行完毕");
    }];
    //pat1
    [operationQueue addOperations:@[blockOperation3] waitUntilFinished:YES];

    // blockOperation3的执行相当于被添加到最后
    // pat2
    // 这里不会执行
}

- (void)testOperationWaitUntilFinished2 {
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
    NSBlockOperation *blockOperation3 = [NSBlockOperation blockOperationWithBlock:^{
//        sleep(3);
        NSLog(@"操作3执行完毕");
    }];
    NSLog(@"添加操作");
    [operationQueue addOperations:@[blockOperation3] waitUntilFinished:YES];
    NSLog(@"添加完成");
}

- (void)testOperationWaitUntilFinished {
    NSOperationQueue *operationQueue= [[NSOperationQueue alloc]init];
    NSBlockOperation *blockOperation3 = [NSBlockOperation blockOperationWithBlock:^{
//        sleep(3);
        NSLog(@"操作3执行完毕");
    }];
    
    NSBlockOperation *blockOperation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"操作2开始执行");
        [blockOperation3 waitUntilFinished];
        NSLog(@"操作2执行完毕");
    }];
    [operationQueue addOperation:blockOperation2];
    [operationQueue addOperation:blockOperation3];
}

- (void)testOperationPriority {
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
    operationQueue.maxConcurrentOperationCount = 1;
    NSBlockOperation *blockOperation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"低优先级任务");
    }];
    blockOperation1.queuePriority = NSOperationQueuePriorityLow;
    NSBlockOperation *blockOperation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"高优先级任务");
//        sleep(1);
    }];
    blockOperation2.queuePriority = NSOperationQueuePriorityHigh;
    NSBlockOperation *blockOperation3 = [NSBlockOperation blockOperationWithBlock:^{
        
    }];
    
    [blockOperation1 addDependency:blockOperation3];
    [blockOperation2 addDependency:blockOperation3];
    
    [operationQueue addOperation:blockOperation1];
    [operationQueue addOperation:blockOperation2];
    [operationQueue addOperation:blockOperation3];
}

// NSOperation可以调用start方法来执行任务，但默认是同步执行的
// 如果将NSOperation添加到NSOperationQueue（操作队列）中，系统会自动异步执行NSOperation中的操作
- (void)testOperationExecution2 {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        // 在主线程
        NSLog(@"下载1------%@", [NSThread currentThread]);
    }];
    
    // 添加额外的任务(在子线程执行) 异步
    [op addExecutionBlock:^{
        NSLog(@"下载2------%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"下载3------%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"下载4------%@", [NSThread currentThread]);
    }];
    
    [op start];
}

- (void)testOperationExecution {
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
    
    NSBlockOperation *blockOperation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"进入操作1");
        NSLog(@"%@", NSThread.currentThread);
        NSLog(@"操作1完成");
        NSLog(@"操作1完成");
        NSLog(@"操作1完成");
        NSLog(@"操作1完成");
        NSLog(@"操作1完成");
//        sleep(3);
    }];
    
    NSBlockOperation *blockOperation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"进入依赖操作");
    }];
    blockOperation1.completionBlock = ^{
        NSLog(@"blockOperation1 complete");
    };
    
    [blockOperation2 addDependency:blockOperation1];
    
    // 追加是并发的
    [blockOperation1 addExecutionBlock:^{
        NSLog(@"%@", NSThread.currentThread);
        NSLog(@"进入追加操作");
        NSLog(@"追加操作完成");
//        sleep(5);
    }];
    
    [operationQueue addOperation:blockOperation1];
    [operationQueue addOperation:blockOperation2];
}

// 如果所插入的操作存在依赖关系、优先完成依赖操作。
// 如果所插入的操作不存在依赖关系、队列并发数为1下采用先进先出的原则、反之直接开辟新的线程执行
- (void)testOperationDependency {
    //创建操作队列
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
    operationQueue.maxConcurrentOperationCount = 1;
    //创建最后一个操作
    NSBlockOperation *lastBlockOperation = [NSBlockOperation blockOperationWithBlock:^{
//        sleep(1);
        NSLog(@"最后的任务");
    }];
    for (int i = 0; i < 3; ++i) {
        //创建多线程操作
        NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
//            sleep(i);
            NSLog(@"第%d个任务",i);
        }];
        //设置依赖操作为最后一个操作
        if (i == 0) {
            [blockOperation addDependency:lastBlockOperation];
        }
        [operationQueue addOperation:blockOperation];
    }
    //将最后一个操作加入线程队列
    [operationQueue addOperation:lastBlockOperation];
}

- (void)testConsumer {
    //生产者消费者
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    NSMutableArray *array = [[NSMutableArray alloc] init];
    dispatch_queue_t queue = dispatch_queue_create("cn.chutong.www", DISPATCH_QUEUE_CONCURRENT);
    int max_count = 10;
    //生产
    dispatch_async(queue, ^{
        int count = 0;
        while (YES) {
            if (array.count >= max_count) {
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            }
            count++;
            sleep(0.05f);
            [array addObject:[NSString stringWithFormat:@"%d",count]];
//            dispatch_semaphore_signal(semaphore);
            NSLog(@"生产了%d",count);
        }
    });
    //消费
    dispatch_async(queue, ^{
        while (YES) {
            if (array.count > 0) {
                NSLog(@"消费了%ld", array.count);
//                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//                [array removeLastObject];
                [array removeAllObjects];
                dispatch_semaphore_signal(semaphore);
            }

        }
    });
}

- (void)testSerial2 {
    dispatch_queue_t queue = dispatch_queue_create("com.gcd.serial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"异步任务在 %@ 执行", [NSThread currentThread]);
        dispatch_sync(queue, ^{
            NSLog(@"同步任务在 %@ 执行", [NSThread currentThread]);
        });
    });
}

- (void)testConcurrent {
    dispatch_queue_t serial =dispatch_queue_create("thedeeppacific",DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(serial, ^{
        sleep(1);
        NSLog(@"4");
    });

    dispatch_sync(serial, ^{
        sleep(2);
        NSLog(@"9");
    });

    dispatch_async(serial, ^{
        sleep(1);
        NSLog(@"5");
    });

    dispatch_sync(serial, ^{
        sleep(1);
        NSLog(@"8");
    });
    
}

- (void)testSerrial {
    dispatch_queue_t serial = dispatch_queue_create("thedeeppacific",DISPATCH_QUEUE_SERIAL);

    dispatch_sync(serial, ^{
        sleep(3);
        NSLog(@"1");
    });

    dispatch_async(serial, ^{
        sleep(4);
        NSLog(@"13");
    });

    dispatch_async(serial, ^{
        sleep(1);
        NSLog(@"11");
    });

    dispatch_sync(serial, ^{
        sleep(2);
        NSLog(@"2");
    });
    
}

- (void)testReadWriteLock {
    
    self.concurrentQueue = dispatch_queue_create("aaa", DISPATCH_QUEUE_CONCURRENT);
    // 测试代码,模拟多线程情况下的读写
    for (int i = 0; i<10; i++) {

        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.text = [NSString stringWithFormat:@"噼里啪啦--%d",i];
        });

    }
    
    for (int i = 0; i<50; i++) {

        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"end");
            NSLog(@"读 %@ %@",[self text],[NSThread currentThread]);
        });

    }
    
    for (int i = 10; i<20; i++) {

        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.text = [NSString stringWithFormat:@"噼里啪啦--%d",i];
        });

    }
}
 
// 写操作,栅栏函数是不允许并发的,所以"写操作"是单线程进入的,根据log可以看出来
- (void)setText:(NSString *)text {
    
    dispatch_barrier_async(self.concurrentQueue, ^{
        self.text = text;
        NSLog(@"写操作 %@ %@",text,[NSThread currentThread]);
        // 模拟耗时操作,1个1个执行,没有并发
        sleep(1);
    });
}
// 读操作,这个是可以并发的,log在很快时间打印完
- (NSString *)text {
 
    __block NSString * t = nil ;
    dispatch_sync(self.concurrentQueue, ^{
        t = self.text;
        // 模拟耗时操作,瞬间执行完,说明是多个线程并发的进入的
        sleep(1);
 
    });
    return t;
 
}
// end

- (void)testAsyncMain {
    NSLog(@"1");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
    // 1 3 2
}

- (void)test_sync_global {
    NSLog(@"1");
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2");
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

- (void)testAsySeq {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    NSLog(@"任务0完成 %@",NSThread.currentThread);
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务一完成 %@",NSThread.currentThread);
        
    });

    dispatch_group_async(group, queue, ^{
        NSLog(@"任务二完成 %@",NSThread.currentThread);
    });

    dispatch_group_async(group, queue, ^{
        NSLog(@"任务三完成 %@",NSThread.currentThread);
    });
    //在分组的所有任务完成后触发
    dispatch_group_notify(group, queue, ^{
        NSLog(@"所有任务完成 %@",NSThread.currentThread);
    });
    
}

- (void)testT2 {
    
    dispatch_queue_t queue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"111:%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"222:%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"333:%@",[NSThread currentThread]);
    });
    
}

@end
