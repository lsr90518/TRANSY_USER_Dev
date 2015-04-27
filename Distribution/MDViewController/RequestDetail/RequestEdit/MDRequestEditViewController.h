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

@interface MDRequestEditViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong ,nonatomic) NSDictionary *data;

-(void) setData:(NSDictionary *)data;

@end
