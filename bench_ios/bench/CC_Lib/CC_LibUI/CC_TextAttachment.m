//
//  CC_TextAttachment.m
//  bench_ios
//
//  Created by gwh on 2019/6/28.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import "CC_TextAttachment.h"

@implementation CC_TextAttachment
@synthesize emojiSize,offsetY;

#pragma mark clase "CC_TextAttachment" property extention
- (CC_TextAttachment *(^)(NSString *))cc_emojiTag{
    return ^(NSString *emojiTag){
        self.emojiTag = emojiTag;
        return self;
    };
}

- (CC_TextAttachment *(^)(NSString *))cc_emojiName{
    return ^(NSString *emojiName){
        self.emojiName = emojiName;
        return self;
    };
}

- (CC_TextAttachment *(^)(CGFloat))cc_emojiSize{
    return ^(CGFloat emojiSize){
        self.emojiSize = emojiSize;
        return self;
    };
}

- (CC_TextAttachment *(^)(CGFloat))cc_offsetY{
    return ^(CGFloat offsetY){
        self.offsetY = offsetY;
        return self;
    };
}

#pragma mark function
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex{
    return [self scaleImageSizeToWidth:emojiSize];
}

// Scale image size
- (CGRect)scaleImageSizeToWidth:(CGFloat)width{
    //Scale factor
    CGFloat factor = 1.0;
    
    //Get image size
    CGSize oriSize = [self.image size];
    
    //Calculate factor
    if (emojiSize>0) {
        factor = (CGFloat) (width/oriSize.width);
    }
    
    //Get new size
    CGRect newSize = CGRectMake(0, offsetY!=-4?offsetY:-4, oriSize.width * factor, oriSize.height * factor);
    
    return newSize;
}

@end
