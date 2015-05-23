//
//  MDDeliveryViewController.m
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDDeliveryViewController.h"
#import "MDRequestViewController.h"
#import "MDSettingViewController.h"
#import "MDSizeDescriptionViewController.h"
#import <SVProgressHUD.h>
#import "MDPackageService.h"
#import "MDNotificationService.h"


@interface MDDeliveryViewController (){
    MDPackageService *packageService;
    MDNotificationService *notificationService;
}

@end

@implementation MDDeliveryViewController

-(void)loadView{
    [super loadView];
    
    _deliveryView = [[MDDeliveryView alloc]initWithFrame:self.view.frame];
    _deliveryView.delegate = self;
    [self initNavigationBar];
    
    [self.view addSubview:_deliveryView];
    
    [MDCurrentPackage getInstance].status = @"0";
    //update data
    [self updateMyPackageData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [_deliveryView initViewData:[MDCurrentPackage getInstance]];
    
}

-(void) viewDidAppear:(BOOL)animated{
    if([[MDCurrentPackage getInstance].status isEqualToString:@"2"]){
//        [MDCurrentPackage getInstance].status = @"0";
        [self gotoRequestView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initNavigationBar {
    self.navigationItem.title = @"配送の依頼";
    //add right button item
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:_deliveryView.postButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

#pragma DeliveryDelegate
-(void)postButtonTouched {
    [self postRequest];
}


#pragma self action
-(void) postRequest {
    // 接下来做/packages/user/register
    //package_number
    MDCurrentPackage *package = [MDCurrentPackage getInstance];

    NSString *result = [_deliveryView checkInput];
    if (![result isEqualToString:@""]) {
        //警告
        [MDUtil makeAlertWithTitle:@"入力未完成" message:[NSString stringWithFormat:@"%@を入力してください",result] done:@"OK" viewController:self];
    } else {
        //ok
        [SVProgressHUD showWithStatus:@"荷物を登録中" maskType:SVProgressHUDMaskTypeClear];
        [[MDAPI sharedAPI] registerBaggageWithHash:[MDUser getInstance].userHash
                                        OnComplete:^(MKNetworkOperation *completeOperation) {
                                            
                                           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                // time-consuming task
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [SVProgressHUD dismiss];
                                                });
                                           });
                                           
                                           if([[completeOperation responseJSON][@"code"] integerValue] == 0){
                                               NSLog(@"%@", [completeOperation responseJSON]);
                                               [MDCurrentPackage getInstance].package_id        =   [completeOperation responseJSON][@"package_id"];
                                               [MDCurrentPackage getInstance].package_number    =   [completeOperation responseJSON][@"package_number"];
                                        
                                               MDPreparePayViewController * preparePayViewController = [[MDPreparePayViewController alloc]init];
                                               
                                               UINavigationController *prepareNavigationController = [[UINavigationController alloc]initWithRootViewController:preparePayViewController];
                                               [self presentViewController:prepareNavigationController animated:YES completion:nil];
                                               
                                           } else if ([[completeOperation responseJSON][@"code"] integerValue] == 2){
//                                              //警告
                                               [MDUtil makeAlertWithTitle:@"荷物登録失敗" message:@"改めてログインしてください。" done:@"OK" viewController:self];
                                           } else if ([[completeOperation responseJSON][@"code"] integerValue] == 3){
                                               //
                                               [MDUtil makeAlertWithTitle:@"依頼可能エリア外" message:@"申し訳ございません。現在は、預かり先、お届け先ともに東京都23区のみのテストリリースとなっております。ご指定のエリアは、開放されるまで今しばらくお待ちください。" done:@"OK" viewController:self];
                                           }
                                       
                                       } onError:^(MKNetworkOperation *completeOperarion, NSError *error){
                                         NSLog(@"error --------------  %@", error);
                                       }];
    }
}

-(void) selectButtonTouched:(MDSelect *)select {
    
    //select button
    if([select.buttonTitle.text isEqualToString:@"取扱注意事項"]){
        MDNoteViewController *nvc = [[MDNoteViewController alloc]init];
        [self.navigationController pushViewController:nvc animated:YES];
    
    } else if([select.buttonTitle.text isEqualToString:@"依頼金額"]){
        MDRequestAmountViewController *ravc = [[MDRequestAmountViewController alloc]init];
        [self.navigationController pushViewController:ravc animated:YES];
        
    } else if([select.buttonTitle.text isEqualToString:@"預かり時刻"]) {
        MDRecieveTimeViewController *rtvc = [[MDRecieveTimeViewController alloc]init];
        [self.navigationController pushViewController:rtvc animated:YES];
    
    } else if([select.buttonTitle.text isEqualToString:@"依頼期限"]){
        MDExpireViewController *evc = [[MDExpireViewController alloc]init];
        [evc initWithData:select.options];
        [self.navigationController pushViewController:evc animated:YES];
        
    } else if([select.buttonTitle.text isEqualToString:@"お届け期限"]){
        MDDeliveryLimitViewController *dlvc = [[MDDeliveryLimitViewController alloc]init];
        [self.navigationController pushViewController:dlvc animated:YES];
        
    } else {
        MDSizeInputViewController *sivc = [[MDSizeInputViewController alloc]init];
        [sivc initWithData:select.options];
        [self.navigationController pushViewController:sivc animated:YES];
        
    }
}

-(void)gotoRequestAddressView {
    MDInputRequestViewController *irvc = [[MDInputRequestViewController alloc]init];
    [self.navigationController pushViewController:irvc animated:YES];
}

-(void)gotoDestinationAddressView {
    MDInputDestinationViewController *dvc = [[MDInputDestinationViewController alloc]init];
    [self.navigationController pushViewController:dvc animated:YES];
}

-(void) gotoRequestView{
    MDRequestViewController *rvc = [[MDRequestViewController alloc]init];
    UINavigationController *rNavigationController = [[UINavigationController alloc]initWithRootViewController:rvc];
    [self presentViewController:rNavigationController animated:NO completion:nil];
}

-(void) gotoSettingView {
    MDSettingViewController *rvc = [[MDSettingViewController alloc]init];
    UINavigationController *rNavigationController = [[UINavigationController alloc]initWithRootViewController:rvc];
    [self presentViewController:rNavigationController animated:NO completion:nil];
}

-(void) amountNotEnough{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"金額不足"
                                                    message:@"金額が100円以上に設定してください。"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    alert.delegate = self;
    [alert show];
}

-(void) sizeDescriptionButtonPushed{
    MDSizeDescriptionViewController *sdvc = [[MDSizeDescriptionViewController alloc]init];
    [self.navigationController pushViewController:sdvc animated:YES];
}

-(void) updateMyPackageData {
    [[MDAPI sharedAPI] getMyPackageWithHash:[MDUser getInstance].userHash
                                 OnComplete:^(MKNetworkOperation *complete) {
                                     //
                                     packageService = [MDPackageService getInstance];
                                     [packageService initDataWithArray:[complete responseJSON][@"Packages"]];
                                     
                                 } onError:^(MKNetworkOperation *operation, NSError *error) {
                                     //
                                 }];
    
    [[MDAPI sharedAPI] getAllNotificationWithHash:[MDUser getInstance].userHash
                                       OnComplete:^(MKNetworkOperation *complete) {
                                           if([[complete responseJSON][@"code"] intValue] == 0){
                                               notificationService = [MDNotificationService getInstance];
                                               [notificationService initWithDataArray:[complete responseJSON][@"Notifications"]];
                                           }
                                       } onError:^(MKNetworkOperation *operation, NSError *error) {
                                           
                                       }];
}

@end
