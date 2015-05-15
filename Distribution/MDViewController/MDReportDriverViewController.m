//
//  MDReportDriverViewController.m
//  Distribution
//
//  Created by Lsr on 5/10/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDReportDriverViewController.h"
#import "MDAPI.h"
#import <SVProgressHUD.h>

@interface MDReportDriverViewController ()

@end

@implementation MDReportDriverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.serviceInputView = [[UITextView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height -250)];
    [self.serviceInputView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    self.serviceInputView.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
    self.serviceInputView.returnKeyType = UIReturnKeyDefault;
    self.serviceInputView.keyboardType = UIKeyboardTypeDefault;
    self.serviceInputView.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
    [self.view addSubview:self.serviceInputView];
    
    [self.serviceInputView becomeFirstResponder];
    [self initNavigationBar];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    [self.serviceInputView setFrame:CGRectMake(10, 74, self.view.frame.size.width-20, 200)];
}

-(void) initNavigationBar {
    self.navigationItem.title = @"取扱説明書";
    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIButton *_postButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_postButton setTitle:@"通報" forState:UIControlStateNormal];
    _postButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _postButton.frame = CGRectMake(0, 0, 25, 44);
    [_postButton addTarget:self action:@selector(saveDetail) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:_postButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}


-(void) backButtonTouched {
    [self.serviceInputView resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) backToTop {
    [self.serviceInputView resignFirstResponder];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) saveDetail{
    //call api
    [SVProgressHUD showWithStatus:@"通報中" maskType:SVProgressHUDMaskTypeClear];
    [[MDAPI sharedAPI] reportDeiverWithHash:[MDUser getInstance].userHash
                                    driverId:_driver_id text:self.serviceInputView.text OnComplete:^(MKNetworkOperation *complete) {
                                        [SVProgressHUD showSuccessWithStatus:@"通報成功"];
                                        
                                        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(backToTop) name:SVProgressHUDDidDisappearNotification object: nil];
                                        
                                    } onError:^(MKNetworkOperation *operation, NSError *error) {
                                        
                                    }];
}

-(void) setText:(NSString *)text{
    self.serviceInputView.text = text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end