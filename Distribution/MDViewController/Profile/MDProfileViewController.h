//
//  MDProfileViewController.h
//  Distribution
//
//  Created by Lsr on 5/9/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDProfileView.h"
#import "MDDriver.h"
#import "MDUser.h"
#import <SVProgressHUD.h>
#import "MDAPI.h"

@interface MDProfileViewController : UIViewController<MDProfileViewDelegate>

@property (strong, nonatomic) MDProfileView     *profileView;
@property (strong, nonatomic) MDDriver          *driver;

@end
