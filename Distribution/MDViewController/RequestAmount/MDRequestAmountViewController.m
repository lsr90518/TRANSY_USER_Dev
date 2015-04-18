//
//  MDRequestAmountViewController.m
//  Distribution
//
//  Created by Lsr on 4/15/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDRequestAmountViewController.h"
#import "MDInput.h"
#import "MDCurrentPackage.h"

@interface MDRequestAmountViewController () {
    MDInput *amountInput;
}

@end

@implementation MDRequestAmountViewController

- (void) loadView {
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    amountInput = [[MDInput alloc]initWithFrame:CGRectMake(10, 74, self.view.frame.size.width-20, 50)];
    amountInput.title.text = @"依頼金額";
    [amountInput.title sizeToFit];
    amountInput.input.text = [MDCurrentPackage getInstance].request_amount;
    amountInput.input.placeholder = @"1400";
    amountInput.input.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:amountInput];
    
    [self initNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) initNavigationBar {
    self.navigationItem.title = @"依頼金額";
    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) backButtonTouched {
    
    
    
    [MDCurrentPackage getInstance].request_amount = amountInput.input.text;
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
