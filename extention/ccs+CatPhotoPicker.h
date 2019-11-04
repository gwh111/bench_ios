//
//  ccs+CatPhotoPicker.h
//  CatPhotoPicker
//
//  Created by gwh on 2019/10/15.
//  Copyright © 2019 gwh. All rights reserved.
//


#import "ccs.h"
//#import "CatPickerPhotoController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ccs (CatPhotoPicker)

//+ (CatPickerPhotoController *)catPhotoPicker_presentViewControllerWithMode:(CatPickerPhotoMode)catPickerPhotoMode andDelegate:(id)delegate andViewController:(id)viewController;

+ (id)catPhotoPicker_presentSingleModeWithDelegate:(id)delegate;

@end

NS_ASSUME_NONNULL_END
