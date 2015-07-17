//
//  MDCreateProfileViewController.m
//  Distribution
//
//  Created by Lsr on 4/12/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDCreateProfileViewController.h"
#import "MDUser.h"
#import "MDViewController.h"
#import "MDAPI.h"
#import "MDPaymentViewController.h"
#import <SVProgressHUD.h>

@interface MDCreateProfileViewController ()

@end

@implementation MDCreateProfileViewController

-(void) loadView {
    [super loadView];
    
    self.navigationController.delegate = self;
    
    _createProfileView = [[MDCreateProfileView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_createProfileView];
    _createProfileView.delegate = self;
    
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


-(void) initNavigationBar {
    self.navigationItem.title = @"ユーザー登録";
    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}

-(void) backButtonTouched {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) postData:(MDCreateProfileView *)createProfileView {
    
    if(![createProfileView isChecked]){
        [MDUtil makeAlertWithTitle:@"利用規約" message:@"利用規約を同意してください。" done:@"OK" viewController:self];
    } else if([createProfileView.lastnameInput.input.text length] == 0
       || [createProfileView.givennameInput.input.text length] == 0) {
        [MDUtil makeAlertWithTitle:@"名前" message:@"名前を入力してください。" done:@"OK" viewController:self];
    } else if (![createProfileView.passwordInput.input.text isEqualToString:[NSString stringWithFormat:@"%@",createProfileView.repeatInput.input.text]]) {
        [MDUtil makeAlertWithTitle:@"パスワード" message:@"パスワードをもう一度確認してください。" done:@"OK" viewController:self];
    } else if([createProfileView.passwordInput.input.text length] < 6) {
        [MDUtil makeAlertWithTitle:@"パスワード" message:@"パスワードは6文字以上で設定してください。" done:@"OK" viewController:self];
    } else {
        MDUser *user = [MDUser getInstance];
        user.lastname = createProfileView.lastnameInput.input.text;
        user.firstname = createProfileView.givennameInput.input.text;
        user.password = createProfileView.passwordInput.input.text;
        //call api
        [SVProgressHUD showWithStatus:@"登録中" maskType:SVProgressHUDMaskTypeBlack];
        [[MDAPI sharedAPI] newProfileByUser:user
                                    onComplete:^(MKNetworkOperation *completeOperation) {
                                        // NSLog(@"%@",[completeOperation responseJSON]);
                                        [SVProgressHUD dismiss];
                                        if([[completeOperation responseJSON][@"code"] intValue] == 0){
                                            user.userHash = [completeOperation responseJSON][@"hash"];
                                            [user setLogin];
                                            MDSignUpNavigationController *signNav = (MDSignUpNavigationController *)self.navigationController;
                                            if([signNav.sign_delegate respondsToSelector:@selector(goToMainView:)]){
                                                [signNav.sign_delegate goToMainView:self];
                                            }
                                        }else{
                                            [MDUtil makeAlertWithTitle:@"エラー" message:@"エラーが発生しました。最初からやり直してください。" done:@"OK" viewController:self];
                                        }
                                    } onError:^(MKNetworkOperation *completeOperarion, NSError *error){
                                        NSLog(@"error --------------  %@", error);
                                    }];
    }
    
}

-(void) scrollDidMove:(MDCreateProfileView *)createProfileView {
    [createProfileView.passwordInput.input resignFirstResponder];
    [createProfileView.repeatInput.input resignFirstResponder];
    [createProfileView.lastnameInput.input resignFirstResponder];
    [createProfileView.givennameInput.input resignFirstResponder];
}

-(void) showCreditView {
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
    MDSelect *pay = _createProfileView.creditButton;
    if(pay){
        // NSLog(@"pay changed!");
        [pay.selectLabel setText:[MDUtil getPaymentSelectLabel]];
        [pay.selectLabel setAlpha:[MDUtil getPaymentSelectLabelAlpha]];
        [pay setBackgroundColor:[MDUtil getPaymentButtonBackground]];
    }
}

@end
