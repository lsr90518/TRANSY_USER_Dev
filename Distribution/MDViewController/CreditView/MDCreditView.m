//
//  MDCreditViewController.m
//  Distribution
//
//  Created by 各務 将士 on 2015/05/13.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import "MDCreditView.h"
#import "MDAPI.h"
#import "MDUser.h"
#import <SVProgressHUD.h>

@implementation MDCreditView


-(MDCreditView *)init {
//    NSLog(@"init");
    self = [super init];
    self.delegate = self;
    self.layer.cornerRadius = 2.5f;
    self.clipsToBounds = YES;
    [self openCreditView];
    return self;
}
-(MDCreditView *)initWithFrame:(CGRect)rect {
//    NSLog(@"initWithFrame");
    self = [super initWithFrame: rect];
    self.delegate = self;
    self.layer.cornerRadius = 2.5f;
    self.clipsToBounds = YES;
    [self openCreditView];
    return self;
}

-(void)openCreditView {
    MDUser *user = [MDUser getInstance];
    [user initDataClear];
    // credit=2の時(認証したカードで少なくとも1度決済も完了している時)のみカード番号が表示される
    if(user.credit != 2)return;
    
    _creditLoadingLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.frame.size.width-30, self.frame.size.height)];
    [_creditLoadingLabel setTextAlignment:NSTextAlignmentRight];
    [_creditLoadingLabel setTextColor: [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1]];
    [_creditLoadingLabel setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:14]];
    [_creditLoadingLabel setText: @"読み込み中..."];
    
    // @"https://secure.telecomcredit.co.jp/inetcredit/secure/one-click-order.pl"
    // @"https://modelor.com/TRANSY/credit_test/credit_view.html"       for debug
    // @"https://modelor.com/TRANSY/credit_test/credit_view_error.html"       for debug
    [self openWebpageWithUrl:@"https://secure.telecomcredit.co.jp/inetcredit/secure/one-click-order.pl"
                      method:@"POST"
                   parameter:[NSDictionary dictionaryWithObjectsAndKeys:
                              PAYMENT_IP,@"clientip",
                              [NSString stringWithFormat: @"u%ld", (long)user.user_id],@"sendid",
                              @"1",@"money",
                              user.phoneNumber,@"usrtel",
                              user.mailAddress,@"usrmail",
                              nil]];
}

/**
 * open webView and load webpage
 */
- (void)openWebpageWithUrl: (NSString *)url
                    method: (NSString *)method
                 parameter: (NSDictionary *)params {
    // URLを指定
    NSURL *ns_url = [NSURL URLWithString: url];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:ns_url];
    if([method isEqualToString:@"POST"]){
        req.HTTPMethod = @"POST";
    }else{
        req.HTTPMethod = @"GET";
    }
    
    NSMutableString *body = [NSMutableString stringWithString:@""];
    for (id key in params){
        [body appendString:key];
        [body appendString:@"="];
        [body appendString:[params valueForKey:key]];
        [body appendString:@"&"];
    }
    [body deleteCharactersInRange:NSMakeRange([body length]-1, 1)];
    
    NSLog(@"URL: %@\n Body: %@", url, body);
    req.HTTPBody = [body dataUsingEncoding: NSUTF8StringEncoding];
    
    // リクエストを投げる
    [self loadRequest:req];
}


/**
 ** webViewがリクエスト送った時のDelegate(カード情報が無い事を上位のViewControllerへ伝達)
 **/
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
navigationType:(UIWebViewNavigationType)navigationType
{
     NSLog(@"request sent. scheme: %@, host: %@", request.URL.scheme, request.URL.host);
    // schemeがnative だった場合
    if ([ request.URL.scheme isEqualToString:@"auth" ] && [request.URL.host isEqualToString:@"hasNoAuthorizedCard"]) {
        if([self.creditDelegate respondsToSelector:@selector(hasNoAuthorizedCard)]){
            [self.creditDelegate hasNoAuthorizedCard];
        }
        // WebViewの読み込みは中断する。
        return NO;
    }
    // 通常のschemeの場合は、フックせずそのまま処理を続ける
    else {
        return YES;
    }
}

/**
 * Webページのロード時にインジケータを動かす
 */
- (void)webViewDidStartLoad:(UIWebView*)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self addSubview:_creditLoadingLabel];
}


/**
 * Webページのロード完了時にインジケータを非表示にする
 */
- (void)webViewDidFinishLoad:(UIWebView*)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_creditLoadingLabel removeFromSuperview];
}
@end
