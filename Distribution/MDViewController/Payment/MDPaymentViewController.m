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
- (MDPaymentViewController *)init{
    self = [super init];
    _withCardIO = NO;
    return self;
}
- (MDPaymentViewController *)initWithCardIO {
    self = [super init];
    _withCardIO = YES;
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [CardIOUtilities preload];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavigationBar];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    // デリゲートを指定
    self.webView.delegate = self;
    
    if(!_withCardIO){
        [self openPaymentView];
    }else{
        if([CardIOUtilities canReadCardWithCamera]){
            [self scanCard:nil];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
            [MDUtil makeAlertWithTitle:@"エラー" message:@"お使いの端末ではスキャンを使用できません" done:@"OK" viewController:self];
        }
    }
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
    // schemeがauth だった場合
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
/**
 ** webView読み込み完了時のDelegate
 **/
- (void)webViewDidFinishLoad:(UIWebView*)webView
{
    [super webViewDidFinishLoad:webView];
    if(_cardInfo)[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"cardNumberAutoComplete(%@,%lu,%lu);",_cardInfo.cardNumber,(unsigned long)_cardInfo.expiryMonth,(unsigned long)_cardInfo.expiryYear]];
}

#pragma PaymentView
- (IBAction)scanCard:(id)sender {
    CGRect rect = self.view.frame;
    rect.size.height -= (self.navigationController.navigationBar.bounds.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height);
    _cardIOView = [[CardIOView alloc] initWithFrame:rect];
    _cardIOView.delegate = self;
    [_cardIOView setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:_cardIOView];
}
-(void)openPaymentView {
    MDUser *user = [MDUser getInstance];
    [user initDataClear];
    // 検証用クレジットカード番号
    // 9191-7535-8946-4621
    // 有効期限(12/16)
    // 名義は任意の文字列
    // for debug page: @"https://modelor.com/TRANSY/credit_test"
    [self openWebpageWithUrl:@"https://secure.telecomcredit.co.jp/inetcredit/adult/order.pl"
                      method:@"POST"
                   parameter:[NSDictionary dictionaryWithObjectsAndKeys:
                              PAYMENT_IP,@"clientip",
                              [NSString stringWithFormat: @"u%ld", (long)user.user_id],@"sendid",
                              user.phoneNumber,@"usrtel",
                              user.mailAddress,@"usrmail",
                              [NSString stringWithFormat:@"http://%@/credit/auth_back.html",API_HOST_NAME],@"redirect_url",
                              nil]];
}
-(void)backButtonPushed {
    if(_cardIOView)[_cardIOView removeFromSuperview];
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

#pragma CardIODelegate
- (void)cardIOView:(CardIOView *)cardIOView didScanCard:(CardIOCreditCardInfo *)info {
    if (info) {
        // The full card number is available as info.cardNumber, but don't log that!
         NSLog(@"Received card info. Number: %@, expiry: %02lu/%lu, cvv: %@.", info.redactedCardNumber, (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear, info.cvv);
        // NSLog(@"%ld",info.cardType);
        // Use the card info...
//        [MDUtil makeAlertWithTitle:@"カード情報(Debug)"
//                           message:[NSString stringWithFormat:@"Number: %@\n expiry: %02lu/%lu",info.cardNumber,(unsigned long)info.expiryMonth, (unsigned long)info.expiryYear]
//                              done:@"OK"
//                    viewController:self];
        _cardInfo = info;
    }
    else {
        // NSLog(@"User cancelled payment info");
        [cardIOView removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    [cardIOView removeFromSuperview];
    [self openPaymentView];
}

@end
