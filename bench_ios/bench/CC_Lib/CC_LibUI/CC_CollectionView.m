//
//  CC_CollectionView.m
//  bench_ios
//
//  Created by ml on 2019/9/6.
//

#import "CC_CollectionView.h"

@implementation CC_CollectionView

- (__kindof CC_CollectionView *(^)(id<UICollectionViewDelegate>))cc_delegate {
    return ^(id<UICollectionViewDelegate> delegate) {
        self.delegate = delegate;
        return self;
    };
}
- (__kindof CC_CollectionView *(^)(id<UICollectionViewDataSource>))cc_dataSource {
    return ^(id<UICollectionViewDataSource> dataSource) {
        self.dataSource = dataSource;
        return self;
    };
}

@end
