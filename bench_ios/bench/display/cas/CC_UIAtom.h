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
    CCAtomTypeView,
    CCAtomTypeLabel,
    CCAtomTypeButton,
    CCAtomTypeTextField,
    CCAtomTypeTextView,
    CCAtomTypeImageView,
} CCAtomType;

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
    marginTop         : 控件顶部距离父视图或指定控件顶部的距离
    marginLeft        : 控件左侧距离父视图或指定控件左侧的距离
    marginBottom      : 控件底部距离父视图或指定控件底部的距离
    marginRight       : 控件右侧距离父视图或指定控件右侧的距离
 
    更多查看UIView+ClassyExtend.h文件
 
    cas文件要注意书写格式
    例子：
     CC_Label.MainVC_l_box2{
     below MainVC_b_box1
     toRightOf MainVC_b_box1
     marginLeft 10
     marginTop 50
     widthSameAs MainVC_v_figure1
     heightSameAs MainVC_v_figure1
     backgroundColor "EE82EE"
     text "我是CC_Label"
     textColor "6E6E6E"
     }
    }
 */
+ (id)initAt:(UIView *)view name:(NSString *)name type:(CCAtomType)type;
+ (id)initAt:(UIView *)view name:(NSString *)name type:(CCAtomType)type finishBlock:(void (^)(id atom))block;

/**
 *  创建通用扩展类
 *  class 所有其他类名创建的类
 *  其他用法和使用type时相同
 */
+ (id)initAt:(UIView *)view name:(NSString *)name class:(id)atomClass;
+ (id)initAt:(UIView *)view name:(NSString *)name class:(id)atomClass finishBlock:(void (^)(id atom))block;

@end
