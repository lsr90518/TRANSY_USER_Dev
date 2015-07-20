//
//  MDWebViewController.h
//  Distribution
//
//  Created by 各務 将士 on 2015/04/23.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDWebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NSString *initialOpenUrl;
@property (strong, nonatomic) NSString *initialOpenTitle;
@property (strong, nonatomic) UIButton *backButton;

- (MDWebViewController *)initWithUrl: (NSString *)url
                               title: (NSString *)title;

- (void)openWebpageWithUrl: (NSString *)url
                    method: (NSString *)method
                 parameter: (NSDictionary *)params;

@end
