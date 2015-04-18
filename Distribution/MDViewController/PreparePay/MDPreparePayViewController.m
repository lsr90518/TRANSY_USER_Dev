//
//  MDPreparePayViewController.m
//  Distribution
//
//  Created by Lsr on 3/31/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDPreparePayViewController.h"
#import "MDDeliveryViewController.h"

@interface MDPreparePayViewController ()

@end

@implementation MDPreparePayViewController

-(void)loadView {
    [super loadView];
    
    _preparePayView = [[MDPreparePayView alloc]initWithFrame:self.view.frame];
    _preparePayView.delegate = self;
    [self.view addSubview:_preparePayView];
    
    //test よう
    [MDCurrentPackage getInstance].package_number = @"1234567890";
    [_preparePayView initPackageNumber:[MDCurrentPackage getInstance].package_number];
    
    
    ///packages/user/upload_image
    
    //add right button item
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_preparePayView.backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.title = @"準備と支払い方法";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma PreparePayView
-(void)backButtonPushed {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
