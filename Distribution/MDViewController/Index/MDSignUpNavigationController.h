//
//  MDSignUpNavigationController.h
//  Distribution
//
//  Created by 各務 将士 on 2015/07/16.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDPhoneViewController.h"

@protocol MDSignUpDelegate;

@interface MDSignUpNavigationController : UINavigationController
@property (nonatomic, assign) id<MDSignUpDelegate> sign_delegate;

@end

@protocol MDSignUpDelegate <NSObject>

@optional
-(void) goToMainView:(UIViewController *)viewController;

@end