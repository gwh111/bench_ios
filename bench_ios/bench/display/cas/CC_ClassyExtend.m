//
//  CC_ClassyExtend.m
//  testautoview2
//
//  Created by gwh on 2018/7/17.
//  Copyright © 2018年 gwh. All rights reserved.
//

#import "CC_ClassyExtend.h"

@implementation CC_ClassyExtend

static CC_ClassyExtend *instance = nil;
static dispatch_once_t onceToken;

+ (instancetype)getInstance
{
    dispatch_once(&onceToken, ^{
        instance = [[CC_ClassyExtend alloc] init];
    });
    return instance;
}

+ (void)initSheet:(NSString *)path{
#if TARGET_IPHONE_SIMULATOR
    [CASStyler defaultStyler].watchFilePath = path;
#endif
}

+ (NSArray *)parseCasList{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"stylesheet" ofType:@"cas"];
    NSString *str=[[NSString alloc]initWithContentsOfFile:plistPath encoding:NSUTF8StringEncoding error:nil];
    str=[str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str=[str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if ([str hasSuffix:@";"]) {
        str=[str substringToIndex:str.length-1];
    }
    NSArray *listArr=[str componentsSeparatedByString:@";"];
    
    return listArr;
}

+ (NSString *)scanCasName:(NSString *)str{
    str=[str substringToIndex:str.length-1];
    NSArray *tempArr=[str componentsSeparatedByString:@"\""];
    NSString *fileFullName=[tempArr lastObject];
    fileFullName=[fileFullName stringByReplacingOccurrencesOfString:@".cas" withString:@""];
    NSArray *tempArr2=[fileFullName componentsSeparatedByString:@"/"];
    return [tempArr2 lastObject];
}

+ (void)parseCas{
    NSMutableDictionary *posMutDic=[[NSMutableDictionary alloc]init];
    
    NSArray *listArr=[self parseCasList];
    for (int i=0; i<listArr.count; i++) {
        NSString *fileName;
        fileName=[self scanCasName:listArr[i]];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"cas"];
        NSString *str=[[NSString alloc]initWithContentsOfFile:plistPath encoding:NSUTF8StringEncoding error:nil];
        
        NSScanner *theScanner;
        NSString *head = nil;
        NSString *text = nil;
        theScanner = [NSScanner scannerWithString:str];
        while ([theScanner isAtEnd] == NO) {
            [theScanner scanUpToString:@"{" intoString:&head] ;
            // find end of tag
            [theScanner scanUpToString:@"}" intoString:&text] ;
            
            head=[head stringByReplacingOccurrencesOfString:@" " withString:@""];
            head=[head stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            head=[head stringByReplacingOccurrencesOfString:@"}" withString:@""];
            text=[text stringByReplacingOccurrencesOfString:@"{" withString:@""];
            
            if (head.length<=0) {
                continue;
            }
            NSArray *headArr=[head componentsSeparatedByString:@"."];
            if (headArr.count<2) {
                CCLOG(@"head error=%@",head);
                return;
            }
            NSString *headName=headArr[1];
            
            NSArray *arr=[text componentsSeparatedByString:@"\n"];
            NSMutableDictionary *keyDic=[[NSMutableDictionary alloc]init];
            for (int i=0; i<arr.count; i++) {
                NSString *item=arr[i];
                if (item.length<=0) {
                    continue;
                }
                NSArray *it=[item componentsSeparatedByString:@" "];
                NSString *k=nil;
                NSString *v=nil;
                for (int m=0; m<it.count; m++) {
                    NSString *va=it[m];
                    if (va.length<=0) {
                        continue;
                    }
                    if (k) {
                        v=va;
                        v=[v stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                    }else{
                        k=va;
                    }
                }
                [keyDic setObject:ccstr(@"%@",v) forKey:k];
            }
            [posMutDic setObject:keyDic forKey:headName];
        }
        
    }
    
    [ccs saveLocalKeyNamed:@"ccCas" andKey:@"all" andValue:posMutDic];
//    CCLOG(@"posMutDic c=%lu %@",(unsigned long)[posMutDic allKeys].count,posMutDic);
    [CC_ClassyExtend getInstance].ccCasDic=[ccs getLocalKeyNamed:@"ccCas" andKey:@"all"];
    
}

@end
