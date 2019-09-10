//
//  CCUIScaffold.h
//  bench_ios
//
//  Created by ml on 2019/9/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CC_View,CC_Label,CC_Button,CC_ScrollView,CC_TextField,CC_TextView,CC_TableView,CC_CollectionView,CC_WebView;

/**
 链式辅助协议
 通用属性最终调用 UIView+CCUI
 特殊类型比如代理,交由对应类实现
 
 */

@protocol CC_View <NSObject>

- (__kindof CC_View *(^)(UIView *))cc_addToView;
- (__kindof CC_View *(^)(UIColor *))cc_backgroundColor;
- (__kindof CC_View *(^)(CGFloat))cc_cornerRadius;
- (__kindof CC_View *(^)(BOOL))cc_userInteractionEnabled;
- (__kindof CC_View *(^)(UIColor *))cc_borderColor;
- (__kindof CC_View *(^)(CGFloat))cc_borderWidth;
- (__kindof CC_View *(^)(BOOL))cc_hidden;
- (__kindof CC_View *(^)(CGFloat))cc_alpha;
- (__kindof CC_View *(^)(NSString *))cc_name;
- (__kindof CC_View *(^)(CGFloat))cc_tag;
- (__kindof CC_View *(^)(UIViewContentMode))cc_contentMode;

@end

@protocol CC_Label <NSObject>

- (__kindof CC_Label *(^)(UIView *))cc_addToView;
- (__kindof CC_Label *(^)(UIColor *))cc_backgroundColor;
- (__kindof CC_Label *(^)(CGFloat))cc_cornerRadius;
- (__kindof CC_Label *(^)(BOOL))cc_userInteractionEnabled;
- (__kindof CC_Label *(^)(UIColor *))cc_borderColor;
- (__kindof CC_Label *(^)(CGFloat))cc_borderWidth;
- (__kindof CC_Label *(^)(BOOL))cc_hidden;
- (__kindof CC_Label *(^)(CGFloat))cc_alpha;
- (__kindof CC_Label *(^)(NSString *))cc_name;
- (__kindof CC_Label *(^)(CGFloat))cc_tag;
- (__kindof CC_Label *(^)(UIViewContentMode))cc_contentMode;

@end

@protocol CC_Button <NSObject>

- (__kindof CC_Button *(^)(UIView *))cc_addToView;
- (__kindof CC_Button *(^)(UIColor *))cc_backgroundColor;
- (__kindof CC_Button *(^)(CGFloat))cc_cornerRadius;
- (__kindof CC_Button *(^)(BOOL))cc_userInteractionEnabled;
- (__kindof CC_Button *(^)(UIColor *))cc_borderColor;
- (__kindof CC_Button *(^)(CGFloat))cc_borderWidth;
- (__kindof CC_Button *(^)(BOOL))cc_hidden;
- (__kindof CC_Button *(^)(CGFloat))cc_alpha;
- (__kindof CC_Button *(^)(NSString *))cc_name;
- (__kindof CC_Button *(^)(CGFloat))cc_tag;
- (__kindof CC_Button *(^)(UIViewContentMode))cc_contentMode;

@end

@protocol CC_TextField <NSObject>

- (__kindof CC_TextField *(^)(UIView *))cc_addToView;
- (__kindof CC_TextField *(^)(UIColor *))cc_backgroundColor;
- (__kindof CC_TextField *(^)(CGFloat))cc_cornerRadius;
- (__kindof CC_TextField *(^)(BOOL))cc_userInteractionEnabled;
- (__kindof CC_TextField *(^)(UIColor *))cc_borderColor;
- (__kindof CC_TextField *(^)(CGFloat))cc_borderWidth;
- (__kindof CC_TextField *(^)(BOOL))cc_hidden;
- (__kindof CC_TextField *(^)(CGFloat))cc_alpha;
- (__kindof CC_TextField *(^)(NSString *))cc_name;
- (__kindof CC_TextField *(^)(CGFloat))cc_tag;
- (__kindof CC_TextField *(^)(UIViewContentMode))cc_contentMode;

@end

@protocol CC_TextView <NSObject>

- (__kindof CC_TextView *(^)(UIView *))cc_addToView;
- (__kindof CC_TextView *(^)(UIColor *))cc_backgroundColor;
- (__kindof CC_TextView *(^)(CGFloat))cc_cornerRadius;
- (__kindof CC_TextView *(^)(BOOL))cc_userInteractionEnabled;
- (__kindof CC_TextView *(^)(UIColor *))cc_borderColor;
- (__kindof CC_TextView *(^)(CGFloat))cc_borderWidth;
- (__kindof CC_TextView *(^)(BOOL))cc_hidden;
- (__kindof CC_TextView *(^)(CGFloat))cc_alpha;
- (__kindof CC_TextView *(^)(NSString *))cc_name;
- (__kindof CC_TextView *(^)(CGFloat))cc_tag;
- (__kindof CC_TextView *(^)(UIViewContentMode))cc_contentMode;

