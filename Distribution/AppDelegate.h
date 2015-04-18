//
//  AppDelegate.h
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDViewController.h"
#import "MDIndexViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MDIndexViewController* viewController;
@property (strong, nonatomic) UITabBarController *hogeTabController;



@end

