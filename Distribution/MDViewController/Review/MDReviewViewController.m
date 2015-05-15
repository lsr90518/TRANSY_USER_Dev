//
//  MDReviewViewController.m
//  DistributionDriver
//
//  Created by 劉 松然 on 2015/05/08.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import "MDReviewViewController.h"
#import "MDAPI.h"
#import <SVProgressHUD.h>
#import "MDUser.h"
#import "MDDriver.h"

@implementation MDReviewViewController{
}

-(void) loadView{
    [super loadView];
    _reviewView = [[MDReviewView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_reviewView];
    _reviewView.delegate = self;
    [self initNavigationBar];
}

-(void) initNavigationBar {
    self.navigationItem.title = @"配送員への評価";
    //add right button item
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_reviewView initWithPackage:_package driver:_driver];
    
    //get driver data
}

-(void) backButtonTouched {
    [_reviewView closeKeyBoard];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) backToTop {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) phoneButtonPushed:(MDSelect *)button{
    NSString *phoneNum = button.buttonTitle.text;// 电话号码
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNum]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}


-(void) postButtonPushed{
//    [self backToTop];
    //call api
    [SVProgressHUD showWithStatus:@"評価を保存" maskType:SVProgressHUDMaskTypeBlack];
    [[MDAPI sharedAPI] postReviewWithHash:[MDUser getInstance].userHash
                                packageId:_package.package_id
                                     star:_reviewView.review.star
                                     text:_reviewView.review.text
                              OnComplete:^(MKNetworkOperation *completeOperation){
                                  //call api
                                  
                                  [SVProgressHUD showSuccessWithStatus:@"評価完了!"];
                                  
                                  [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(backToTop) name:SVProgressHUDDidDisappearNotification object: nil];
                                  
                              }onError:^(MKNetworkOperation *operation, NSError *error) {
                                  NSLog(@"%@  error %@", [operation responseJSON], error);
                              }];
}

@end
