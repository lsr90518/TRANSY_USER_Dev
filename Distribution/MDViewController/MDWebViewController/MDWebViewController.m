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
- (MDWebViewController *)initWithUrl: (NSString *)url title:(NSString *)title {
    self = [super init];
    _initialOpenUrl = url;
    _initialOpenTitle = title;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // UIWebViewのインスタンス化
    CGRect rect = self.view.frame;
    rect.size.height -= (self.navigationController.navigationBar.bounds.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height);
    _webView = [[UIWebView alloc]initWithFrame: rect];
    
    // Webページの大きさを自動的に画面にフィットさせる
    _webView.scalesPageToFit = YES;
    
    // デリゲートを指定(小クラスにdelegateを実装した場合そちらでselfを上書き指定)
    _webView.delegate = self;
    
    if(_initialOpenUrl && _initialOpenTitle){
        [self openWebpageWithUrl:_initialOpenUrl method:@"GET" parameter:nil];
        [self initNavigationBarWithTitle:_initialOpenTitle];
    }
}

-(void)initNavigationBarWithTitle: (NSString *)title {
    self.navigationItem.title = title;
    //add right button item
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonPushed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}
-(void) backButtonPushed{
    [self.navigationController popViewControllerAnimated:YES];
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
    if([body length] > 0)[body deleteCharactersInRange:NSMakeRange([body length]-1, 1)];
    
    // NSLog(@"URL: %@\n Body: %@", url, body);
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
