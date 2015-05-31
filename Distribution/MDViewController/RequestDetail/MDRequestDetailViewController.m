//
//  MDRequestDetailViewController.m
//  Distribution
//
//  Created by Lsr on 4/19/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDRequestDetailViewController.h"
#import "MDReviewViewController.h"
#import "MDSizeDescriptionViewController.h"
#import "MDProfileViewController.h"

@interface MDRequestDetailViewController ()

@end

@implementation MDRequestDetailViewController

-(void) loadView {
    [super loadView];
    _requestDetailView = [[MDRequestDetailView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_requestDetailView];
    _requestDetailView.delegate = self;
}

-(void)initNavigationBar {
    NSString *number = [NSString stringWithFormat:@"%@",_package.package_number];
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
    
    if ([_package.status intValue] == 0) {
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
    
    if([_package.status intValue] != 0){
        [self getDriverData];
    }
    
    [_requestDetailView makeupByData:_package];
    
    [_requestDetailView setStatus:[_package.status intValue]];
    
    NSString *driverReviewed = [NSString stringWithFormat:@"%@", _package.driverReview.reviewed];
//    if([driverReviewed isEqualToString:@"1"]){
//        [_requestDetailView setDriverReviewContent:_package.driverReview];
//    }
    
    NSString *userReviewed = [NSString stringWithFormat:@"%@", _package.userReview.reviewed];
    if([userReviewed isEqualToString:@"1"] && [driverReviewed isEqualToString:@"1"]){
        [_requestDetailView setReviewContent:_package.userReview];
    } else if([userReviewed isEqualToString:@"0"]){
        [_requestDetailView takePackageButton];
    }
}

-(void) getDriverData{
    //call api
    [SVProgressHUD showWithStatus:@"" maskType:SVProgressHUDMaskTypeClear];
    [[MDAPI sharedAPI] getDriverDataWithHash:[MDUser getInstance].userHash
                                    dirverId:_package.driver_id
                                  OnComplete:^(MKNetworkOperation *complete) {
                                      
                                      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                          // time-consuming task
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [SVProgressHUD dismiss];
                                          });
                                      });
                                      
                                      _driver = [[MDDriver alloc]init];
                                      [_driver initWithData:[complete responseJSON][@"Driver"]];
                                      [_requestDetailView setDriverData:_driver];
                                  } onError:^(MKNetworkOperation *operation, NSError *error) {
        
                                  }];
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
    revc.package = _package;
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

-(void) reviewButtonPushed{
    MDReviewViewController *rvc = [[MDReviewViewController alloc]init];
    rvc.package = _package;
    rvc.driver = _driver;
    [self.navigationController pushViewController:rvc animated:YES];
    
}

-(void) profileButtonPushed{
    MDProfileViewController *pvc = [[MDProfileViewController alloc]init];
    pvc.driver = _driver;
    pvc.package = _package;
    
    [self.navigationController pushViewController:pvc animated:YES];
}

-(void) sizeDescriptionButtonPushed{
    MDSizeDescriptionViewController *sdvc = [[MDSizeDescriptionViewController alloc]init];
    [self.navigationController pushViewController:sdvc animated:YES];
}

-(void)matchButtonPushed{
    [MDUtil makeAlertWithTitle:@"配送員マッチング中" message:@"只今、配送員を探しております。掲載期限中にマッチングしない場合は、キャンセル扱いとなります。キャンセルされた場合は、依頼金額など条件を変更してもう一度お試しください。" done:@"OK" viewController:self];
}

-(void) cancelButtonPushed{
    
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"依頼のキャンセル"    //标题
                                                  message:@"依頼をキャンセルしますが、よろしいでしょうか。"   //显示内容
                                                 delegate:self          //委托，可以点击事件进行处理
                                        cancelButtonTitle:@"いいえ"
                                        otherButtonTitles:@"はい",nil];
    [view show];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            [self cancelPackage];
            break;
        default:
            break;
    }
}

-(void) cancelPackage{
    [SVProgressHUD show];
    //call api
    [[MDAPI sharedAPI] cancelMyPackageWithHash:[MDUser getInstance].userHash
                                       Package:_package
                                    OnComplete:^(MKNetworkOperation *complete) {
                                        //
                                        [SVProgressHUD dismiss];
                                        if([[complete responseJSON][@"code"] intValue] == 0){
                                            [self backButtonPushed];
                                        }
                                    } onError:^(MKNetworkOperation *operation, NSError *error) {
                                        //
                                    }];
}

-(void) addressButtonPushed:(MDAddressButton *)button{
    // URL encode the spaces
    NSString *addressText =  [button.addressField.text stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    //apple map
    NSString* urlText = [NSString stringWithFormat:@"http://maps.apple.com/maps?q=%@",addressText];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlText]];
}


@end
