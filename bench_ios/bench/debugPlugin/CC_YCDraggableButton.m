//
//  YCDraggableButton.m
//  testPod
//
//  Created by admin on 2019/4/2.
//  Copyright © 2019 yc. All rights reserved.
//

#import "CC_YCDraggableButton.h"
@interface YCDraggableButton()

@property (nonatomic, assign)CGPoint touchStartPosition;

@end

@implementation YCDraggableButton

#define yc_ScreenH [UIScreen mainScreen].bounds.size.height
#define yc_ScreenW [UIScreen mainScreen].bounds.size.width

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)

#define NAV_BAR_HEIGHT (44.f)
#define STATUS_BAR_HEIGHT (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))
#define STATUS_AND_NAV_BAR_HEIGHT (STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT)

//横竖屏问题
typedef NS_ENUM(NSInteger ,yc_FloatWindowDirection) {
    yc_FloatWindowLEFT,
    yc_FloatWindowRIGHT,
    yc_FloatWindowTOP,
    yc_FloatWindowBOTTOM
};

typedef NS_ENUM(NSInteger, yc_ScreenChangeOrientation) {
    yc_Change2Origin,
    yc_Change2Upside,
    yc_Change2Left,
    yc_Change2Right
};

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    self.touchStartPosition = [touch locationInView:_rootView];
    if(IS_IPHONE){
        self.touchStartPosition = [self ConvertDir:_touchStartPosition];
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint curPoint = [touch locationInView:_rootView];
    if(IS_IPHONE) curPoint = [self ConvertDir:curPoint];
    if (_rootView.frame.origin.y > 1.0) {
        self.superview.center = CGPointMake(curPoint.x, curPoint.y + STATUS_AND_NAV_BAR_HEIGHT);
    }else{
        self.superview.center = curPoint;
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint curPoint = [touch locationInView:_rootView];
    if(IS_IPHONE) curPoint = [self ConvertDir:curPoint];
    // if the start touch point is too close to the end point, take it as the click event and notify the click delegate
    if (pow((_touchStartPosition.x - curPoint.x),2) + pow((_touchStartPosition.y - curPoint.y),2) < 1) {
        [self.delegate draggableButtonClicked:self];
        return;
    }
    [self buttonAutoAdjust:curPoint];
    
}

-(void)buttonAutoAdjust:(CGPoint)curPoint {
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat W = yc_ScreenW;
    CGFloat H = yc_ScreenH;
    // (1,2->3,4 | 3,4->1,2)
    NSInteger judge = orientation + _initOrientation;
    if (IS_IPHONE && orientation != _initOrientation && judge != 3 && judge != 7) {
        W = yc_ScreenH;
        H = yc_ScreenW;
    }
    // distances to the four screen edges
    CGFloat left = curPoint.x;
    CGFloat right = IS_IPHONE ? (W - curPoint.x) : (yc_ScreenW - curPoint.x);
//    CGFloat top = curPoint.y;
//    CGFloat bottom = IS_IPHONE ? (H - curPoint.y) : (yc_ScreenH - curPoint.y);
    // find the direction to go
    yc_FloatWindowDirection minDir = yc_FloatWindowLEFT;
    CGFloat minDistance = left;
    if (right < minDistance) {
        minDistance = right;
        minDir = yc_FloatWindowRIGHT;
    }
//    if (top < minDistance) {
//        minDistance = top;
//        minDir = yc_FloatWindowTOP;
//    }
//    if (bottom < minDistance) {
//        minDir = yc_FloatWindowBOTTOM;
//    }
    
    switch (minDir) {
        case yc_FloatWindowLEFT: {
            [UIView animateWithDuration:0.3 animations:^{
                self.superview.center = CGPointMake(self.superview.frame.size.width/2, self.superview.center.y);
            }];
            break;
        }
        case yc_FloatWindowRIGHT: {
            [UIView animateWithDuration:0.3 animations:^{
                self.superview.center = CGPointMake(W - self.superview.frame.size.width/2, self.superview.center.y);
            }];
            break;
        }
        case yc_FloatWindowTOP: {
            [UIView animateWithDuration:0.3 animations:^{
                self.superview.center = CGPointMake(self.superview.center.x, self.superview.frame.size.height/2);
            }];
            break;
        }
        case yc_FloatWindowBOTTOM: {
            [UIView animateWithDuration:0.3 animations:^{
                self.superview.center = CGPointMake(self.superview.center.x, H - self.superview.frame.size.height/2);
            }];
            break;
        }
        default:
            break;
    }
}

- (void)buttonRotate {
    
    [self buttonAutoAdjust:self.center];
    
    if(IS_IPHONE){
        yc_ScreenChangeOrientation change2orien = [self screenChange];
        switch (change2orien) {
            case yc_Change2Origin:
                self.transform = _originTransform;
                break;
            case yc_Change2Left:
                self.transform = _originTransform;
                self.transform = CGAffineTransformMakeRotation(-90*M_PI/180.0);
                break;
            case yc_Change2Right:
                self.transform = _originTransform;
                self.transform = CGAffineTransformMakeRotation(90*M_PI/180.0);
                break;
            case yc_Change2Upside:
                self.transform = _originTransform;
                self.transform = CGAffineTransformMakeRotation(180*M_PI/180.0);
                break;
            default:
                break;
        }
    }
}

/**
 *  convert to the origin coordinate
 *
 *  UIInterfaceOrientationPortrait           = 1
 *  UIInterfaceOrientationPortraitUpsideDown = 2
 *  UIInterfaceOrientationLandscapeRight     = 3
 *  UIInterfaceOrientationLandscapeLeft      = 4
 */
- (CGPoint)ConvertDir:(CGPoint)p {
    
    yc_ScreenChangeOrientation change2orien = [self screenChange];
    // covert
    switch (change2orien) {
        case yc_Change2Left:
            return [self LandscapeLeft:p];
            break;
        case yc_Change2Right:
            return [self LandscapeRight:p];
            break;
        case yc_Change2Upside:
            return [self UpsideDown:p];
            break;
        default:
            return p;
            break;
    }
}

- (yc_ScreenChangeOrientation)screenChange {
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    // 1. yc_Change2Origin(1->1 | 2->2 | 3->3 | 4->4)
    if (_initOrientation == orientation) return yc_Change2Origin;
    
    // 2. yc_Change2Upside(1->2 | 2->1 | 4->3 | 3->4)
    NSInteger isUpside = orientation + _initOrientation;
    if (isUpside == 3 || isUpside == 7) return yc_Change2Upside;
    
    // 3. yc_Change2Left(1->4 | 4->2 | 2->3 | 3->1)
    // 4. yc_Change2Right(1->3 | 3->2 | 2->4 | 4->1)
    yc_ScreenChangeOrientation change2orien = 0;
    switch (_initOrientation) {
        case UIInterfaceOrientationPortrait:
            if (orientation == UIInterfaceOrientationLandscapeLeft)
                change2orien = yc_Change2Left;
            else if(orientation == UIInterfaceOrientationLandscapeRight)
                change2orien = yc_Change2Right;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            if (orientation == UIInterfaceOrientationLandscapeRight)
                change2orien = yc_Change2Left;
            else if(orientation == UIInterfaceOrientationLandscapeLeft)
                change2orien = yc_Change2Right;
            break;
        case UIInterfaceOrientationLandscapeRight:
            if (orientation == UIInterfaceOrientationPortrait)
                change2orien = yc_Change2Left;
            else if(orientation == UIInterfaceOrientationPortraitUpsideDown)
                change2orien = yc_Change2Right;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            if (orientation == UIInterfaceOrientationPortraitUpsideDown)
                change2orien = yc_Change2Left;
            else if(orientation == UIInterfaceOrientationPortrait)
                change2orien = yc_Change2Right;
            break;
            
        default:
            break;
    }
    return change2orien;
}

- (CGPoint)UpsideDown:(CGPoint)p {
    return CGPointMake(yc_ScreenW - p.x, yc_ScreenH - p.y);
}

- (CGPoint)LandscapeLeft:(CGPoint)p {
    return CGPointMake(p.y, yc_ScreenW - p.x);
}

- (CGPoint)LandscapeRight:(CGPoint)p {
    return CGPointMake(yc_ScreenH - p.y, p.x);
}

@end
