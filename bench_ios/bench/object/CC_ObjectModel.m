//
//  CC_ObjectModel.m
//  bench_ios
//
//  Created by gwh on 2018/10/18.
//  Copyright © 2018 apple. All rights reserved.
//

#import "CC_ObjectModel.h"

@implementation CC_ObjectModel

+ (void)showModels{
    [self showModelsWithbackColor:0];
}

+ (void)showModelsWithbackColor:(int)color{
    UIScrollView *background=[[UIScrollView alloc]initWithFrame:CGRectMake(0, [ccui getY], [ccui getW], [ccui getH])];
    
    if (color==0) {
        background.backgroundColor=COLOR_WHITE;
    }else{
        background.backgroundColor=COLOR_BLACK;
    }
    
    float top=[ccui getRH:50]+[ccui getY];
    NSArray *names=[CC_UIHelper getInstance].modelPaths;
    for (int i=0; i<names.count; i++) {
        
        NSDictionary *modelDic=[NSDictionary dictionaryWithContentsOfFile:names[i]];
        id model=[ccs dataToObject:modelDic[@"model"]];
        
        if ([model isKindOfClass:[UIView class]]) {
            UIView *temp=model;
            if (modelDic[@"layer"]) {
                CALayer *layer=[ccs dataToObject:modelDic[@"layer"]];
                [temp.layer addSublayer:layer];
            }
            temp.left=[ccui getRH:10];
            temp.top=top;
            [background addSubview:temp];
            top=temp.bottom+[ccui getRH:5];
            
            UITextView *textV=[[UITextView alloc]init];
            textV.frame=CGRectMake([ccui getRH:10], top, [ccui getW]-[ccui getRH:20], [ccui getRH:65]);
            if (color==0) {
                textV.textColor=COLOR_BLACK;
                textV.backgroundColor=COLOR_WHITE;
            }else{
                textV.textColor=COLOR_WHITE;
                textV.backgroundColor=COLOR_BLACK;
            }
            textV.editable=NO;
            textV.text=[NSString stringWithFormat:@"name:%@\ntype:%@\ndes:%@",modelDic[@"name"],[model class],modelDic[@"des"]];
            [background addSubview:textV];
            top=textV.bottom+[ccui getRH:5];
        }
    }
    
    if (top>background.height) {
        background.contentSize=CGSizeMake(background.width, top);
    }
    
    [[CC_Code getLastWindow]addSubview:background];
    
}

+ (void)showModel:(id)object{
    [self showModel:object backColor:0];
}

+ (void)showModel:(id)object backColor:(int)color{
    
    UIView *background=[[UIView alloc]initWithFrame:CGRectMake(0, [ccui getY], [ccui getW], [ccui getH])];
    
    if (color==0) {
        background.backgroundColor=COLOR_WHITE;
    }else{
        background.backgroundColor=COLOR_BLACK;
    }
    
    if ([object isKindOfClass:[UIView class]]) {
        
        UIView *temp=object;
        temp.center=CGPointMake([ccui getW]/2, [ccui getH]/2);
        
        [background addSubview:temp];
        
        [[CC_Code getLastWindow]addSubview:background];
    }
}




+ (id)getModel:(NSString *)name class:(Class)aClass{
    
    if (aClass==[CC_Button class]) {
        name=[NSString stringWithFormat:@"button_%@",name];
    }else if (aClass==[CC_View class]) {
        name=[NSString stringWithFormat:@"view_%@",name];
    }else if (aClass==[CC_Label class]) {
        name=[NSString stringWithFormat:@"label_%@",name];
    }else if (aClass==[CC_TextView class]) {
        name=[NSString stringWithFormat:@"textView_%@",name];
    }else if (aClass==[CC_ImageView class]) {
        name=[NSString stringWithFormat:@"imageView_%@",name];
    }
    NSString *modelPath=[CC_UIHelper getInstance].modelsDic[name];
    if (!modelPath) {
        return nil;
    }
    NSDictionary *modelDic=[NSDictionary dictionaryWithContentsOfFile:modelPath];
    id model=[ccs dataToObject:modelDic[@"model"]];
    if ([model isKindOfClass:[CC_Button class]]) {
        CC_Button *temp=model;
        if (modelDic[@"layer"]) {
            CALayer *layer=[ccs dataToObject:modelDic[@"layer"]];
            [temp.layer addSublayer:layer];
            return temp;
        }
    }
    return model;
}

+ (NSString *)saveModel:(UIView *)model name:(NSString *)name des:(NSString *)des hasSetLayer:(BOOL)hasSetLayer{
    
    if ([CC_Share getInstance].ccDebug==0) {
        return nil;
    }
    //优化空间 遍历每个属性保存属性而不是data
    NSMutableDictionary *mutDic=[[NSMutableDictionary alloc]init];
    [mutDic setObject:name forKey:@"name"];
    [mutDic setObject:des forKey:@"des"];
    
    NSData *data=[ccs copyToData:model];
    [mutDic setObject:data forKey:@"model"];
    if (hasSetLayer) {
        NSData *data=[ccs copyToData:model.layer];
        [mutDic setObject:data forKey:@"layer"];
    }
    
    NSString *newName;
    if ([model isKindOfClass:[CC_Button class]]) {
        newName=[NSString stringWithFormat:@"button_%@",name];
    }else if ([model isKindOfClass:[CC_View class]]) {
        newName=[NSString stringWithFormat:@"view_%@",name];
    }else if ([model isKindOfClass:[CC_Label class]]) {
        newName=[NSString stringWithFormat:@"label_%@",name];
    }else if ([model isKindOfClass:[CC_TextView class]]) {
        newName=[NSString stringWithFormat:@"textView_%@",name];
    }else if ([model isKindOfClass:[CC_ImageView class]]) {
        newName=[NSString stringWithFormat:@"imageView_%@",name];
    }
    NSString *path=[ccs saveLocalFile:mutDic withPath:[NSString stringWithFormat:@"model/%@",newName] andType:@"plist"];
    CCLOG(@"modelpath:%@",path);
    
    return path;
}

@end
