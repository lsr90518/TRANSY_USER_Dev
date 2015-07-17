//
//  MDViewController.m
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDViewController.h"

#import "MDTabButton.h"

@interface MDViewController ()

@end

@implementation MDViewController
{
    
    MDDeliveryViewController              *_deliveryViewController;
    MDRequestViewController               *_requestViewController;
    MDSettingViewController               *_settingViewController;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init view controller
    _deliveryViewController   =   [[MDDeliveryViewController    alloc]init];
    _requestViewController    =   [[MDRequestViewController     alloc]init];
    _settingViewController    =   [[MDSettingViewController     alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logoutDone {
    if([self.delegate respondsToSelector:@selector(closeAllView)]){
        [self.delegate closeAllView];
    }
}


@end
