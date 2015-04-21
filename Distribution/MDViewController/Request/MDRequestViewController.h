//
//  MDRequestViewController.h
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDRequestView.h"
#import "MDAPI.h"
#import "MDPackage.h"
#import "MDUser.h"
#import <SVProgressHUD.h>

@interface MDRequestViewController : UIViewController<MDRequestViewDelegate>

@property (strong, nonatomic) MDRequestView *requestView;

@end
