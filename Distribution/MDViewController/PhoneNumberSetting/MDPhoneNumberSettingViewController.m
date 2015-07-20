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
    NSRange range = [_phoneInput.input.text rangeOfString:@"-"];
    if(range.length > 0) {
        [MDUtil makeAlertWithTitle:@"不正な番号" message:@"ハイフン「-」の除いた電話番号を入力してください。" done:@"OK" viewController:self];
    } else if( _phoneInput.input.text.length != 11) {
        [MDUtil makeAlertWithTitle:@"不正な番号" message:@"11桁の携帯番号を入力してください。" done:@"OK" viewController:self];
    } else {
        [SVProgressHUD show];
        [[MDAPI sharedAPI] updatePhoneNumberWithOldPhoneNumber:[MDUtil internationalPhoneNumber:[MDUser getInstance].phoneNumber]
                                                newPhoneNumber:[MDUtil internationalPhoneNumber:_phoneInput.input.text]
                                                    OnComplete:^(MKNetworkOperation *completeOperation) {
                                                    
                                                    [SVProgressHUD dismiss];
                                                    if( [[completeOperation responseJSON][@"code"] integerValue] == 0){
                                                        [MDUser getInstance].tmp_phoneNumber = _phoneInput.input.text;
                                                        MDCheckNumberViewController *checkVC = [[MDCheckNumberViewController alloc] init];
                                                        [self.navigationController pushViewController:checkVC animated:YES];
                                                    } else if([[completeOperation responseJSON][@"code"] integerValue] == -99){
                                                        [MDUtil makeAlertWithTitle:@"連続送信禁止" message:@"悪用防止のため連続での送信はお控えください。しばらくお待ちいただいてから再度お試しください。" done:@"OK" viewController:self];
                                                    } else if ([[completeOperation responseJSON][@"code"] integerValue] == 2){
                                                        [MDUtil makeAlertWithTitle:@"変更できません" message:@"既に指定した電話番号が使われています。" done:@"OK" viewController:self];
                                                    }
                                                    [SVProgressHUD dismiss];
                                                }onError:^(MKNetworkOperation *completeOperarion, NSError *error){
                                                    // NSLog(@"%@", error);
                                                    [SVProgressHUD dismiss];
                                                    [MDUtil makeAlertWithTitle:@"通信エラー" message:@"通信中にエラーが発生しました。通信環境をご確認の上、再度お試しください。" done:@"OK" viewController:self];
                                                }];
    }
}

-(void) backButtonTouched {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
