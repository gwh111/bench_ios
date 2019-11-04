//
//  ccs+CatPhotoPicker.m
//  CatPhotoPicker
//
//  Created by gwh on 2019/10/15.
//  Copyright © 2019 gwh. All rights reserved.
//

#import "ccs+CatPhotoPicker.h"
//#import "CatPickerPhotoController.h"

@implementation ccs (CatPhotoPicker)

+ (id)catPhotoPicker_presentSingleModeWithDelegate:(id)delegate {
    id vc = [cc_message cc_targetClass:@"CatPickerPhotoController" method:@"controllerWithMode:delegate:" params:[CC_Int value:0], delegate];
    [cc_message cc_targetInstance:vc method:@"presentFromRootViewController:" params:delegate];
    return vc;
}

//+ (CatPickerPhotoController *)catPhotoPicker_presentViewControllerWithMode:(CatPickerPhotoMode)catPickerPhotoMode andDelegate:(id)delegate andViewController:(id)viewController {
//    CatPickerPhotoController *vc = [CatPickerPhotoController controllerWithMode:catPickerPhotoMode delegate:delegate];
//    [vc presentFromRootViewController:viewController];
//    vc.maxCount = 2;
//    return vc;
//}

@end
