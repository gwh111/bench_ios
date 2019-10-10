//
//  CC_TabBarController.m
//  bench_ios
//
//  Created by gwh on 2019/9/3.
//

#import "CC_TabBarController.h"
#import "UIColor+CC.h"
#import "CC_CoreUI.h"

#define CCTABBAR_SELECTED_Color RGBA(36, 151, 235, 1)
#define CCTABBAR_NORMAL_Color   RGBA(167, 164, 164, 1)

@interface CC_TabBarController ()

@property (nonatomic, strong) NSMutableArray *cc_classArray;
@property (nonatomic, strong) NSMutableArray *cc_titleArray;
@property (nonatomic, strong) NSMutableArray *cc_imgNameArray;
@property (nonatomic, strong) NSMutableArray *cc_selectedImgNameArray;
@property (nonatomic, strong) UIColor *cc_titleColor;
@property (nonatomic, strong) UIColor *cc_selectedTitleColor;

@property (nonatomic, strong) NSMutableArray *cc_tabBarItemArray;

@end

@implementation CC_TabBarController

@synthesize cc_controllers,cc_viewControllers,cc_tabBarItemArray;

- (void)cc_registerController:(CC_Controller *)controller {
    controller.cc_delegate = [CC_Base.shared cc_init:CC_Delegate.class];
    controller.cc_delegate.delegate = self;
    [controller cc_willInit];
    [cc_controllers cc_addObject:controller];
}

- (CC_Controller *)cc_controllerWithName:(NSString *)name {
    for (CC_Controller *controller in cc_controllers) {
        if ([controller.cc_name isEqualToString:name]) {
            return controller;
        }
    }
    return nil;
}

- (void)cc_viewWillLoad {}

- (void)super_cc_viewWillLoad {
    cc_controllers = [CC_Base.shared cc_init:NSMutableArray.class];
    cc_viewControllers = [CC_Base.shared cc_init:NSMutableArray.class];
    cc_tabBarItemArray = [CC_Base.shared cc_init:NSMutableArray.class];
}

- (void)cc_viewDidLoad {}

- (void)super_cc_viewDidLoad {
    
}

- (void)cc_viewWillAppear {}

- (void)cc_viewWillDisappear {}

- (void)cc_didReceiveMemoryWarning {}

- (void)cc_dealloc {}

#pragma mark config
- (void)cc_initWithClasses:(NSArray *)classes
                    images:(NSArray *)images
            selectedImages:(NSArray *)selectedImages {
    [self cc_initWithClasses:classes
                      titles:[NSArray new]
                      images:images
              selectedImages:selectedImages
                  titleColor:nil
          selectedTitleColor:nil];
    
}

- (void)cc_initWithClasses:(NSArray *)classes
                    titles:(NSArray *)titles
                    images:(NSArray *)images
            selectedImages:(NSArray *)selectedImages
                titleColor:(UIColor *)titleColor
        selectedTitleColor:(UIColor *)selectedTitleColor {
    self.cc_classArray = [classes mutableCopy];
    self.cc_titleArray = [titles mutableCopy];
    self.cc_imgNameArray = [images mutableCopy];
    self.cc_selectedImgNameArray = [selectedImages mutableCopy];
    self.cc_titleColor = titleColor ? : CCTABBAR_NORMAL_Color;
    self.cc_selectedTitleColor = selectedTitleColor ? : CCTABBAR_SELECTED_Color;
    [self setUpChildViewController];
}

- (void)cc_addTabBarItemWithClass:(id)cls
                            image:(NSString *)image
                    selectedImage:(NSString *)selectedImage
                            index:(NSInteger)index
{
    [self cc_addTabBarItemWithClass:cls
                              title:nil
                              image:image
                      selectedImage:selectedImage
                              index:index];
}

