//
//  MDNoteViewController.m
//  Distribution
//
//  Created by Lsr on 4/14/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDNoteViewController.h"
#import "MDCurrentPackage.h"

@interface MDNoteViewController () {
    
}

@end

@implementation MDNoteViewController

-(void) loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.serviceInputView = [[UITextView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height -250)];
    [self.serviceInputView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    self.serviceInputView.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
    self.serviceInputView.returnKeyType = UIReturnKeyDefault;
    self.serviceInputView.keyboardType = UIKeyboardTypeDefault;
    self.serviceInputView.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
    self.serviceInputView.text = [MDCurrentPackage getInstance].note;
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
}

-(void) backButtonTouched {
//    [MDCurrentPackage getInstance].from_zip = requestAddressView.zipField.text;
    [MDCurrentPackage getInstance].note = self.serviceInputView.text;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
