//
//  MDDeliveryViewController.m
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDDeliveryViewController.h"
#import <SVProgressHUD.h>


@interface MDDeliveryViewController ()

@end

@implementation MDDeliveryViewController

-(void)loadView{
    [super loadView];
    
    _deliveryView = [[MDDeliveryView alloc]initWithFrame:self.view.frame];
    _deliveryView.delegate = self;
    [self initNavigationBar];
    
    [self.view addSubview:_deliveryView];
    MDCurrentPackage *currentPackage = [[MDCurrentPackage alloc]init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    
    [_deliveryView initViewData:[MDCurrentPackage getInstance]];
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
    
                                                   MDPreparePayViewController * preparePayViewController = [[MDPreparePayViewController alloc]init];
                                                   [self.navigationController pushViewController:preparePayViewController animated:YES];
    NSString *result = [_deliveryView checkInput];
//    if (![result isEqualToString:@""]) {
//        //警告
//        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"未完成"
//                                                                       message:[NSString stringWithFormat:@"%@を入力してください。", result]
//                                                                preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//                                                              handler:^(UIAlertAction * action) {}];
//        [alert addAction:defaultAction];
//        [self presentViewController:alert animated:YES completion:nil];
//    } else {
//        //ok
//        [SVProgressHUD show];
//        [[MDAPI sharedAPI] registerBaggageWithHash:[MDUser getInstance].userHash
//                                       OnComplete:^(MKNetworkOperation *completeOperation) {
//                                           [SVProgressHUD dismiss];
//                                           
//                                           if([[completeOperation responseJSON][@"code"] integerValue] == 0){
//                                               [MDCurrentPackage getInstance].package_id        =   [completeOperation responseJSON][@"package_id"];
//                                               [MDCurrentPackage getInstance].package_number    =   [completeOperation responseJSON][@"package_number"];
//                                               MDPreparePayViewController * preparePayViewController = [[MDPreparePayViewController alloc]init];
//                                               [self.navigationController pushViewController:preparePayViewController animated:YES];
//                                           } else if ([[completeOperation responseJSON][@"code"] integerValue] == 2){
//                                               //警告
//                                               UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"荷物登録失敗"
//                                                                                                              message:@"改めてログインしてください"
//                                                                                                       preferredStyle:UIAlertControllerStyleAlert];
//                                               UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
//                                                                                                     handler:^(UIAlertAction * action) {}];
//                                               [alert addAction:defaultAction];
//                                               [self presentViewController:alert animated:YES completion:nil];
//                                           }
//                                       
//                                       } onError:^(MKNetworkOperation *completeOperarion, NSError *error){
//                                         NSLog(@"error --------------  %@", error);
//                                       }];
//    }
}

-(void) selectButtonTouched:(MDSelect *)select {
    
    
    //select button
    if([select.buttonTitle.text isEqualToString:@"取扱説明書"]){
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


@end
