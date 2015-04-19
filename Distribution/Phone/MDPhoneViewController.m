//
//  MDPhoneViewController.m
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDPhoneViewController.h"
#import "MDUser.h"
#import <SVProgressHUD.h>

@interface MDPhoneViewController ()

@end

@implementation MDPhoneViewController

- (void)loadView {
    [super loadView];
    
    //navigation bar
    [self initNavigationBar];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _inputView = [[MDInput alloc]initWithFrame:CGRectMake(10, 74, self.view.frame.size.width-20, 50)];
    _inputView.title.text = @"携帯番号";
    [_inputView.title sizeToFit];
    [self.view addSubview:_inputView];
    
    //well
    MDWell *well = [[MDWell alloc]initWithFrame:CGRectMake(10, 122, self.view.frame.size.width-20, 82)];
    [self.view addSubview:well];
    
    
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
    self.navigationItem.title = @"携帯番号確認";
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
    [_backButton addTarget:self action:@selector(backButtonPushed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}

-(void) postButtonTouched {
    // "-" 判断
    NSRange range = [_inputView.input.text rangeOfString:@"-"];
    if(range.length > 0) {
        
        //不正番号
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"不正番号"
                                                                       message:@"ハイフン「-」を入力しないでください"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else if( _inputView.input.text.length != 11) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"不正番号"
                                                                       message:@"11桁の携帯番号を入力してください"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        
        //有効な電話番号
        NSString *phoneNumber = [NSString stringWithFormat:@"+81%@",[_inputView.input.text substringFromIndex:1]];
        
        //test
        if([phoneNumber isEqualToString:@"+819028280392"]){
            MDUser *user = [MDUser getInstance];
            user.phoneNumber = phoneNumber;
            MDCheckNumberViewController *checkNumberController = [[MDCheckNumberViewController alloc]init];
            [self.navigationController pushViewController:checkNumberController animated:YES];
        } else {
        
            [SVProgressHUD show];
            [[MDAPI sharedAPI] createUserWithPhone:phoneNumber
                          onComplete:^(MKNetworkOperation *completeOperation) {
                              NSLog(@"%ld",(long)[[completeOperation responseJSON][@"code"] integerValue]);
                              [SVProgressHUD dismiss];
                              if([[completeOperation responseJSON][@"code"] integerValue] == 0){
                                  MDUser *user = [MDUser getInstance];
                                  user.phoneNumber = phoneNumber;
                                  MDCheckNumberViewController *checkNumberController = [[MDCheckNumberViewController alloc]init];
                                  [self.navigationController pushViewController:checkNumberController animated:YES];
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
    }
}

-(void)backButtonPushed {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
