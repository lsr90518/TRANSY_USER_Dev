//
//  MDPhoneNumberSettingViewController.m
//  Distribution
//
//  Created by Lsr on 4/18/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDPhoneNumberSettingViewController.h"
#import "MDPhoneViewController.h"
#import "MDInput.h"
#import "MDUser.h"
#import "MDAPI.h"
#import <SVProgressHUD.h>

@interface MDPhoneNumberSettingViewController () {
    UIButton *postButton;
}

@end

@implementation MDPhoneNumberSettingViewController

-(void) loadView {
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _phoneInput = [[MDInput alloc]initWithFrame:CGRectMake(10, 74, self.view.frame.size.width-20, 50)];
    _phoneInput.title.text = @"電話番号";
    _phoneInput.input.text = [MDUser getInstance].phoneNumber;
    [_phoneInput setUserInteractionEnabled:YES];
    [_phoneInput.input setKeyboardType:UIKeyboardTypeNumberPad];
    [_phoneInput.title sizeToFit];
    [self.view addSubview:_phoneInput];
    
    postButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 134, self.view.frame.size.width-20, 50)];
    [postButton setBackgroundColor:[UIColor colorWithRed:226.0/255.0 green:138.0/255.0 blue:0 alpha:1]];
    [postButton setTitle:@"電話番号の変更" forState:UIControlStateNormal];
    postButton.layer.cornerRadius = 2.5;
    [postButton addTarget:self action:@selector(changePhoneNumber) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postButton];
    
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
    self.navigationItem.title = @"携帯番号";
    //add right button item
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    
}

-(void) changePhoneNumber {
    //call api
//    [SVProgressHUD showWithStatus:@"保存" maskType:SVProgressHUDMaskTypeBlack];
//    [[MDAPI sharedAPI] updatePhoneNumberWithOldPhoneNumber:[MDUtil internationalPhoneNumber:[MDUser getInstance].phoneNumber]
//                                            newPhoneNumber:[MDUtil internationalPhoneNumber:_phoneInput.input.text]
//                                                OnComplete:^(MKNetworkOperation *completeOperation) {
//                                                
//                                                [SVProgressHUD dismiss];
//                                                if( [[completeOperation responseJSON][@"code"] integerValue] == 0){
//                                                    
//                                                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//                                                } else if([[completeOperation responseJSON][@"code"] integerValue] == -99){
//                                                    [MDUtil makeAlertWithTitle:@"連続送信禁止" message:@"悪用防止のため連続での送信はお控えください。しばらくお待ちいただいてから再度お試しください。" done:@"OK" viewController:self];
//                                                } else if ([[completeOperation responseJSON][@"code"] integerValue] == 3){
//                                                    [MDUtil makeAlertWithTitle:@"変更できません" message:@"電話番号と確認コードの対応が不正です。" done:@"OK" viewController:self];
//                                                } else if ([[completeOperation responseJSON][@"code"] integerValue] == 2){
//                                                    [MDUtil makeAlertWithTitle:@"変更できません" message:@"既に指定した電話番号が使われています。" done:@"OK" viewController:self];
//                                                }
//                                                [SVProgressHUD dismiss];
//                                            }onError:^(MKNetworkOperation *completeOperarion, NSError *error){
//                                                NSLog(@"%@", error);
//                                                [SVProgressHUD dismiss];
//                                                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"番号変更"
//                                                                                                message:@"この番号は変更できません。"
//                                                                                               delegate:self
//                                                                                      cancelButtonTitle:nil
//                                                                                      otherButtonTitles:@"OK", nil];
//                                                alert.delegate = self;
//                                                [alert show];
//
//                                            }];
    
    MDPhoneViewController *pvc = [[MDPhoneViewController alloc]init];
    [self.navigationController pushViewController:pvc animated:YES];
}

-(void) backButtonTouched {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
