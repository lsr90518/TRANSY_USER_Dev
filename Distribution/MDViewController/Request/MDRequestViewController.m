//
//  MDRequestViewController.m
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDRequestViewController.h"
#import "MDDeliveryViewController.h"
#import "MDSettingViewController.h"
#import "MDRequestDetailViewController.h"

@interface MDRequestViewController ()

@end

@implementation MDRequestViewController

-(void)loadView{
    [super loadView];
    
    _requestView = [[MDRequestView alloc]initWithFrame:self.view.frame];
    _requestView.delegate = self;
    [self.view addSubview:_requestView];
    [self initNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated{
    _packageService = [[MDPackageService alloc]init];
    
    //call api
    [SVProgressHUD show];
    
    [[MDAPI sharedAPI] getMyPackageWithHash:[MDUser getInstance].userHash
                                 OnComplete:^(MKNetworkOperation *complete){
                                     if([[complete responseJSON][@"code"] integerValue] == 0){
                                         //
                                         [_packageService initDataWithArray:[complete responseJSON][@"Packages"] SortByDate:YES];
                                         [_requestView initWithArray:_packageService.packageList];
                                     }
                                     [SVProgressHUD dismiss];
                                 }
                                    onError:^(MKNetworkOperation *complete, NSError *error){
                                        NSLog(@"error ------------------------ %@", error);
                                        [SVProgressHUD dismiss];
                                    }];
}

-(void) viewDidAppear:(BOOL)animated{
    if([[MDCurrentPackage getInstance].status isEqualToString:@"2"]){
        [MDCurrentPackage getInstance].status = @"0";
        [MDUtil makeAlertWithTitle:@"荷物の依頼を掲載しました。" message:@"条件が会う配送員が見つかり次第、通知を致します。お手数ですが、今しばらくお待ち下さい。" done:@"OK" viewController:self];
    }
}

-(void) initNavigationBar {
    self.navigationItem.title = @"依頼一覧";
    self.navigationItem.hidesBackButton = YES;
    //add right button item
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"setting_tab_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(gotoSettingView)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) gotoDeliveryView{
    MDDeliveryViewController *dvc = [[MDDeliveryViewController alloc]init];
    UINavigationController *dvcNavigationController = [[UINavigationController alloc]initWithRootViewController:dvc];
    [self presentViewController:dvcNavigationController animated:YES completion:nil];
}

-(void) gotoSettingView {
    MDSettingViewController *dvc = [[MDSettingViewController alloc]init];
    dvc.mainNav = (MDMainNavigationController *)self.navigationController;
    UINavigationController *settingNav = [[UINavigationController alloc] initWithRootViewController:dvc];
    [self presentViewController:settingNav animated:YES completion:nil];
}

-(void) makeUpData:(MDPackage *)data{
    if(data != nil){
        MDRequestDetailViewController *rdvc = [[MDRequestDetailViewController alloc]init];
        //ここ
        NSLog(@"%@", data);
//        MDPackage *tmpPackage = [[MDPackage alloc]initWithData:data];
        rdvc.package = data;
        [self.navigationController pushViewController:rdvc animated:YES];
    }
}

-(void) refreshData {
    [[MDAPI sharedAPI] getMyPackageWithHash:[MDUser getInstance].userHash
                                 OnComplete:^(MKNetworkOperation *complete){
                                     if([[complete responseJSON][@"code"] integerValue] == 0){
                                         //
                                         [_packageService initDataWithArray:[complete responseJSON][@"Packages"] SortByDate:YES];
                                         [_requestView initWithArray:_packageService.packageList];
                                         [_requestView endRefresh];
                                     }
                                 }
                                    onError:^(MKNetworkOperation *complete, NSError *error){
                                        NSLog(@"error ------------------------ %@", error);
                                        [SVProgressHUD dismiss];
                                    }];
}

@end
