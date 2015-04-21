//
//  MDIndexViewController.m
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDIndexViewController.h"
#import "MDViewController.h"

@interface MDIndexViewController ()

@end

@implementation MDIndexViewController

- (void) loadView {
    [super loadView];
    
    _indexView = [[MDIndexView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _indexView.delegate = self;
    [self.view addSubview:_indexView];
    //判断登陆，注册，直接使用
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma indexDelegate
-(void)signTouched {
    MDPhoneViewController *phoneViewController = [[MDPhoneViewController alloc]init];
    UINavigationController *signNavigationController = [[UINavigationController alloc]initWithRootViewController:phoneViewController];
    [self presentViewController:signNavigationController animated:YES completion:nil];
}

-(void)loginTouched {
    MDLoginViewController *loginViewController = [[MDLoginViewController alloc]init];
    UINavigationController *loginNavigationController = [[UINavigationController alloc]initWithRootViewController:loginViewController];
    [self presentViewController:loginNavigationController animated:YES completion:nil];
}




@end
