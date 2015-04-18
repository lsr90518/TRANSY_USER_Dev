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

@interface MDLoginViewController ()

@end

@implementation MDLoginViewController


-(void)loadView {
    [super loadView];
    _loginView = [[MDLoginView alloc]initWithFrame:self.view.frame];
    _loginView.delegate = self;
    [self.view addSubview:_loginView];
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
                                        
                                        MDViewController *viewController = [[MDViewController alloc]init];
                                        [self presentViewController:viewController animated:YES completion:nil];
                                    } else if([[completeOperation responseJSON][@"code"] integerValue] == 2){
                                        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"不正番号"
                                                                                                       message:@"この番号もう登録した"
                                                                                                preferredStyle:UIAlertControllerStyleAlert];
                                        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                                              handler:^(UIAlertAction * action) {}];
                                        [alert addAction:defaultAction];
                                        [self presentViewController:alert animated:YES completion:nil];
                                    }
                                    
                                } onError:^(MKNetworkOperation *completeOperarion, NSError *error){
                                    NSLog(@"error --------------  %@", error);
                                    [SVProgressHUD dismiss];
                                }];
    
}

@end
