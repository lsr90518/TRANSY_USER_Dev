//
//  MDLoginViewController.m
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDLoginViewController.h"
#import "MDViewController.h"
#import "MDAPI.h"
#import <SVProgressHUD.h>
#import "MDUtil.h"
#import "MDDeliveryViewController.h"

@interface MDLoginViewController ()

@end

@implementation MDLoginViewController


-(void)loadView {
    [super loadView];
    _loginView = [[MDLoginView alloc]initWithFrame:self.view.frame];
    _loginView.delegate = self;
    [self.view addSubview:_loginView];
    
    [self initNavigationBar];
}

-(void)initNavigationBar {
    self.navigationItem.title = @"ログイン";
    //add right button item
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)postData:(MDLoginView *)loginView {
    
    MDUtil *util = [[MDUtil alloc]init];
    NSString *phoneNumber = [util internationalPhoneNumber:loginView.phoneInput.input.text];
    NSString *password = loginView.passwordInput.input.text;
    
    [SVProgressHUD show];
    [[MDAPI sharedAPI] loginWithPhone:phoneNumber
                             password:password
                                onComplete:^(MKNetworkOperation *completeOperation) {
                                    [SVProgressHUD dismiss];
                                    if([[completeOperation responseJSON][@"code"] integerValue] == 0){
                                        MDUser *user = [MDUser getInstance];
                                        user.phoneNumber = [util japanesePhoneNumber:phoneNumber];
                                        user.password = password;
                                        user.userHash = [completeOperation responseJSON][@"hash"];
                                        NSString *username = [completeOperation responseJSON][@"data"][@"name"];
                                        NSArray *nameArray = [username componentsSeparatedByString:@" "];
                                        user.lastname = nameArray[0];
                                        user.firstname = nameArray[1];
                                        
//                                        MDViewController *viewController = [[MDViewController alloc]init];
//                                        [self presentViewController:viewController animated:YES completion:nil];
                                        
                                        MDDeliveryViewController *deliveryViewController = [[MDDeliveryViewController alloc]init];
                                        UINavigationController *deliveryNavigationController = [[UINavigationController alloc]initWithRootViewController:deliveryViewController];
                                        [self presentViewController:deliveryNavigationController animated:YES completion:nil];
                                        
                                    } else if([[completeOperation responseJSON][@"code"] integerValue] == 2){
                                        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"不正番号"
                                                                                        message:@"パスワードは正しくありません。"
                                                                                        delegate:self
                                                                                        cancelButtonTitle:nil
                                                                                        otherButtonTitles:@"OK", nil];
                                        alert.delegate = self;
                                        [alert show];
                                    }
                                    
                                } onError:^(MKNetworkOperation *completeOperarion, NSError *error){
                                    NSLog(@"error --------------  %@", error);
                                    [SVProgressHUD dismiss];
                                }];
    
}
-(void) backButtonTouched {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
