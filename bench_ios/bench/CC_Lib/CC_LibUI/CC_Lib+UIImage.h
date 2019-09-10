//
//  UIImage+CCLib.h
//  testbenchios
//
//  Created by gwh on 2019/8/6.
//  Copyright © 2019 gwh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CC_Foundation.h"

@interface UIImage (CC_Lib)

- (UIImage *)cc_scaleToKb:(NSInteger)kb;

- (NSData *)cc_compressWithMaxLength:(NSUInteger)maxLength;

@end
