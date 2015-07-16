//
//  MDSignUpNavigationController.m
//  Distribution
//
//  Created by 各務 将士 on 2015/07/16.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import "MDSignUpNavigationController.h"

@interface MDSignUpNavigationController ()

@end

@implementation MDSignUpNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MDPhoneViewController *phoneViewController = [[MDPhoneViewController alloc]init];
    [self setViewControllers:[NSArray arrayWithObject:phoneViewController]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
