//
//  MDNameSettingViewController.m
//  Distribution
//
//  Created by Lsr on 4/18/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDNameSettingViewController.h"
#import "MDDevice.h"
#import <SVProgressHUD.h>

@interface MDNameSettingViewController ()

@end

@implementation MDNameSettingViewController

-(void) loadView {
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _lastnameInput = [[MDInput alloc]initWithFrame:CGRectMake(10, 74, self.view.frame.size.width-20, 50)];
    _lastnameInput.title.text = @"姓";
    [_lastnameInput.title sizeToFit];
    _lastnameInput.input.text = [MDUser getInstance].lastname;
    [self.view addSubview:_lastnameInput];
    
    _firstnameInput = [[MDInput alloc]initWithFrame:CGRectMake(10, 123, self.view.frame.size.width-20, 50)];
    [_firstnameInput setBackgroundColor:[UIColor whiteColor]];
    _firstnameInput.title.text = @"名";
    [_firstnameInput.title sizeToFit];
    _firstnameInput.input.text = [MDUser getInstance].firstname;
    [self.view addSubview:_firstnameInput];
    
    _postButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 183, self.view.frame.size.width-20, 50)];
    [_postButton setBackgroundColor:[UIColor colorWithRed:226.0/255.0 green:138.0/255.0 blue:0 alpha:1]];
    [_postButton setTitle:@"名前の変更" forState:UIControlStateNormal];
    _postButton.layer.cornerRadius = 2.5;
    [_postButton addTarget:self action:@selector(postNameChange) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: _postButton];
    
    [self initNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavigationBar {
    self.navigationItem.title = @"名前を設定";
    //add right button item
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonPushed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}

-(void) backButtonPushed{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) postNameChange{
    [SVProgressHUD showWithStatus:@"保存" maskType:SVProgressHUDMaskTypeBlack];
    MDUser *newUser = [[MDUser alloc]init];
    [newUser copyDataFromUser:[MDUser getInstance]];
    newUser.lastname = _lastnameInput.input.text;
    newUser.firstname = _firstnameInput.input.text;
    [[MDAPI sharedAPI] updateProfileByUser:newUser
                              sendPassword:NO
                                onComplete:^(MKNetworkOperation *completeOperarion) {
                                    [SVProgressHUD dismiss];
                                    [MDUser getInstance].lastname = _lastnameInput.input.text;
                                    [MDUser getInstance].firstname = _firstnameInput.input.text;
                                    [self backButtonPushed];
                                } onError:^(MKNetworkOperation *completeOperarion, NSError *error) {
                                    // NSLog(@"error --------------  %@", error);
                                    [MDUtil makeAlertWithTitle:@"通信エラー" message:@"通信中にエラーが発生しました。通信環境をご確認の上、再度お試しください。" done:@"OK" viewController:self];
                                    [SVProgressHUD dismiss];
                                }];

}


@end
