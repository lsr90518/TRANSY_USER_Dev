//
//  MDCreateProfileViewController.h
//  Distribution
//
//  Created by Lsr on 4/12/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDCreateProfileView.h"

@interface MDCreateProfileViewController : UIViewController<CreateProfileViewDelegate>

@property (strong, nonatomic) MDCreateProfileView *createProfileView;

@end
