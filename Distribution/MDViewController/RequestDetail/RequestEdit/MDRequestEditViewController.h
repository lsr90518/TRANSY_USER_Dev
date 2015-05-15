//
//  MDRequestEditViewController.h
//  Distribution
//
//  Created by Lsr on 4/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDInput.h"
#import "MDSelect.h"
#import "MDPicker.h"
#import "MDPackage.h"

@interface MDRequestEditViewController : UIViewController<MDSelectDelegate,MDPickerDelegate>

@property (strong ,nonatomic) MDPackage *package;

-(void) setData:(NSDictionary *)data;

@end
