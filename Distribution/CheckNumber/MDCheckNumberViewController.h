//
//  MDCheckNumberViewController.h
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDInput.h"
#import "MDWell.h"
#import "MDAPI.h"


@interface MDCheckNumberViewController : UIViewController

@property (strong, nonatomic) MDInput *inputView;
@property (strong, nonatomic) NSString *phoneNumber;

@end
