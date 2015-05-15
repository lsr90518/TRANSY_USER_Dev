//
//  MDRequestDetailViewController.h
//  Distribution
//
//  Created by Lsr on 4/19/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDRequestDetailView.h"
#import "MDRequestEditViewController.h"
#import "MDAPI.h"
#import "MDPackage.h"
#import "MDDriver.h"

@interface MDRequestDetailViewController : UIViewController<MDRequestDetailViewDelegate>

@property (strong, nonatomic) MDRequestDetailView   *requestDetailView;
@property (strong, nonatomic) NSMutableDictionary          *data;
@property (strong, nonatomic) MDPackage             *package;
@property (strong, nonatomic) MDDriver              *driver;

@end
