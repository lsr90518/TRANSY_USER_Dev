//
//  MDInputRequestViewController.m
//  Distribution
//
//  Created by Lsr on 4/13/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDInputRequestViewController.h"
#import "MDAddressInputTable.h"
#import "MDCurrentPackage.h"
#import "MDDeliveryViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <MapKit/MapKit.h>

@interface MDInputRequestViewController (){
    MDAddressInputTable *requestAddressView;
}

@end

@implementation MDInputRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    requestAddressView = [[MDAddressInputTable alloc]initWithFrame:CGRectMake(10, 74, self.view.frame.size.width-20, 100)];
    requestAddressView.layer.cornerRadius = 2.5;
    requestAddressView.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
    requestAddressView.layer.borderWidth = 0.5;
    requestAddressView.addressField.text = [MDCurrentPackage getInstance].from_addr;
    requestAddressView.zipField.text = [MDCurrentPackage getInstance].from_zip;
    [self.view addSubview:requestAddressView];
    
    [self initNavigationBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initNavigationBar {
    self.navigationItem.title = @"預かり先";
    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}


-(void) backButtonTouched {
    [MDCurrentPackage getInstance].from_zip = requestAddressView.zipField.text;
    [MDCurrentPackage getInstance].from_addr = requestAddressView.addressField.text;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [SVProgressHUD show];
    [geocoder geocodeAddressString:requestAddressView.addressField.text completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark* aPlacemark in placemarks)
        {
            MKCoordinateRegion region;
            region.center.latitude = aPlacemark.region.center.latitude;
            region.center.longitude = aPlacemark.region.center.longitude;
            
            [MDCurrentPackage getInstance].from_lat = [NSString stringWithFormat:@"%f",region.center.latitude];
            [MDCurrentPackage getInstance].from_lng = [NSString stringWithFormat:@"%f",region.center.longitude];
            
        }
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
}

@end

