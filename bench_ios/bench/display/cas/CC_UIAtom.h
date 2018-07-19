//
//  CC_UIAtom.h
//  testautoview
//
//  Created by gwh on 2018/7/12.
//  Copyright © 2018年 gwh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "CC_Share.h"

/**
 * 控件的类别
 */
typedef enum : NSUInteger {
    CCView,
    CCLabel,
    CCButton,
    CCTextField,
    CCTextView,
} CCAtomType;

/**
 * 约束的类型
 */
typedef enum : NSUInteger {
    CCTopLeft,
    CCTopRight,
    CCBottomLeft,
    CCBottomRight,
} CCDisplayType;

@interface CC_UIAtom : NSObject

/**
 *  控件的名字
 */
@property (nonatomic,retain) NSString *atomName;
/**
 *  控件类型
 */
@property (nonatomic,assign) CCAtomType atomType;

/**
 *  任意控件 根据CCAtomType变化
 */
@property (nonatomic,retain) id atom;

/**
 *  使用时必须初始化布局
    [[CC_UIHelper getInstance]initUIDemoWidth:375 andHeight:750];
 *  创建一个控件添加到一个view上
 *  view 添加到这个view上
 *  name 控件的名字 给控件起一个名字
    名字必须和cas文件中的对应
 *  type 定义控件类型
 *  block 控件加载完的回调
 *  注意对控件动弹刷新 需要在回调后进行 否则会被覆盖
    类似Masonry布局的约束
    在cas文件里可以设置哪些属性？
    自行注意约束冲突，如设置了width就不能同时再设置left和right
    如给控件添加或者删除新属性 还需要重新编译
    width       : 控件宽
    height      : 控件高
    top         : 控件顶部距离父视图顶部的距离
    left        : 控件左侧距离父视图左侧的距离
    bottom      : 控件底部距离父视图底部的距离
    right       : 控件右侧距离父视图右侧的距离
    bgc         : 背景色
    text        : label,button等有text属性控件的文本
    tc          : label,button等有text属性控件的文本的颜色
    font        : @cas_propertykey(UIView, cas_font),
 
    cas文件要注意书写格式
    例子：
    CC_Button.MainVC_b_box1{
    top 123
    left 32
    width 132
    height 60
    text "我bu是CC_Button"
    tc "dce1fc"
    font 12
    }
 */
+ (id)initAt:(UIView *)view name:(NSString *)name type:(CCAtomType)type finishBlock:(void (^)(id atom))block;

@end
