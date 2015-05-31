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
#import "MDCustomerDAO.h"
#import "MDViewController.h"

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
    [_loginView setLoginData:[MDUser getInstance]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)postData:(MDLoginView *)loginView {
    
    
    if(loginView.phoneInput.input.text.length > 3 && loginView.passwordInput.input.text > 0){
        
        NSString *phoneNumber = [MDUtil internationalPhoneNumber:loginView.phoneInput.input.text];
        NSString *password = loginView.passwordInput.input.text;
        
        [SVProgressHUD show];
        [[MDAPI sharedAPI] loginWithPhone:phoneNumber
                                 password:password
                               onComplete:^(MKNetworkOperation *completeOperation) {
                                   [SVProgressHUD dismiss];
                                   if([[completeOperation responseJSON][@"code"] integerValue] == 0){
                                       
                                       [MDUser getInstance].user_id = [[completeOperation responseJSON][@"data"][@"id"] intValue];
                                       [MDUser getInstance].phoneNumber = [MDUtil japanesePhoneNumber:phoneNumber];
                                       [MDUser getInstance].mailAddress = [completeOperation responseJSON][@"data"][@"mail"];
                                       [MDUser getInstance].password = password;
                                       NSString *username = [completeOperation responseJSON][@"data"][@"name"];
                                       NSArray *nameArray = [username componentsSeparatedByString:@" "];
                                       [MDUser getInstance].lastname = nameArray[0];
                                       [MDUser getInstance].firstname = nameArray[1];
                                       [MDUser getInstance].credit =[[completeOperation responseJSON][@"data"][@"credit"] intValue];
                                       
                                       [[MDUser getInstance] setLogin];
                                       
                                       [MDUser getInstance].userHash = [completeOperation responseJSON][@"hash"];
                                       
                                       
                                       [self sendToken];
                                       
                                       [self saveUserToDB];
                                       
                                       [[MDUser getInstance] setLogin];
                                       
                                       //update api
                                       [[MDAPI sharedAPI] updateProfileByUser:[MDUser getInstance]
                                                                 sendPassword:NO
                                                                   onComplete:^(MKNetworkOperation *complete) {
                                                                       
                                                                       //
                                                                       [MDUser getInstance].userHash = [complete responseJSON][@"hash"];
                                                                       
                                                                       MDDeliveryViewController *deliveryViewController = [[MDDeliveryViewController alloc]init];
                                                                       UINavigationController *deliveryNavigationController = [[UINavigationController alloc]initWithRootViewController:deliveryViewController];
                                                                       [self presentViewController:deliveryNavigationController animated:YES completion:nil];
                                                                       
                                                                   } onError:^(MKNetworkOperation *operation, NSError *error) {
                                                                       //
                                                                   }];
                                       
                                       
                                       
                                       
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
    } else {
        [MDUtil makeAlertWithTitle:@"不正番号" message:@"入力した番号が正しくありません。" done:@"OK" viewController:self];
    }
    
}
-(void) backButtonTouched {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) sendToken{
    [[MDAPI sharedAPI] updateProfileByUser:[MDUser getInstance]
                              sendPassword:NO
                                onComplete:^(MKNetworkOperation *complete) {
                                    //
                                } onError:^(MKNetworkOperation *operation, NSError *error) {
                                    //
                                }];
}

-(void) saveUserToDB {
    [[NSFileManager defaultManager] removeItemAtPath:[RLMRealm defaultRealmPath] error:nil];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    MDConsignor *consignor = [[MDConsignor alloc]init];
    consignor.userid = [NSString stringWithFormat:@"%lu",(unsigned long)[MDUser getInstance].user_id];
    consignor.password = [MDUser getInstance].password;
    consignor.phonenumber = [MDUtil internationalPhoneNumber:[MDUser getInstance].phoneNumber];
    
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:consignor];
    [realm commitWriteTransaction];
}


@end
