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
    _requestDetailView.delegate = self;
    
    [_requestDetailView setStatus:[_data[@"status"] intValue]];
    
    [_requestDetailView makeupByData:_data];
    
}

-(void)initNavigationBar {
    NSString *number = [NSString stringWithFormat:@"%@",_data[@"package_number"]];
    int length = (int)number.length/2;
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
    MDRequestEditViewController *revc = [[MDRequestEditViewController alloc]init];
    [revc setData:_data];
    
    [self.navigationController pushViewController:revc animated:YES];
}

-(void) cameraButtonTouched {
    //open camera or カメラロール
    [self expendImage];
}

-(void) expendImage{
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setImage:[_requestDetailView getUploadedImage].image];
    
    
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:self.view.frame];
    [backgroundView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    
    [backgroundView addSubview:imageView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width);
        imageView.center = backgroundView.center;
        [self.view addSubview:backgroundView];
    } completion:^(BOOL finished) {
        
    }];
}
-(void)hideImage:(UITapGestureRecognizer*)tap{
    
    UIView *backgroundView=tap.view;
    [UIView animateWithDuration:0.3 animations:^{
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

@end
