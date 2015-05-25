//
//  MDSettingViewController.m
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDSettingViewController.h"
#import "MDPhoneNumberSettingViewController.h"
#import "MDNameSettingViewController.h"
#import "MDPhoneViewController.h"
#import "MDRequestViewController.h"
#import "MDDeliveryViewController.h"
#import "MDPaymentViewController.h"
#import "MDPhoneNumberSettingViewController.h"
#import "MDIndexViewController.h"
#import "MDPackageService.h"
#import "MDReviewHistoryViewController.h"
#import "MDNotificationService.h"
#import "MDNotificationTable.h"
#import "MDProtocolViewController.h"
#import "MDNotifacation.h"
#import "MDPrivacyViewController.h"
#import "MDRealmNotificationRecord.h"

@interface MDSettingViewController () {
    MDPackageService *packageService;
    MDNotificationService *notificationService;
    BOOL isAgerageLoaded;
}

@end

@implementation MDSettingViewController

-(void)loadView{
    [super loadView];
    self.navigationItem.title = @"設定";
    self.navigationController.delegate = self;
    _settingView = [[MDSettingView alloc]initWithFrame:self.view.frame];
    _settingView.delegate = self;
    [self.view addSubview:_settingView];
    
    isAgerageLoaded = NO;
}

-(void) viewWillAppear:(BOOL)animated{
    [_settingView setViewData:[MDUser getInstance]];
    [self updateData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma delegate methods
-(void) phoneNumberPushed {
    MDPhoneNumberSettingViewController *phoneNumberSettingViewController = [[MDPhoneNumberSettingViewController alloc]init];
    [self.navigationController pushViewController:phoneNumberSettingViewController animated:YES];
}

-(void) nameButtonPushed {
    MDNameSettingViewController *nameSettingViewController = [[MDNameSettingViewController alloc]init];
    [self.navigationController pushViewController:nameSettingViewController animated:YES];
}

-(void) paymentButtonPushed {
    //    NSLog(@"paymentButtonPushed");
    MDPaymentViewController *paymentViewController = [[MDPaymentViewController alloc] init];
    [self.navigationController pushViewController:paymentViewController animated:YES];
}
-(void) showCardIO {
    MDPaymentViewController *paymentViewController = [[MDPaymentViewController alloc] initWithCardIO];
    [self.navigationController pushViewController:paymentViewController animated:YES];
}
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{
    // NSLog(@"navigationController delegate called!");
    MDSelect *pay = (MDSelect *)[_settingView.scrollView viewWithTag:paymentSelect];
    if(pay){
        [pay.selectLabel setText:[MDUtil getPaymentSelectLabel]];
        [pay.selectLabel setAlpha:[MDUtil getPaymentSelectLabelAlpha]];
        [pay setBackgroundColor:[MDUtil getPaymentButtonBackground]];
    }
}

-(void) gotoDeliveryView {
    MDDeliveryViewController *rvc = [[MDDeliveryViewController alloc]init];
    UINavigationController *rvcNavigationController = [[UINavigationController alloc]initWithRootViewController:rvc];
    [self presentViewController:rvcNavigationController animated:NO completion:nil];
}
-(void) gotoRequestView {
    MDRequestViewController *rvc = [[MDRequestViewController alloc]init];
    UINavigationController *rvcNavigationController = [[UINavigationController alloc]initWithRootViewController:rvc];
    [self presentViewController:rvcNavigationController animated:NO completion:nil];
}

-(void) notificationButtonPushed {
    MDNotificationTable *nt = [[MDNotificationTable alloc]init];
    
    nt.notificationList = [MDNotificationService getInstance].notificationList;
    [self.navigationController pushViewController:nt animated:YES];
}

-(void) averageButtonPushed{
        MDReviewHistoryViewController *rhvc = [[MDReviewHistoryViewController alloc]init];
        rhvc.completePakcageList = [MDPackageService getInstance].completePackageList;
        [self.navigationController pushViewController:rhvc animated:YES];
}

-(void) logoutButtonPushed{
    [SVProgressHUD showSuccessWithStatus:@"ログアウト中..."];
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    RLMResults *newconsiger = [MDConsignor allObjectsInRealm:realm];
    MDConsignor *consignor = [[MDConsignor alloc]init];
    
    for(MDConsignor *tmp in newconsiger){
        consignor.userid = tmp.userid;
        consignor.phonenumber = tmp.phonenumber;
    }
    consignor.password = @"";
    
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:consignor];
    [realm commitWriteTransaction];
    
    [[MDUser getInstance] clearData];
    
    [SVProgressHUD dismiss];
    MDIndexViewController *ivc = [[MDIndexViewController alloc]init];
    [self presentViewController:ivc animated:NO completion:nil];
    
}

-(void) privacyButtonPushed{
    MDPrivacyViewController *pvc = [[MDPrivacyViewController alloc]init];
    [self.navigationController pushViewController:pvc animated:YES];
}

-(void) protocolButtonPushed{
    MDProtocolViewController *pvc = [[MDProtocolViewController alloc]init];
    [self.navigationController pushViewController:pvc animated:YES];
}

-(void) updateData{
    //call api
    [[MDAPI sharedAPI] getMyPackageWithHash:[MDUser getInstance].userHash
                                 OnComplete:^(MKNetworkOperation *complete){
                                     if([[complete responseJSON][@"code"] integerValue] == 0){
                                         [[MDPackageService getInstance] initDataWithArray:[complete responseJSON][@"Packages"] SortByDate:YES];
                                     }
                                     [SVProgressHUD dismiss];
                                 }
                                    onError:^(MKNetworkOperation *complete, NSError *error){
                                        NSLog(@"error ------------------------ %@", error);
                                        [SVProgressHUD dismiss];
                                    }];
    
    [self updateNotificationData];
    
    
}

-(void) updateNotificationData{
    //get data from db
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *newNoti = [MDRealmNotificationRecord allObjectsInRealm:realm];
    
    NSString *lastId;
    
    if([newNoti count] > 0){
        MDRealmNotificationRecord *noti = [newNoti lastObject];
        lastId = noti.last_id;
    } else {
        lastId = @"0";
    }
    
    [[MDAPI sharedAPI] getNotificationWithHash:[MDUser getInstance].userHash
                                        lastId:lastId
                                    OnComplete:^(MKNetworkOperation *complete) {
                                        if([[complete responseJSON][@"code"] intValue] == 0){
                                            [[MDNotificationService getInstance] initWithDataArray:[complete responseJSON][@"Notifications"]];
                                            if([[MDNotificationService getInstance].notificationList count] > 0){
                                                //save to realm
                                                [self saveNotiToDB];
                                                //update view
                                                int count = (int)[[MDNotificationService getInstance].notificationList count];
                                                [_settingView setNotificationCount:count];
                                            } else {
                                                [_settingView setNotificationCount:0];
                                            }
                                        }
                                    } onError:^(MKNetworkOperation *operation, NSError *error) {
                                        
                                    }];
}

-(void) saveNotiToDB{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    RLMResults *newNoti = [MDRealmNotificationRecord allObjectsInRealm:realm];
    MDRealmNotificationRecord *noti = [[MDRealmNotificationRecord alloc]init];
    
    MDNotifacation *notification = [[MDNotificationService getInstance].notificationList lastObject];
    
    for(MDRealmNotificationRecord *tmp in newNoti){
        noti.index = tmp.index;
    }
    if (noti.index == nil) {
        noti.index = @"0";
    }
    noti.last_id = notification.notification_id;
    
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:noti];
    [realm commitWriteTransaction];
}

@end
