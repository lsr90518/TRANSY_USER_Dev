//
//  MDViewController.m
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDViewController.h"
#import "MDDeliveryViewController.h"
#import "MDRequestViewController.h"
#import "MDSettingViewController.h"

#import "MDTabButton.h"

@interface MDViewController ()

@end

@implementation MDViewController
{
    MDDeliveryViewController              *_deliveryViewController;
    MDRequestViewController               *_requestViewController;
    MDSettingViewController               *_settingViewController;
    
    // Buttons
    NSMutableArray              *_buttonsArray;
    //key
    int _currentKey;
    // UITabController
    UITabBarController          *_tabController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //make TabController
    [self initTabController];
    
    //make tab button
    [self initTabButtons];
}

-(void) initTabController {
    _tabController = [[UITabBarController alloc] init];
    _tabController.view.frame = self.view.frame;
    
    //init view controller
    _deliveryViewController   =   [[MDDeliveryViewController    alloc]init];
    _requestViewController    =   [[MDRequestViewController     alloc]init];
    _settingViewController    =   [[MDSettingViewController     alloc]init];
    
    // navigation controller
    UINavigationController *deliveryViewController  =   [[UINavigationController alloc]initWithRootViewController:_deliveryViewController];
    UINavigationController *requestViewController   =   [[UINavigationController alloc]initWithRootViewController:_requestViewController];
    UINavigationController *settingViewController   =   [[UINavigationController alloc]initWithRootViewController:_settingViewController];
    
    // tab view controller
    _tabController.viewControllers = @[requestViewController,deliveryViewController,settingViewController];
    [self.view addSubview:_tabController.view];
    
    
    // Init
    _buttonsArray = [@[] mutableCopy];
    // Key
    _currentKey = -1;
    
}

- (void) initTabButtons {
    for (UIView *v in [_tabController.tabBar subviews]) {
        if ([[v class] isSubclassOfClass:[UIImageView class]]) {
            [v removeFromSuperview];
        }
    }
    
    //tab bar shadow
    UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
    [shadowView setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1]];
    [_tabController.tabBar addSubview:shadowView];
    
    //tab bar button
    for (int i = 0; i < 3; i++) {
        
        MDTabButton *tabButton = [[MDTabButton alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width / 3) * i, 0.5, ([UIScreen mainScreen].bounds.size.width / 3), 49.5) withTabType:i];
        [tabButton addTarget:self action:@selector(changeTab:) forControlEvents:UIControlEventTouchDown];
        [_tabController.tabBar addSubview:tabButton];
        [_buttonsArray addObject:tabButton];
    }
    [self changeTab:_buttonsArray[1]];
//    [_tabController.tabBar setBackgroundColor:[UIColor whiteColor]];
//
//    // 通知アイコン
//    _badgeView = [[MPOTabBadgeView alloc] initWithFrame:CGRectMake(227, 2, 15, 15)];
//    [_badgeView setBadgeNumber:[[MPONotificationManager sharedManager] getUnReadCount]];
//    [_tabController.tabBar addSubview:_badgeView];
}

#pragma mark - IBActions
- (void)changeTab:(MDTabButton *)button
{
    if (_currentKey == button.type) {
        UINavigationController *navCon = [_tabController.viewControllers objectAtIndex:_currentKey];
        [navCon popToRootViewControllerAnimated:YES];
    } else {
        _currentKey = button.type;
        [_buttonsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (_currentKey == idx) [(MDTabButton *)obj setButtonImage:YES];
            else                    [(MDTabButton *)obj setButtonImage:NO];
        }];
        [_tabController setSelectedViewController:[_tabController.viewControllers objectAtIndex:_currentKey]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
