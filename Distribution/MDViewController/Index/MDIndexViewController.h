//
//  MDIndexViewController.h
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDIndexView.h"
#import "MDPhoneViewController.h"
#import "MDLoginViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MDMainNavigationController.h"
#import "MDCreateProfileViewController.h"
#import "MDSignUpNavigationController.h"


@interface MDIndexViewController : UIViewController<indexDelegate, MDMainNavigationControllerDelegate, MDLoginDelegate, MDSignUpDelegate>

@property (strong, nonatomic) MDIndexView *indexView;
@property (strong, nonatomic) AVPlayer    *avPlayer;
@property (strong, nonatomic) UINavigationController *loginNav;
@property (strong, nonatomic) MDSignUpNavigationController *signNav;
@property (strong, nonatomic) MDMainNavigationController *mdMainNavigationController;


@end
