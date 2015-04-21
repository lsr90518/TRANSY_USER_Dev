//
//  MDSettingViewController.h
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDSettingView.h"

@interface MDSettingViewController : UIViewController<MDSettingViewDelegate>

@property (strong, nonatomic) MDSettingView *settingView;

@end
