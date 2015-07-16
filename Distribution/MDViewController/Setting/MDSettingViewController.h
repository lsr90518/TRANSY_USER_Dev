//
//  MDSettingViewController.h
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDSettingView.h"
#import "MDUtil.h"
#import "MDUser.h"

@protocol MDLogoutDelegate;
@interface MDSettingViewController : UIViewController<MDSettingViewDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) MDSettingView *settingView;
@property (nonatomic, assign) id<MDLogoutDelegate> delegate;

@end

@protocol MDLogoutDelegate <NSObject>
@optional
-(void) logoutDone;

@end