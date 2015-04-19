//
//  MDCheckNumberViewController.m
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDCheckNumberViewController.h"
#import "MDAPI.h"
#import <SVProgressHUD.h>
#import "MDCreateProfileViewController.h"
#import "MDUser.h"
#import "MDPhoneNumberSettingViewController.h"

@interface MDCheckNumberViewController ()

@end

@implementation MDCheckNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //navigation bar
    [self initNavigationBar];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _inputView = [[MDInput alloc]initWithFrame:CGRectMake(10, 74, self.view.frame.size.width-20, 50)];
    _inputView.title.text = @"認証番号";
    [_inputView.title sizeToFit];
    _inputView.input.placeholder = @"5桁の番号";
    [self.view addSubview:_inputView];
    
    //well
    MDWell *well = [[MDWell alloc]initWithFrame:CGRectMake(10, 122, self.view.frame.size.width-20, 62)];
    [well setContentText:@"SMSに送られてきた、5桁の認証番号を記入してください。"];
    [self.view addSubview:well];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavigationBar {
    self.navigationItem.title = @"認証番号確認";
    //add right button item
    UIButton *_postButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_postButton setTitle:@"次へ" forState:UIControlStateNormal];
    _postButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _postButton.frame = CGRectMake(0, 0, 25, 44);
    [_postButton addTarget:self action:@selector(postButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:_postButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}

-(void) postButtonTouched {
    [SVProgressHUD show];
    [[MDAPI sharedAPI] checkUserWithPhone:[MDUser getInstance].phoneNumber
                                 withCode:_inputView.input.text
                               onComplete:^(MKNetworkOperation *completeOperation) {
                                   [SVProgressHUD dismiss];
                                   NSLog(@"%@",[completeOperation responseJSON]);
                                   if([[completeOperation responseJSON][@"code"] integerValue] == 0) {
                                       MDUser *user = [MDUser getInstance];
                                       user.checknumber = _inputView.input.text;
                                       [self checkHash];
                                   }
                               }
                                  onError:^(MKNetworkOperation *completeOperartion, NSError *error){
                                      NSLog(@"%@", error);
                                      
                                      [SVProgressHUD dismiss];
                                  }];
    
}

-(void) backButtonTouched {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) checkHash {
    if([MDUser getInstance].userHash.length > 0) {
        //番号変更
        MDPhoneNumberSettingViewController *phoneNumberSettingViewController = [[MDPhoneNumberSettingViewController alloc]init];
        [self.navigationController pushViewController:phoneNumberSettingViewController animated:YES];
    } else {
        //新規
        MDCreateProfileViewController *cpv = [[MDCreateProfileViewController alloc]init];
        [self.navigationController pushViewController:cpv animated:YES];
    }
}

@end
