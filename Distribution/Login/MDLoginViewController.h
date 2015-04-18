//
//  MDLoginViewController.h
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDLoginView.h"


@interface MDLoginViewController : UIViewController<LoginViewDelegate>

@property (strong,nonatomic) MDLoginView *loginView;

@end
