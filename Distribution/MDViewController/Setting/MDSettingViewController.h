//
//  MDSettingViewController.h
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

@class MDMainNavigationController;

#import <UIKit/UIKit.h>
#import "MDSettingView.h"
#import "MDUtil.h"
#import "MDUser.h"

@interface MDSettingViewController : UIViewController<MDSettingViewDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) MDSettingView *settingView;
@property (strong, nonatomic) MDMainNavigationController *mainNav;

@end