//
//  MDReviewViewController.h
//  DistributionDriver
//
//  Created by 劉 松然 on 2015/05/08.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDReviewView.h"
#import "MDPackage.h"
#import "MDDriver.h"

@interface MDReviewViewController : UIViewController<MDReviewDelegate>

@property (strong, nonatomic) MDReviewView *reviewView;
@property (strong, nonatomic) MDPackage     *package;
@property (strong, nonatomic) MDDriver      *driver;

@end
