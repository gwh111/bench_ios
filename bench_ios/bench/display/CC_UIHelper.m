//
//  CC_UiHelper.m
//  NewWord
//
//  Created by gwh on 2017/12/15.
//  Copyright © 2017年 gwh. All rights reserved.
//

#import "CC_UIHelper.h"
#import "CC_Share.h"

@interface CC_UIHelper(){
    
}

@end
@implementation CC_UIHelper

static CC_UIHelper *instance = nil;
static dispatch_once_t onceToken;

+ (instancetype)getInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[CC_UIHelper alloc] init];
    });
    return instance;
}

- (void)initUIDemoWidth:(float)width andHeight:(float)height{
    
    [CC_Share getUpdate];
    
    _uiDemoWidth=width;
    _uiDemoHeight=height;
    
    _bigTitleFont=RF(24);
    _bigTitleFontColor=COLOR_BLACK;
    
    _titleFont=RF(18);
    _titleFontColor=ccRGBA(51, 51, 51, 1);
    
    _contentFont=RF(16);
    _contentFontColor=ccRGBA(102, 102, 102, 1);
    
    _dateFont=RF(12);
    _dateFontColor=ccRGBA(153, 153, 153, 1);
    
    _mainColor=ccRGBA(88, 149, 247, 1);
    _subColor=ccRGBA(111, 111, 111, 1);
    
}

- (float)getUIDemoWith{
    if (_uiDemoWidth==0) {
        NSLog(@"uninit uidemo");
    }
    return _uiDemoWidth;
}

- (float)getUIDemoHeight{
    if (_uiDemoHeight==0) {
        NSLog(@"uninit uidemo");
    }
    return _uiDemoHeight;
}

- (int)addModelDocument:(NSString *)path{
    if (!_modelPaths) {
        _modelPaths=[[NSMutableArray alloc]init];
    }
    
    //这里有优化空间：保存相同的路径前缀 和 名称
    NSArray *paths=[ccs getPathsOfType:@"plist" inDirectory:path];
    [_modelPaths addObjectsFromArray:paths];
    
    return (int)paths.count;
}

- (int)initModels{
    if (!_modelsDic) {
        _modelsDic=[[NSMutableDictionary alloc]init];
    }
    
    for (int i=0; i<_modelPaths.count; i++) {
        NSString *path=_modelPaths[i];
        NSString *name=[[path componentsSeparatedByString:@"/"] lastObject];
        name=[name stringByReplacingOccurrencesOfString:@".plist" withString:@""];
//        name=[[name componentsSeparatedByString:@"_"] lastObject];
        //如读取后加载到内存会太大浪费
//        NSDictionary *setupDic = [NSDictionary dictionaryWithContentsOfFile:path];
        [_modelsDic setObject:path forKey:name];
    }
    
    return (int)[_modelsDic allKeys].count;
}

@end

@implementation ccui

+ (UIFont *)getUIFontWithType:(NSString *)type{
    return [self getUIFontWithName:nil type:type];
}

+ (UIFont *)getUIFontWithName:(NSString *)name type:(NSString *)type{
    if ([type isEqualToString:@"超大标题"]) {
        if (name) {
            return [ccui getRelativeFont:name fontSize:34];
        }
        return [ccui getRelativeFont:@"Helvetica-Bold" fontSize:34];
    }else if ([type isEqualToString:@"较大标题"]) {
        if (name) {
            return [ccui getRelativeFont:name fontSize:22];
        }
        return [ccui getRelativeFont:@"Helvetica-Bold" fontSize:22];
    }else if ([type isEqualToString:@"标题栏标题"]) {
        if (name) {
            return [ccui getRelativeFont:name fontSize:18];
        }
        return [ccui getRelativeFont:@"Helvetica-Bold" fontSize:18];
    }else if ([name isEqualToString:@"正常标题"]) {
        if (name) {
            return [ccui getRelativeFont:name fontSize:16];
        }
        return RF(16);
    }else if ([name isEqualToString:@"昵称文本"]||[name isEqualToString:@"长文文本"]) {
        if (name) {
            return [ccui getRelativeFont:name fontSize:15];
        }
        return RF(15);
    }else if ([name isEqualToString:@"普通文本"]) {
        if (name) {
            return [ccui getRelativeFont:name fontSize:14];
        }
        return RF(14);
    }else if ([name isEqualToString:@"说明文本"]) {
        if (name) {
            return [ccui getRelativeFont:name fontSize:12];
        }
        return RF(12);
    }else if ([name isEqualToString:@"次要文本"]) {
        if (name) {
            return [ccui getRelativeFont:name fontSize:11];
        }
        return RF(11);
    }
    return RF(16);
}

