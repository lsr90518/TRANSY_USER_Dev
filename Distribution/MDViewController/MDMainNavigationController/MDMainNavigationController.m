//
//  MDMainNavigationController.m
//  Distribution
//
//  Created by 各務 将士 on 2015/07/17.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import "MDMainNavigationController.h"

@interface MDMainNavigationController ()

@end

@implementation MDMainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateMyPackageData];
    [self sendToken];
    // Do any additional setup after loading the view.
    MDRequestViewController *requestViewController = [[MDRequestViewController alloc] init];
    [self setViewControllers:[NSArray arrayWithObject:requestViewController]];
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

-(void) updateMyPackageData {
    [[MDAPI sharedAPI] getMyPackageWithHash:[MDUser getInstance].userHash
                                 OnComplete:^(MKNetworkOperation *complete) {
                                     //
                                     MDPackageService *packageService = [MDPackageService getInstance];
                                     [packageService initDataWithArray:[complete responseJSON][@"Packages"]];
                                     
                                 } onError:^(MKNetworkOperation *operation, NSError *error) {
                                     //
                                 }];
}
-(void) sendToken{
    [[MDAPI sharedAPI] updateProfileByUser:[MDUser getInstance]
                              sendPassword:NO
                                onComplete:^(MKNetworkOperation *complete) {
                                    //
                                } onError:^(MKNetworkOperation *operation, NSError *error) {
                                    //
                                }];
}

- (void)logoutDone {
    if([self.main_delegate respondsToSelector:@selector(closeAllView)]){
        [self.main_delegate closeAllView];
    }
}

@end
