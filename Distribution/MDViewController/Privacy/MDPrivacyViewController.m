//
//  MDPrivacyViewController.m
//  Distribution
//
//  Created by Lsr on 5/18/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDPrivacyViewController.h"
#import "MDAPI.h"

@interface MDPrivacyViewController ()

@end

@implementation MDPrivacyViewController

-(void)loadView{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    
    [self.view addSubview:_webView];
    [self initNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewDidAppear:(BOOL)animated{
    NSURL *url =[NSURL URLWithString:API_HOST_PRIVACY];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavigationBar {
    self.navigationItem.title = @"プライバシーポリシー";
    //add right button item
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
