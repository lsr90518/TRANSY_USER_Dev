//
//  MDWebViewController.m
//  Distribution
//
//  Created by 各務 将士 on 2015/04/23.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//


#import "MDWebViewController.h"
#import <SVProgressHUD.h>


@implementation MDWebViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UIWebViewのインスタンス化
    CGRect rect = self.view.frame;
    _webView = [[UIWebView alloc]initWithFrame:rect];
    
    // Webページの大きさを自動的に画面にフィットさせる
    _webView.scalesPageToFit = YES;
    
    // デリゲートを指定(小クラスにdelegateを実装した場合そちらでselfを上書き指定)
    _webView.delegate = self;
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
    [_webView loadRequest:req];
    
    // UIWebViewのインスタンスをビューに追加
    [self.view addSubview:_webView];
}


/**
 * Webページのロード時にインジケータを動かす
 */
- (void)webViewDidStartLoad:(UIWebView*)webView
{
    [SVProgressHUD show];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


/**
 * Webページのロード完了時にインジケータを非表示にする
 */
- (void)webViewDidFinishLoad:(UIWebView*)webView
{
    [SVProgressHUD dismiss];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
@end
