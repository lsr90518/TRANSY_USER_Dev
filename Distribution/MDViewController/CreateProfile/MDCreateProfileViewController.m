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
#import <SVProgressHUD.h>

@interface MDCreateProfileViewController ()

@end

@implementation MDCreateProfileViewController

-(void) loadView {
    [super loadView];
    
    _createProfileView = [[MDCreateProfileView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_createProfileView];
    _createProfileView.delegate = self;
    [_createProfileView.creditButton addTarget:self action:@selector(showCreditView) forControlEvents:UIControlEventTouchUpInside];
    
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
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) postData:(MDCreateProfileView *)createProfileView {
    if (![createProfileView.passwordInput.input.text isEqualToString:[NSString stringWithFormat:@"%@",createProfileView.repeatInput.input.text]]) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"パスワード"
                                                        message:@"パスワードをもう一回確認してください。"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        alert.delegate = self;
        [alert show];
    } else {
        MDUser *user = [MDUser getInstance];
        user.lastname = createProfileView.lastnameInput.input.text;
        user.firstname = createProfileView.givennameInput.input.text;
        user.password = createProfileView.passwordInput.input.text;
        //call api
        [SVProgressHUD show];
        [[MDAPI sharedAPI] newProfileByUser:user
                                    onComplete:^(MKNetworkOperation *completeOperation) {
                                        user.userHash = [completeOperation responseJSON][@"hash"];
                                        MDViewController *viewcontroller = [[MDViewController alloc]init];
                                        [self presentViewController:viewcontroller animated:YES completion:nil];
                                    } onError:^(MKNetworkOperation *completeOperarion, NSError *error){
                                        NSLog(@"error --------------  %@", error);
                                        
                                    }];
        
//        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
}

-(void) scrollDidMove:(MDCreateProfileView *)createProfileView {
    [createProfileView.passwordInput.input resignFirstResponder];
    [createProfileView.repeatInput.input resignFirstResponder];
    [createProfileView.lastnameInput.input resignFirstResponder];
    [createProfileView.givennameInput.input resignFirstResponder];
}

-(void) showCreditView {
    NSLog(@"credit view");
}

@end
