//
//  MDSettingViewController.m
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDSettingViewController.h"
#import "MDPhoneNumberSettingViewController.h"
#import "MDNameSettingViewController.h"
#import "MDPhoneViewController.h"
#import "MDRequestViewController.h"
#import "MDDeliveryViewController.h"
#import "MDPaymentViewController.h"

@interface MDSettingViewController ()

@end

@implementation MDSettingViewController

-(void)loadView{
    [super loadView];
    self.navigationItem.title = @"設定";
    self.navigationController.delegate = self;
    _settingView = [[MDSettingView alloc]initWithFrame:self.view.frame];
    _settingView.delegate = self;
    [self.view addSubview:_settingView];
}

-(void) viewWillAppear:(BOOL)animated{
    [_settingView setViewData:[MDUser getInstance]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma delegate methods
-(void) phoneNumberPushed {
    MDPhoneViewController *phoneNumberSettingViewController = [[MDPhoneViewController alloc]init];
    [self.navigationController pushViewController:phoneNumberSettingViewController animated:YES];
}

-(void) nameButtonPushed {
    MDNameSettingViewController *nameSettingViewController = [[MDNameSettingViewController alloc]init];
    [self.navigationController pushViewController:nameSettingViewController animated:YES];
}

-(void) paymentButtonPushed {
    //    NSLog(@"paymentButtonPushed");
    MDPaymentViewController *paymentViewController = [[MDPaymentViewController alloc] init];
    [self.navigationController pushViewController:paymentViewController animated:YES];
}
-(void) showCardIO {
    MDPaymentViewController *paymentViewController = [[MDPaymentViewController alloc] initWithCardIO];
    [self.navigationController pushViewController:paymentViewController animated:YES];
}
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{
    // NSLog(@"navigationController delegate called!");
    MDSelect *pay = (MDSelect *)[_settingView.scrollView viewWithTag:paymentSelect];
    if(pay){
        pay.selectLabel.text = [MDUtil getPaymentSelectLabel];
    }
}

-(void) gotoDeliveryView {
    MDDeliveryViewController *rvc = [[MDDeliveryViewController alloc]init];
    UINavigationController *rvcNavigationController = [[UINavigationController alloc]initWithRootViewController:rvc];
    [self presentViewController:rvcNavigationController animated:NO completion:nil];
}
-(void) gotoRequestView {
    MDRequestViewController *rvc = [[MDRequestViewController alloc]init];
    UINavigationController *rvcNavigationController = [[UINavigationController alloc]initWithRootViewController:rvc];
    [self presentViewController:rvcNavigationController animated:NO completion:nil];
}

@end
