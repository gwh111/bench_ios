//
//  CC_TextAttachment.h
//  bench_ios
//
//  Created by gwh on 2019/6/28.
//  Copyright © 2019 Liuyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"

NS_ASSUME_NONNULL_BEGIN

/*
 exp:
 NSMutableAttributedString *att=[[NSMutableAttributedString alloc]init];
 CC_TextAttachment *attachment=[CC_TextAttachment new];
 attachment.emojiTag=@"count";
 attachment.image=[UIImage imageNamed:@"chat_time_count"];
 attachment.emojiSize=16;
 [att appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
 */

@interface CC_TextAttachment : NSTextAttachment

- (CC_TextAttachment *(^)(NSString *))cc_emojiTag;
- (CC_TextAttachment *(^)(NSString *))cc_emojiName;
- (CC_TextAttachment *(^)(CGFloat))cc_emojiSize;
- (CC_TextAttachment *(^)(CGFloat))cc_offsetY;

@property(strong, nonatomic) NSString *emojiTag;
@property(strong, nonatomic) NSString *emojiName;
@property(assign, nonatomic) CGFloat emojiSize;
@property(assign, nonatomic) CGFloat offsetY;

@end

NS_ASSUME_NONNULL_END