+ (float)getStatusH{
    //获取状态栏的rect
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    return statusRect.size.height;
}

+ (UIFont *)getRFS:(float)fontSize{
    return [self getRelativeFont:nil fontSize:fontSize];
}
+ (UIFont *)getRelativeFont:(NSString *)fontName fontSize:(float)fontSize{
    if (CC_SCREEN_WIDTH<375) {
        fontSize=fontSize-2;
    }else if (CC_SCREEN_WIDTH==375){
        fontSize=fontSize;
    }else{
        float rate=[self getW]/[[CC_UIHelper getInstance]getUIDemoWith];
        if (fontSize<=10) {
            fontSize=10*rate;
            return [UIFont fontWithName:fontName size:fontSize];
        }
        fontSize=10+(fontSize-10)*rate;
    }
    if (fontName) {
        return [UIFont fontWithName:fontName size:fontSize];
    }
    return [UIFont systemFontOfSize:fontSize];
}
+ (UIFont *)getRelativeFont:(NSString *)fontName fontSize:(float)fontSize baseFontSize:(float)baseFontSize{
    float rate=[self getW]/[[CC_UIHelper getInstance]getUIDemoWith];
    if (fontSize<=10) {
        fontSize=10*rate;
        return [UIFont fontWithName:fontName size:fontSize];
    }
    fontSize=baseFontSize+(fontSize-baseFontSize)*rate;
    if (fontName) {
        return [UIFont fontWithName:fontName size:fontSize];
    }
    return [UIFont systemFontOfSize:fontSize];
}
+ (CGRect)adjustRelativeRect:(UIView *)obj xPoint:(int)pt_x yPoint:(int)pt_y{
    CGRect rect=obj.frame;
    return rect;
}
+ (CGRect)adjustRelativeRect:(UIView *)obj{
    CGRect rect=obj.frame;
    float x=[self getW]*rect.origin.x/[[CC_UIHelper getInstance] getUIDemoWith];
    float y=[self getH]*rect.origin.y/[[CC_UIHelper getInstance] getUIDemoHeight];
    float w=[self getW]*rect.size.width/[[CC_UIHelper getInstance] getUIDemoWith];
    float h=w*rect.size.height/rect.size.width;;
    CGRect new_rect=CGRectMake(x, y, w, h);
    obj.frame=new_rect;
    return new_rect;
}

+ (float)getRH:(float)height{
    return [self getRelativeHeight:height];
}

+ (float)getRelativeHeight:(float)height{
    return (int)(height*[self getW]/[[CC_UIHelper getInstance] getUIDemoWith]);
}

+ (CGRect)adjustRelativeRect:(UIView *)obj withFrameArr:(NSArray *)arr{
    if (arr.count<4) {
        CCLOG(@"arr.count<4");
        return CGRectNull;
    }
    if (arr.count>4) {
        CCLOG(@"arr.count>4");
    }
    float x=[self getW]*[arr[0]floatValue]/[[CC_UIHelper getInstance] getUIDemoWith];
    float y=[self getH]*[arr[1]floatValue]/[[CC_UIHelper getInstance] getUIDemoHeight];
    float w=[self getW]*[arr[2]floatValue]/[[CC_UIHelper getInstance] getUIDemoWith];
    float h=w*[arr[3]floatValue]/[arr[2]floatValue];;
    CGRect rect=CGRectMake(x, y, w, h);
    obj.frame=rect;
    return rect;
}

/**
 * 获取设备X
 */
+ (float)getX{
    return 0;
}

/**
 * 获取设备Y
 */
+ (float)getY{
    //    NSLog(@"h=%f",SCREEN_HEIGHT);
    if (CC_SCREEN_HEIGHT>=812) {
        return 44;
    }
    return 0;
}

+ (float)getSY{
    //    NSLog(@"h=%f",SCREEN_HEIGHT);
    if (CC_SCREEN_HEIGHT>=812) {
        return 44;
    }
    return 20;
}

/**
 * 获取设备Width
 */
+ (float)getW{
    return CC_SCREEN_WIDTH;
}

/**
 * 获取设备Height
 */
+ (float)getH{
    return CC_SCREEN_HEIGHT-[self getY];
}

+ (float)getSH{
    return CC_SCREEN_HEIGHT-[self getSY];
}

@end
