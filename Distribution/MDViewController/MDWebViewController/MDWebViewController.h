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

- (void)openWebpageWithUrl: (NSString *)url
                    method: (NSString *)method
                 parameter: (NSDictionary *)params;

@end
