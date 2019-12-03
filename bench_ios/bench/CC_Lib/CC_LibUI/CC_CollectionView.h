//
//  CC_CollectionView.h
//  bench_ios
//
//  Created by ml on 2019/9/6.
//

#import <UIKit/UIKit.h>
#import "UIView+CCUI.h"
#import "UIScrollView+CCUI.h"

NS_ASSUME_NONNULL_BEGIN

@interface CC_CollectionView : UICollectionView <CC_CollectionViewChainProtocol,CC_CollectionViewChainExtProtocol>

/// 通过ccs.CollectionView创建时,默认布局为UICollectionViewFlowLayout
/// 可用该属性,进行布局设置
@property (nonatomic,weak) UICollectionViewFlowLayout *cc_flowLayout;

- (__kindof CC_CollectionView *(^)(id<UICollectionViewDelegate>))cc_delegate;
- (__kindof CC_CollectionView *(^)(id<UICollectionViewDataSource>))cc_dataSource;

@end

NS_ASSUME_NONNULL_END
