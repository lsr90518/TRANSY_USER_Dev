//
//  MDPaymentViewController.m
//  Distribution
//
//  Created by 各務 将士 on 2015/04/23.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import "MDPaymentViewController.h"
#import "MDAPI.h"
#import "MDUser.h"

@implementation MDPaymentViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    
    // デリゲートを指定
    super.webView.delegate = self;
    
    MDUser *user = [MDUser getInstance];
    [user initDataClear];
    // 検証用クレジットカード番号
    // 9191753589464621
    // 有効期限(12/16)
    // 名義は任意の文字列
    [self openWebpageWithUrl:@"https://secure.telecomcredit.co.jp/inetcredit/adult/order.pl"
                      method:@"POST"
                   parameter:[NSDictionary dictionaryWithObjectsAndKeys:
                              @"00044",@"clientip",
                              [NSString stringWithFormat: @"u%ld", (long)user.user_id],@"sendid",
                              @"1500",@"money",
                              user.phoneNumber,@"usrtel",
                              user.mailAddress,@"usrmail",
                              [NSString stringWithFormat:@"http://%@/credit/auth_back.html",API_HOST_NAME],@"redirect_url",
                              nil]];
}

-(void)initNavigationBar {
    self.navigationItem.title = @"クレジットカードの登録";
    //add left button item
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonPushed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}

/**
 ** webViewがリクエスト送った時のDelegate
 **/
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
navigationType:(UIWebViewNavigationType)navigationType
{
    // NSLog([NSString stringWithFormat:@"request sent. scheme: %@, host: %@", request.URL.scheme, request.URL.host]);
    // schemeがnative だった場合
    if ([ request.URL.scheme isEqualToString:@"auth" ]) {
        [ self paymentAuthComplete: request ];
        // WebViewの読み込みは中断する。
        return NO;
    }
    // 通常のschemeの場合は、フックせずそのまま処理を続ける
    else {
        return YES;
    }
}

#pragma PaymentView
-(void)backButtonPushed {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)paymentAuthComplete:(NSURLRequest *)request {
    MDUser *user = [MDUser getInstance];
    [user initDataClear];
    if ([request.URL.host isEqualToString:@"done"]) {
        // credit info of user updated here
        user.credit = 1;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
