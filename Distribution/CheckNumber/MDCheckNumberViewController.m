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
    [_inputView.input setKeyboardType:UIKeyboardTypeNumberPad];
    [_inputView.title sizeToFit];
    _inputView.input.placeholder = @"5桁の番号";
    [self.view addSubview:_inputView];
    
    //well
    MDWell *well = [[MDWell alloc]initWithFrame:CGRectMake(10, 122, self.view.frame.size.width-20, 62)];
    [well setContentText:@"SMSに送られてきた、5桁の認証番号を記入してください。"];
    [self.view addSubview:well];
    
    _checkCount = 0;
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
//    MDCreateProfileViewController *cpv = [[MDCreateProfileViewController alloc]init];
//    [self.navigationController pushViewController:cpv animated:YES];
    
    _checkCount++;
    if(_checkCount > 5){
        [MDUtil makeAlertWithTitle:@"不正な操作" message:@"連続して間違った番号が入力されました。始めからやり直してください。" done:@"OK" viewController:self];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    [SVProgressHUD showWithStatus:@"認証中" maskType:SVProgressHUDMaskTypeBlack];
    if([[MDUser getInstance] isLogin]){
        [[MDAPI sharedAPI] changePhoneNumberWithCode:_inputView.input.text
                                          onComplete:^(MKNetworkOperation *completeOperation) {
                                              [SVProgressHUD dismiss];
                                              if([[completeOperation responseJSON][@"code"] integerValue] == 0) {
                                                  [self checkHash];
                                              }else if([[completeOperation responseJSON][@"code"] integerValue] == 3) {
                                                  [MDUtil makeAlertWithTitle:@"エラー" message:@"認証番号が異なります。" done:@"OK" viewController:self];
                                              }else{
                                                  [MDUtil makeAlertWithTitle:@"エラー" message:@"この電話番号は使用できません。" done:@"OK" viewController:self];
                                                  [self.navigationController popViewControllerAnimated:YES];
                                              }

                                          } onError:^(MKNetworkOperation *completeOperation, NSError *error) {
                                              // NSLog(@"%@", error);
                                              [MDUtil makeAlertWithTitle:@"通信エラー" message:@"通信中にエラーが発生しました。通信環境をご確認の上、再度お試しください。" done:@"OK" viewController:self];
                                              [SVProgressHUD dismiss];
                                          }];
    }else{
        [[MDAPI sharedAPI] checkUserWithPhone:[MDUtil internationalPhoneNumber:[MDUser getInstance].phoneNumber]
                                 withCode:_inputView.input.text
                               onComplete:^(MKNetworkOperation *completeOperation) {
                                   [SVProgressHUD dismiss];
                                   if([[completeOperation responseJSON][@"code"] integerValue] == 0) {
                                       if([[completeOperation responseJSON][@"check"] integerValue] == 1){
                                           MDUser *user = [MDUser getInstance];
                                           user.checknumber = _inputView.input.text;
                                           [self checkHash];
                                       }else{
                                           [MDUtil makeAlertWithTitle:@"エラー" message:@"認証番号が異なります。" done:@"OK" viewController:self];
                                       }
                                   }
                               }
                                  onError:^(MKNetworkOperation *completeOperartion, NSError *error){
                                      // NSLog(@"%@", error);
                                      [MDUtil makeAlertWithTitle:@"通信エラー" message:@"通信中にエラーが発生しました。通信環境をご確認の上、再度お試しください。" done:@"OK" viewController:self];
                                      [SVProgressHUD dismiss];
                                  }];
    }
}

-(void) backButtonTouched {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) checkHash {
    if([[MDUser getInstance] isLogin]) {
        //番号変更
        MDUser *user = [MDUser getInstance];
        user.phoneNumber = user.tmp_phoneNumber;
        user.tmp_phoneNumber = @"";
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        //新規
        MDCreateProfileViewController *cpv = [[MDCreateProfileViewController alloc]init];
        [self.navigationController pushViewController:cpv animated:YES];
    }
}

@end
