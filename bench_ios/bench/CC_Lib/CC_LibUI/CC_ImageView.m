//
//  CC_ImageView.m
//  CCUILib
//
//  Created by ml on 2019/9/2.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CC_ImageView.h"
#import "UIView+CCWebImage.h"

@implementation CC_ImageView

- (__kindof CC_ImageView *(^)(NSString *))cc_imageNamed {
    return ^(NSString *imgName) {
        int channel = 0;
        if (imgName) {
            if ([imgName hasPrefix:@"file"]) {
                channel = 1;
            }
            
            switch (channel) {
                case 0: {
                    self.image = [UIImage imageNamed:imgName];
                }
                    break;
                case 1: {
                    self.image = [UIImage imageWithContentsOfFile:imgName];
                }
                    break;
                default:
                    break;
            }
        }
        
        return self;
    };
}

- (__kindof CC_ImageView *(^)(NSString *,UIImage *))cc_imageURL {
    return ^(NSString *imgName,UIImage *placeholderImage) {
        int channel = 0;
        if (imgName) {
            if ([imgName hasPrefix:@"http"]) {
                channel = 2;
            }
            switch (channel) {
                case 0: {
                    self.image = [UIImage imageNamed:imgName];
                }
                    break;
                case 2: {
                    if (placeholderImage) {
                        [self cc_setImageWithURL:[NSURL URLWithString:imgName] placeholderImage:placeholderImage];
                    }else {
                        [self cc_setImageWithURL:[NSURL URLWithString:imgName]];
                    }                    
                }
                    break;
                default:
                    break;
            }
        }
        
        return self;
    };
}

- (__kindof CC_ImageView *(^)(BOOL))cc_hideAnimation {
    return ^(BOOL hideAnimation) {
        self.hideAnimation = hideAnimation;
        return self;
    };
}

@end

@implementation CC_ImageView (CCActions)

@end