@end

@protocol CC_ScrollView <NSObject>

- (__kindof CC_ScrollView *(^)(UIView *))cc_addToView;
- (__kindof CC_ScrollView *(^)(UIColor *))cc_backgroundColor;
- (__kindof CC_ScrollView *(^)(CGFloat))cc_cornerRadius;
- (__kindof CC_ScrollView *(^)(BOOL))cc_userInteractionEnabled;
- (__kindof CC_ScrollView *(^)(UIColor *))cc_borderColor;
- (__kindof CC_ScrollView *(^)(CGFloat))cc_borderWidth;
- (__kindof CC_ScrollView *(^)(BOOL))cc_hidden;
- (__kindof CC_ScrollView *(^)(CGFloat))cc_alpha;
- (__kindof CC_ScrollView *(^)(NSString *))cc_name;
- (__kindof CC_ScrollView *(^)(CGFloat))cc_tag;
- (__kindof CC_ScrollView *(^)(UIViewContentMode))cc_contentMode;

@end

@protocol CC_TableView <NSObject>

- (__kindof CC_TableView *(^)(UIView *))cc_addToView;
- (__kindof CC_TableView *(^)(UIColor *))cc_backgroundColor;
- (__kindof CC_TableView *(^)(CGFloat))cc_cornerRadius;
- (__kindof CC_TableView *(^)(BOOL))cc_userInteractionEnabled;
- (__kindof CC_TableView *(^)(UIColor *))cc_borderColor;
- (__kindof CC_TableView *(^)(CGFloat))cc_borderWidth;
- (__kindof CC_TableView *(^)(BOOL))cc_hidden;
- (__kindof CC_TableView *(^)(CGFloat))cc_alpha;
- (__kindof CC_TableView *(^)(NSString *))cc_name;
- (__kindof CC_TableView *(^)(CGFloat))cc_tag;
- (__kindof CC_TableView *(^)(UIViewContentMode))cc_contentMode;

- (__kindof CC_TableView *(^)(id<UITableViewDataSource>))cc_datesource;
- (__kindof CC_TableView *(^)(id<UITableViewDelegate>))cc_delegate;

@end

@protocol CC_CollectionView <NSObject>

- (__kindof CC_CollectionView *(^)(UIView *))cc_addToView;
- (__kindof CC_CollectionView *(^)(UIColor *))cc_backgroundColor;
- (__kindof CC_CollectionView *(^)(CGFloat))cc_cornerRadius;
- (__kindof CC_CollectionView *(^)(BOOL))cc_userInteractionEnabled;
- (__kindof CC_CollectionView *(^)(UIColor *))cc_borderColor;
- (__kindof CC_CollectionView *(^)(CGFloat))cc_borderWidth;
- (__kindof CC_CollectionView *(^)(BOOL))cc_hidden;
- (__kindof CC_CollectionView *(^)(CGFloat))cc_alpha;
- (__kindof CC_CollectionView *(^)(NSString *))cc_name;
- (__kindof CC_CollectionView *(^)(CGFloat))cc_tag;
- (__kindof CC_CollectionView *(^)(UIViewContentMode))cc_contentMode;

@end

@protocol CC_WebView <NSObject>

- (__kindof CC_WebView *(^)(UIView *))cc_addToView;
- (__kindof CC_WebView *(^)(UIColor *))cc_backgroundColor;
- (__kindof CC_WebView *(^)(CGFloat))cc_cornerRadius;
- (__kindof CC_WebView *(^)(BOOL))cc_userInteractionEnabled;
- (__kindof CC_WebView *(^)(UIColor *))cc_borderColor;
- (__kindof CC_WebView *(^)(CGFloat))cc_borderWidth;
- (__kindof CC_WebView *(^)(BOOL))cc_hidden;
- (__kindof CC_WebView *(^)(CGFloat))cc_alpha;
- (__kindof CC_WebView *(^)(NSString *))cc_name;
- (__kindof CC_WebView *(^)(CGFloat))cc_tag;
- (__kindof CC_WebView *(^)(UIViewContentMode))cc_contentMode;

@end

NS_ASSUME_NONNULL_END
