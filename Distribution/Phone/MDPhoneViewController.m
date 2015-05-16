//
//  MDPhoneViewController.m
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDPhoneViewController.h"
#import "MDUser.h"
#import "MDDevice.h"
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
    [_inputView.input setKeyboardType:UIKeyboardTypeNumberPad];
    [_inputView.title sizeToFit];
    _inputView.input.placeholder = @"090XXXXXXXX";
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
    if(_inputView.input.text.length == 0){
        [MDUtil makeAlertWithTitle:@"未入力" message:@"電話番号を入力してください。" done:@"OK" viewController:self];
    }else{
        // "-" 判断
        NSRange range = [_inputView.input.text rangeOfString:@"-"];
        if(range.length > 0) {
            [MDUtil makeAlertWithTitle:@"不正な番号" message:@"ハイフン「-」の除いた電話番号を入力してください。" done:@"OK" viewController:self];
        } else if( _inputView.input.text.length != 11) {
            [MDUtil makeAlertWithTitle:@"不正な番号" message:@"11桁の携帯番号を入力してください。" done:@"OK" viewController:self];
        } else {
            //有効な電話番号
            NSString *phoneNumber = [MDUtil internationalPhoneNumber:_inputView.input.text];
            
            if([[MDUser getInstance] isLogin]){
                
                [SVProgressHUD showWithStatus:@"保存" maskType:SVProgressHUDMaskTypeBlack];
                [[MDAPI sharedAPI] updatePhoneNumberWithOldPhoneNumber:[MDUtil internationalPhoneNumber:[MDUser getInstance].phoneNumber]
                                                        newPhoneNumber:[MDUtil internationalPhoneNumber:phoneNumber]
                                                            OnComplete:^(MKNetworkOperation *completeOperation) {

                                                            [SVProgressHUD dismiss];
                                                            if( [[completeOperation responseJSON][@"code"] integerValue] == 0){

                                                                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                                                            } else if([[completeOperation responseJSON][@"code"] integerValue] == -99){
                                                                [MDUtil makeAlertWithTitle:@"連続送信禁止" message:@"悪用防止のため連続での送信はお控えください。しばらくお待ちいただいてから再度お試しください。" done:@"OK" viewController:self];
                                                            } else if ([[completeOperation responseJSON][@"code"] integerValue] == 3){
                                                                [MDUtil makeAlertWithTitle:@"変更できません" message:@"電話番号と確認コードの対応が不正です。" done:@"OK" viewController:self];
                                                            } else if ([[completeOperation responseJSON][@"code"] integerValue] == 2){
                                                                [MDUtil makeAlertWithTitle:@"変更できません" message:@"既に指定した電話番号が使われています。" done:@"OK" viewController:self];
                                                            }
                                                            [SVProgressHUD dismiss];
                                                        }onError:^(MKNetworkOperation *completeOperarion, NSError *error){
                                                            NSLog(@"%@", error);
                                                            [SVProgressHUD dismiss];
                                                            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"番号変更"
                                                                                                            message:@"この番号は変更できません。"
                                                                                                           delegate:self
                                                                                                  cancelButtonTitle:nil
                                                                                                  otherButtonTitles:@"OK", nil];
                                                            alert.delegate = self;
                                                            [alert show];

                                                        }];
                
            } else {
            
                [SVProgressHUD show];
                [[MDAPI sharedAPI] createUserWithPhone:phoneNumber
                              onComplete:^(MKNetworkOperation *completeOperation) {
                                  // NSLog(@"%ld",(long)[[completeOperation responseJSON][@"code"] integerValue]);
                                  [SVProgressHUD dismiss];
                                  if([[completeOperation responseJSON][@"code"] integerValue] == 0){
                                      MDUser *user = [MDUser getInstance];
                                      // NSLog(@"user_id: %d", [[completeOperation responseJSON][@"user_id"] intValue]);
                                      user.user_id = [[completeOperation responseJSON][@"user_id"] intValue];
                                      user.phoneNumber = [MDUtil japanesePhoneNumber: phoneNumber];
                                      MDCheckNumberViewController *checkNumberController = [[MDCheckNumberViewController alloc]init];
                                      [self.navigationController pushViewController:checkNumberController animated:YES];
                                  } else if([[completeOperation responseJSON][@"code"] integerValue] == 2){
                                      [MDUtil makeAlertWithTitle:@"既存の番号" message:@"この電話番号は既に登録されています。" done:@"OK" viewController:self];
                                  } else if([[completeOperation responseJSON][@"code"] integerValue] == -99){
                                      [MDUtil makeAlertWithTitle:@"連続送信禁止" message:@"悪用防止のため連続での送信はお控えください。しばらくお待ちいただいてから再度お試しください。" done:@"OK" viewController:self];
                                  }
                                  
                              } onError:^(MKNetworkOperation *completeOperarion, NSError *error){
                                     NSLog(@"error --------------  %@", error);
                                     [SVProgressHUD dismiss];
                                 }];
            }
        }
    }
}

-(void)backButtonPushed {
//    NSLog([NSString stringWithFormat:@"login status: %@",[[MDUser getInstance] loginStatus]]);
    if([[MDUser getInstance] isLogin]){
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
