//
//  MDInputDestinationViewController.m
//  Distribution
//
//  Created by Lsr on 4/13/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDInputDestinationViewController.h"
#import "MDAddressInputTable.h"
#import "MDCurrentPackage.h"
#import <MapKit/MapKit.h>
#import <SVProgressHUD.h>

@interface MDInputDestinationViewController (){
    MDAddressInputTable *destinationAddressView;
}

@end

@implementation MDInputDestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    destinationAddressView = [[MDAddressInputTable alloc]initWithFrame:self.view.frame];
//    destinationAddressView.addressField.text = [MDCurrentPackage getInstance].to_addr;
    NSArray *addressArray = [[MDCurrentPackage getInstance].to_addr componentsSeparatedByString:@" "];
    destinationAddressView.metropolitanField.input.text = addressArray[0];
    destinationAddressView.cityField.input.text = addressArray[1];
    destinationAddressView.townField.input.text = addressArray[2];
    destinationAddressView.houseField.input.text = addressArray[3];
    destinationAddressView.buildingNameField.input.text = addressArray[4];
    
    destinationAddressView.zipField.input.text = [MDCurrentPackage getInstance].to_zip;
    [self.view addSubview:destinationAddressView];
    
    [self initNavigationBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initNavigationBar {
    self.navigationItem.title = @"お届け先";
    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    //right button
    UIButton *_postButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_postButton setTitle:@"次へ" forState:UIControlStateNormal];
    _postButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _postButton.frame = CGRectMake(0, 0, 25, 44);
    [_postButton addTarget:self action:@selector(postButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:_postButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}


-(void) postButtonTouched {
    if([destinationAddressView.zipField.input.text hasPrefix:@"〒"]){
        [MDCurrentPackage getInstance].from_zip = [destinationAddressView.zipField.input.text substringFromIndex:1];
    } else {
        [MDCurrentPackage getInstance].from_zip = destinationAddressView.zipField.input.text;
    }
    [MDCurrentPackage getInstance].to_addr = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", destinationAddressView.metropolitanField.input.text,
                                                destinationAddressView.cityField.input.text,
                                                destinationAddressView.townField.input.text,
                                                destinationAddressView.houseField.input.text,
                                                destinationAddressView.buildingNameField.input.text];
    [MDCurrentPackage getInstance].to_pref = destinationAddressView.metropolitanField.input.text;

    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:[MDCurrentPackage getInstance].to_addr completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark* aPlacemark in placemarks)
        {
            MKCoordinateRegion region;
            region.center.latitude = aPlacemark.region.center.latitude;
            region.center.longitude = aPlacemark.region.center.longitude;
            
            [MDCurrentPackage getInstance].to_lat = [NSString stringWithFormat:@"%f",region.center.latitude];
            [MDCurrentPackage getInstance].to_lng = [NSString stringWithFormat:@"%f",region.center.longitude];
            
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

-(void) backButtonTouched {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