- (void)cc_addTabBarItemWithClass:(id)cls
                            title:(NSString *)title
                            image:(NSString *)image
                    selectedImage:(NSString *)selectedImage
                            index:(NSInteger)index {
    if (index > self.cc_viewControllers.count) return;
    
    [self.cc_classArray insertObject:cls atIndex:index];
    if (title && index <= self.cc_titleArray.count) {
        [self.cc_titleArray insertObject:title atIndex:index];
    }
    [self.cc_imgNameArray insertObject:image atIndex:index];
    [self.cc_selectedImgNameArray insertObject:selectedImage atIndex:index];
    
    CC_ViewController *vc = [CC_Base.shared cc_init:cls];
    if (![vc isKindOfClass:CC_ViewController.class]) {
        CCLOG(@"use 'CC_ViewController'");
    }
    vc.parent = self;
    UITabBarItem *item = [self addChildViewController:vc
                                                title:title
                                                image:image
                                        selectedImage:selectedImage
                                                index:index];
    
    [self.cc_tabBarItemArray insertObject:item atIndex:index];
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.cc_viewControllers insertObject:vc atIndex:index];
    self.viewControllers = self.cc_viewControllers;
}

- (void)cc_deleteItemAtIndex:(NSInteger)index {
    if (index >= self.cc_viewControllers.count) {
        CCLOG(@"cannot find index = %ld tab ",index);
        return;
    }
    [self.cc_classArray removeObjectAtIndex:index];
    [self.cc_titleArray removeObjectAtIndex:index];
    [self.cc_imgNameArray removeObjectAtIndex:index];
    [self.cc_selectedImgNameArray removeObjectAtIndex:index];
    
    [self.cc_tabBarItemArray removeObjectAtIndex:index];
    [self.cc_viewControllers removeObjectAtIndex:index];
    
    self.viewControllers = self.cc_viewControllers;
}

// if number > '99' will show '99+' as result.
- (void)cc_updateBadgeNumber:(NSUInteger)badgeNumber atIndex:(NSInteger)index {
    UITabBarItem *tabBarItem = self.cc_tabBarItemArray[index];
    if (badgeNumber == 0) {
        [tabBarItem setBadgeValue:nil];// 隐藏角标
    } else if (badgeNumber > 99) {
        [tabBarItem setBadgeValue:@"99+"];
    } else {
        [tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d",(int)badgeNumber]];
    }
}

#pragma kit function
- (void)viewDidLoad {
    [super viewDidLoad];
    [self super_cc_viewWillLoad];
    [self cc_viewWillLoad];
    [self super_cc_viewDidLoad];
    [self cc_viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self cc_viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self cc_viewWillDisappear];
}

- (void)didReceiveMemoryWarning {
    [self cc_didReceiveMemoryWarning];
}

- (void)dealloc {
    [cc_controllers removeAllObjects];
    [self cc_dealloc];
}

#pragma mark - private
- (void)setUpChildViewController {
    for (int i = 0; i < self.cc_classArray.count; i++) {
        NSString *title = self.cc_titleArray.count ? self.cc_titleArray[i] : nil;
        CC_ViewController *vc = [CC_Base.shared cc_init:self.cc_classArray[i]];
        vc.parent = self;
        UITabBarItem *item = [self addChildViewController:vc
                                                    title:title
                                                    image:self.cc_imgNameArray[i]
                                            selectedImage:self.cc_selectedImgNameArray[i]
                                                    index:i];
        [self.cc_tabBarItemArray addObject:item];
//        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.cc_viewControllers addObject:vc];
    }
    self.viewControllers = self.cc_viewControllers;
}

- (UITabBarItem *)addChildViewController:(UIViewController *)childViewController
                                   title:(NSString *)title
                                   image:(NSString *)image
                           selectedImage:(NSString *)selectedImage
                                   index:(NSInteger)index {
    
    UITabBarItem *item = childViewController.tabBarItem;
    NSMutableDictionary *normalDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *selectedDic = [NSMutableDictionary dictionary];
    if (title) {
        item.title = title;
        normalDic[NSForegroundColorAttributeName] = self.cc_titleColor;
        normalDic[NSFontAttributeName] = RF(11);
        [item setTitleTextAttributes:normalDic forState:UIControlStateNormal];
        selectedDic[NSForegroundColorAttributeName] = self.cc_selectedTitleColor;
        selectedDic[NSFontAttributeName] = RF(11);
        [item setTitleTextAttributes:selectedDic forState:UIControlStateSelected];
        item.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        item.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
    return item;
}

@end
