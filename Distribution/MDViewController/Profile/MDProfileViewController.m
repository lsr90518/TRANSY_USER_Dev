//
//  MDProfileViewController.m
//  Distribution
//
//  Created by Lsr on 5/9/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDProfileViewController.h"
#import "MDReportDriverViewController.h"

@interface MDProfileViewController ()

@end

@implementation MDProfileViewController

-(void)loadView{
    [super loadView];
    _profileView = [[MDProfileView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_profileView];
    _profileView.delegate = self;
    [self initNavigationBar];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_profileView setDriverData:_driver];
    [_profileView setStatus:_package.status];
}

-(void) initNavigationBar {
    self.navigationItem.title = _driver.name;
    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}

-(void)backButtonTouched{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) backToTop{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)phoneButtonPushed:(MDSelect *)button{
    NSString *phoneNum = button.selectLabel.text;// 电话号码
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNum]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

-(void)blockButtonPushed{
    //call api
    
    [[MDAPI sharedAPI] blockDriverWithHash:[MDUser getInstance].userHash
                                    dirverId:_driver.driver_id
                                    OnComplete:^(MKNetworkOperation *complete) {
                                        [SVProgressHUD showSuccessWithStatus:@"ドライバーをブロックしました！" maskType:SVProgressHUDMaskTypeGradient];
                                        
                                        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(backToTop) name:SVProgressHUDDidDisappearNotification object: nil];
                                    } onError:^(MKNetworkOperation *operation, NSError *error) {
                                        
                                    }];
}
-(void) reportButtonPushed{
    MDReportDriverViewController *rdvc = [[MDReportDriverViewController alloc]init];
    rdvc.driver_id = _driver.driver_id;
    [self.navigationController pushViewController:rdvc animated:YES];
}

-(void) rejectButtonPushed{
    [[MDAPI sharedAPI] rejectDrvierWithHash:[MDUser getInstance].userHash
                                  PakcageId:_package.package_id
                                 OnComplete:^(MKNetworkOperation *complete) {
                                      //
                                     if ([[complete responseJSON][@"code"] intValue] == 0) {
                                         [SVProgressHUD showSuccessWithStatus:@"ドライバーをリジェクトしました。" maskType:SVProgressHUDMaskTypeGradient];
                                         
                                         [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(backToTop) name:SVProgressHUDDidDisappearNotification object: nil];
                                     } else {
                                         [SVProgressHUD showSuccessWithStatus:@"ドライバーをリジェクトできませんでした。" maskType:SVProgressHUDMaskTypeGradient];
                                         
                                     }
                                 } onError:^(MKNetworkOperation *operation, NSError *error) {
                                     [SVProgressHUD showSuccessWithStatus:@"ドライバーをリジェクトできませんでした。" maskType:SVProgressHUDMaskTypeGradient];
                                  }];
}

@end
