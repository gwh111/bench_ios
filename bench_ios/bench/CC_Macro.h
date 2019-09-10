//
//  CC_Macro.h
//  testbenchios
//
//  Created by gwh on 2019/8/1.
//  Copyright © 2019 gwh. All rights reserved.
//

#ifndef CC_Macro_h
#define CC_Macro_h

#define COLOR_LIGHT_GREEN [UIColor colorWithRed:107/255.0f green:221/255.0f blue:123/255.0f alpha:1]
#define COLOR_LIGHT_BLUE [UIColor colorWithRed:62/255.0f green:188/255.0f blue:202/255.0f alpha:1]
#define COLOR_LIGHT_ORANGE [UIColor colorWithRed:223/255.0f green:142/255.0f blue:57/255.0f alpha:1]
#define COLOR_LIGHT_PURPLE [UIColor colorWithRed:211/255.0f green:53/255.0f blue:226/255.0f alpha:1]
#define COLOR_LIGHT_RED [UIColor colorWithRed:247/255.0f green:126/255.0f blue:129/255.0f alpha:1]
#define COLOR_LIGHT_YELLOW [UIColor colorWithRed:255/255.0f green:251/255.0f blue:152/255.0f alpha:1]
#define COLOR_LIGHT_PINK [UIColor colorWithRed:255/255.0f green:174/255.0f blue:233/255.0f alpha:1]

//iPhoneX
#define CC_iPhoneX (MAX(CC_SCREEN_WIDTH, CC_SCREEN_HEIGHT) >= 812)
// tabBar高度
#define CC_TAB_BAR_HEIGHT (CC_iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define CC_HOME_INDICATOR_HEIGHT (CC_iPhoneX ? 34.f : 0.f)

#endif /* CC_Macro_h */
