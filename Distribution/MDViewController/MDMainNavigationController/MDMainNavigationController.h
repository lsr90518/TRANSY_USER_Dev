//
//  MDMainNavigationController.h
//  Distribution
//
//  Created by 各務 将士 on 2015/07/17.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDAPI.h"
#import "MDDeliveryViewController.h"
#import "MDRequestViewController.h"
#import "MDSettingViewController.h"
#import "MDPackageService.h"

@protocol MDMainNavigationControllerDelegate;

@interface MDMainNavigationController : UINavigationController
@property (nonatomic, assign) id<MDMainNavigationControllerDelegate> main_delegate;

-(void) logoutDone;
@end

@protocol MDMainNavigationControllerDelegate <NSObject>
@optional
-(void) closeAllView;

@end