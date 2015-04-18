//
//  MDRequestViewController.m
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDRequestViewController.h"

@interface MDRequestViewController ()

@end

@implementation MDRequestViewController

-(void)loadView{
    [super loadView];
    
    self.navigationItem.title = @"依頼一覧";
    _requestView = [[MDRequestView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_requestView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
