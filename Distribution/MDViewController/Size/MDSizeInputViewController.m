//
//  MDSizeInputViewController.m
//  Distribution
//
//  Created by Lsr on 4/14/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDSizeInputViewController.h"

@interface MDSizeInputViewController ()

@end

@implementation MDSizeInputViewController

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    _scrollView.bounces = YES;
    [self.view addSubview:_scrollView];

    [self initNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) initNavigationBar {
    self.navigationItem.title = @"サイズを選択";
    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}

-(void) viewWillAppear:(BOOL)animated {
    
}

-(void) initWithData:(NSArray *)datas {
    _dataArray = [[NSMutableArray alloc]initWithArray:datas];
    for(int i = 0;i<[_dataArray count];i++){
        UIButton *option = [[UIButton alloc]initWithFrame:CGRectMake(0, i*50, self.view.frame.size.width, 50)];
        option.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        option.layer.borderWidth = 0.5;
        [option setBackgroundColor:[UIColor whiteColor]];
        [option setTitle:_dataArray[i] forState:UIControlStateNormal];
        [option setTitleColor:[UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1] forState:UIControlStateNormal];
        [option addTarget:self action:@selector(buttonPushed:) forControlEvents:UIControlEventTouchUpInside];
        [option setTitleColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:204.0/255.0] forState:UIControlStateHighlighted];
        option.tag = i;
        [_scrollView addSubview:option];
    }
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, [_dataArray count]*50)];
}

-(void) backButtonTouched {
//    [MDCurrentPackage getInstance].from_zip = requestAddressView.zipField.text;
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) buttonPushed:(UIButton *)button {
    [MDCurrentPackage getInstance].size = _dataArray[button.tag];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
