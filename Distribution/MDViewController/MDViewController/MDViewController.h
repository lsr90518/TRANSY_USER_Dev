//
//  MDViewController.h
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDDeliveryViewController.h"
#import "MDRequestViewController.h"
#import "MDSettingViewController.h"

@protocol MDViewDelegate;

@interface MDViewController : UIViewController<MDLogoutDelegate>
@property (nonatomic, assign) id<MDViewDelegate> delegate;

@end


@protocol MDViewDelegate <NSObject>
@optional
-(void) closeAllView;

@end