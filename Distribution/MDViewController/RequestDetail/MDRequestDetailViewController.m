//
//  MDRequestDetailViewController.m
//  Distribution
//
//  Created by Lsr on 4/19/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDRequestDetailViewController.h"

@interface MDRequestDetailViewController ()

@end

@implementation MDRequestDetailViewController

-(void) loadView {
    [super loadView];
    _requestDetailView = [[MDRequestDetailView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_requestDetailView];
    
    [_requestDetailView setStatus:[_data[@"status"] intValue]];
    
    [_requestDetailView makeupByData:_data];
    
}

-(void)initNavigationBar {
    NSString *number = [NSString stringWithFormat:@"%@",_data[@"package_number"]];
    int length = number.length/2;
    NSString *numberLeft = [number substringToIndex:length];
    NSString *numberRight = [number substringFromIndex:length];
    self.navigationItem.title = [NSString stringWithFormat:@"番号: %@ - %@",numberLeft, numberRight];
    //add right button item
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonPushed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    //add right button item
    
    if ([_data[@"status"] intValue] == 0) {
        UIButton *_postButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_postButton setTitle:@"編集" forState:UIControlStateNormal];
        _postButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
        _postButton.frame = CGRectMake(0, 0, 25, 44);
        [_postButton addTarget:self action:@selector(editDetail) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:_postButton];
        self.navigationItem.rightBarButtonItem = rightBarButton;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void) viewWillAppear:(BOOL)animated{
    [self initNavigationBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) backButtonPushed {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) editDetail {
    
}

@end
