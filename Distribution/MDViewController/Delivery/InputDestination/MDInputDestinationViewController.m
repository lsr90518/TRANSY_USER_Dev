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
    
    destinationAddressView = [[MDAddressInputTable alloc]initWithFrame:CGRectMake(10, 74, self.view.frame.size.width-20, 100)];
    destinationAddressView.layer.cornerRadius = 2.5;
    destinationAddressView.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
    destinationAddressView.layer.borderWidth = 0.5;
    destinationAddressView.addressField.text = [MDCurrentPackage getInstance].to_addr;
    destinationAddressView.zipField.text = [MDCurrentPackage getInstance].to_zip;
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
}


-(void) backButtonTouched {
    [MDCurrentPackage getInstance].to_zip = destinationAddressView.zipField.text;
    [MDCurrentPackage getInstance].to_addr = destinationAddressView.addressField.text;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [SVProgressHUD show];
    [geocoder geocodeAddressString:destinationAddressView.addressField.text completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark* aPlacemark in placemarks)
        {
            [MDCurrentPackage getInstance].to_lat = [NSString stringWithFormat:@"%f",aPlacemark.region.center.latitude];
            [MDCurrentPackage getInstance].to_lng = [NSString stringWithFormat:@"%f",aPlacemark.region.center.longitude];
            NSLog(@"お届け%@", [MDCurrentPackage getInstance].to_lat);
            
        }
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
