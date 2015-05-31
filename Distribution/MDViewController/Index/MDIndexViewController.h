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
#import "MDDeliveryViewController.h"

@interface MDIndexViewController : UIViewController<indexDelegate>

@property (strong, nonatomic) MDIndexView *indexView;

@property (strong, nonatomic) AVPlayer    *avPlayer;


@end
