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
    UIActionSheet *myActionSheet;
    BOOL isInputWithCurrentLocation;
}

@end

@implementation MDInputDestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    destinationAddressView = [[MDAddressInputTable alloc]initWithFrame:self.view.frame];
    
    NSArray *addressArray = [[MDCurrentPackage getInstance].to_addr componentsSeparatedByString:@" "];
    destinationAddressView.metropolitanField.input.text = [MDCurrentPackage getInstance].to_pref;
    destinationAddressView.cityField.input.text = addressArray[0];
    destinationAddressView.townField.input.text = addressArray[1];
    destinationAddressView.houseField.input.text = addressArray[2];
    destinationAddressView.buildingNameField.input.text = addressArray[3];
    [destinationAddressView.zipField.input becomeFirstResponder];
    
    destinationAddressView.zipField.input.text = [MDCurrentPackage getInstance].to_zip;
    [self.view addSubview:destinationAddressView];
    destinationAddressView.delegate = self;
    
    [self initNavigationBar];
    
    isInputWithCurrentLocation = NO;
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        [self.locationManager requestAlwaysAuthorization];
    }
#endif
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
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
    [_postButton setTitle:@"クリア" forState:UIControlStateNormal];
    _postButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _postButton.frame = CGRectMake(0, 0, 38, 44);
    [_postButton addTarget:self action:@selector(clearFormData) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:_postButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}


-(void) backButtonTouched {
    if([destinationAddressView.zipField.input.text hasPrefix:@"〒"]){
        [MDCurrentPackage getInstance].to_zip = [destinationAddressView.zipField.input.text substringFromIndex:1];
    } else {
        [MDCurrentPackage getInstance].to_zip = destinationAddressView.zipField.input.text;
    }
    [MDCurrentPackage getInstance].to_addr = [NSString stringWithFormat:@"%@ %@ %@ %@", destinationAddressView.cityField.input.text,
                                                                                        destinationAddressView.townField.input.text,
                                                                                        destinationAddressView.houseField.input.text,
                                                                                        destinationAddressView.buildingNameField.input.text];
    [MDCurrentPackage getInstance].to_pref = destinationAddressView.metropolitanField.input.text;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:[MDCurrentPackage getInstance].to_addr completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark* aPlacemark in placemarks)
        {
            MKCoordinateRegion region;
            region.center = [(CLCircularRegion *)aPlacemark.region center];
            
            [MDCurrentPackage getInstance].to_lat = [NSString stringWithFormat:@"%f",region.center.latitude];
            [MDCurrentPackage getInstance].to_lng = [NSString stringWithFormat:@"%f",region.center.longitude];
            
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

-(void) autoButtonPushed:(MDAddressInputTable *)inputTable{
    [inputTable closeKeyboard];
    myActionSheet = [[UIActionSheet alloc]
                     initWithTitle:nil
                     delegate:self
                     cancelButtonTitle:@"キャンセル"
                     destructiveButtonTitle:nil
                     otherButtonTitles: @"郵便番号から", @"現在地から",nil];
    [myActionSheet showInView:self.view];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self inputByZip:destinationAddressView];
            break;
        case 1:
            [self inputByCurrentLocation:destinationAddressView];
            break;
        default:
            break;
    }
}

-(void) inputByZip:(MDAddressInputTable *)inputTable{
    isInputWithCurrentLocation = NO;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:inputTable.zipField.input.text completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = placemarks.firstObject;
        
        NSDictionary *addressDictionary = placemark.addressDictionary;
        if(addressDictionary[(NSString *)kABPersonAddressStateKey]){
            inputTable.metropolitanField.input.text = addressDictionary[(NSString *)kABPersonAddressStateKey];
            inputTable.cityField.input.text = addressDictionary[@"City"];
            inputTable.townField.input.text = addressDictionary[@"SubLocality"];
        }
    }];
}

-(void) inputByCurrentLocation:(MDAddressInputTable *)inputTable{
    [SVProgressHUD show];
    isInputWithCurrentLocation = YES;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"error %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    if(isInputWithCurrentLocation){
        CLLocation* location = [locations lastObject];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        
        [geocoder reverseGeocodeLocation:location
                       completionHandler:^(NSArray *placemarks, NSError *error) {
                           
                           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                               // time-consuming task
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   [SVProgressHUD dismiss];
                               });
                           });
                           
                           CLPlacemark *placemark = placemarks.firstObject;
                           
                           NSDictionary *addressDictionary = placemark.addressDictionary;
                           if(addressDictionary[(NSString *)kABPersonAddressStateKey]){
                               destinationAddressView.metropolitanField.input.text = addressDictionary[@"State"];
                               destinationAddressView.cityField.input.text = addressDictionary[@"City"];
                               destinationAddressView.townField.input.text = addressDictionary[@"Thoroughfare"];
                               destinationAddressView.houseField.input.text = addressDictionary[@"SubThoroughfare"];
                               NSString *zipStr = addressDictionary[@"ZIP"];
                               destinationAddressView.zipField.input.text = [NSString stringWithFormat:@"〒%@", [zipStr stringByReplacingOccurrencesOfString:@"-" withString:@""]];
                               isInputWithCurrentLocation = NO;
                           }
                       }];
    }
}

-(void) clearFormData {
    [destinationAddressView clearData];
    [MDCurrentPackage getInstance].to_lat = @"";
    [MDCurrentPackage getInstance].to_lng = @"";
    [MDCurrentPackage getInstance].to_addr = @"";
    [MDCurrentPackage getInstance].to_zip = @"";
}

@end
