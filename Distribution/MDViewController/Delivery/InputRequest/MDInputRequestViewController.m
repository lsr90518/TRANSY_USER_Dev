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
#import "MDDevice.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <MapKit/MapKit.h>

@interface MDInputRequestViewController (){
    MDAddressInputTable *requestAddressView;
    UIActionSheet *myActionSheet;
    BOOL isInputWithCurrentLocation;
}

@end

@implementation MDInputRequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    requestAddressView = [[MDAddressInputTable alloc]initWithFrame:self.view.frame];
    //    requestAddressView.addressField.text = [MDCurrentPackage getInstance].from_addr;
    if([MDCurrentPackage getInstance].from_addr.length > 0){
        NSArray *addressArray = [[MDCurrentPackage getInstance].from_addr componentsSeparatedByString:@" "];
        requestAddressView.metropolitanField.input.text = [MDCurrentPackage getInstance].from_pref;
        requestAddressView.cityField.input.text = addressArray[0];
        requestAddressView.townField.input.text = addressArray[1];
        requestAddressView.houseField.input.text = addressArray[2];
        requestAddressView.buildingNameField.input.text = addressArray[3];
    }
    requestAddressView.delegate = self;
    [requestAddressView.zipField.input becomeFirstResponder];
    
    requestAddressView.zipField.input.text = [MDCurrentPackage getInstance].from_zip;
    [self.view addSubview:requestAddressView];
    
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
    self.navigationItem.title = @"預かり先";
    
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
    
    if(![requestAddressView isAllEmpty]){
        NSString *zip_str;
        if([requestAddressView.zipField.input.text hasPrefix:@"〒"]){
            zip_str = [requestAddressView.zipField.input.text substringFromIndex:1];
        } else {
            zip_str = requestAddressView.zipField.input.text;
        }
        NSString *addr_str = [NSString stringWithFormat:@"%@ %@ %@ %@",
                              requestAddressView.cityField.input.text,
                              requestAddressView.townField.input.text,
                              requestAddressView.houseField.input.text,
                              requestAddressView.buildingNameField.input.text];
        NSString *pref_str = requestAddressView.metropolitanField.input.text;
        
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:[NSString stringWithFormat:@"%@ %@",
                                        pref_str,
                                        addr_str]
                     completionHandler:^(NSArray *placemarks, NSError *error) {
                         
                         if(placemarks.count != 0){
                             
                             CLPlacemark* aPlacemark = [placemarks lastObject];
                             MKCoordinateRegion region;
                             
                             NSString *state = aPlacemark.addressDictionary[(NSString *)kABPersonAddressStateKey];
                             
                             if([state isEqualToString:@"東京都"]){
                                 
                                 region.center = [(CLCircularRegion *)aPlacemark.region center];
                                 
                                 [MDCurrentPackage getInstance].from_zip = zip_str;
                                 [MDCurrentPackage getInstance].from_addr = addr_str;
                                 [MDCurrentPackage getInstance].from_pref = pref_str;
                                 [MDCurrentPackage getInstance].from_lat = [NSString stringWithFormat:@"%f",region.center.latitude];
                                 [MDCurrentPackage getInstance].from_lng = [NSString stringWithFormat:@"%f",region.center.longitude];
                                 [self.navigationController popViewControllerAnimated:YES];
                             } else {
                                 [self showEreaAlert];
                             }
                         } else {
                             [self showEreaAlert];
                         }
                         
                     }];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
            [self inputByZip:requestAddressView];
            break;
        case 1:
            [self inputByCurrentLocation:requestAddressView];
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
            //住所確認
            NSString *stateStr = addressDictionary[(NSString *)kABPersonAddressStateKey];
            if([stateStr isEqualToString:@"東京都"]){
                inputTable.metropolitanField.input.text = addressDictionary[(NSString *)kABPersonAddressStateKey];
                inputTable.cityField.input.text = addressDictionary[@"City"];
                inputTable.townField.input.text = addressDictionary[@"SubLocality"];
            } else {
                inputTable.zipField.input.text = @"";
                [self showEreaAlert];
            }
        } else {
            inputTable.zipField.input.text = @"";
            [self showEreaAlert];
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
                               
                               NSString *stateStr = addressDictionary[(NSString *)kABPersonAddressStateKey];
                               if([stateStr isEqualToString:@"東京都"]){
                                   requestAddressView.metropolitanField.input.text = addressDictionary[@"State"];
                                   requestAddressView.cityField.input.text = addressDictionary[@"City"];
                                   requestAddressView.townField.input.text = addressDictionary[@"Thoroughfare"];
                                   requestAddressView.houseField.input.text = addressDictionary[@"SubThoroughfare"];
                                   NSString *zipStr = addressDictionary[@"ZIP"];
                                   requestAddressView.zipField.input.text = [NSString stringWithFormat:@"〒%@", [zipStr stringByReplacingOccurrencesOfString:@"-" withString:@""]];
                               } else {
                                   [self showEreaAlert];
                                   requestAddressView.zipField.input.text = @"";
                               }
                               isInputWithCurrentLocation = NO;
                           }
                       }];
    }
}

-(void) clearFormData {
    [requestAddressView clearData];
    [MDCurrentPackage getInstance].from_zip = @"";
    [MDCurrentPackage getInstance].from_lng = @"";
    [MDCurrentPackage getInstance].from_lat = @"";
    [MDCurrentPackage getInstance].from_addr = @"";
    [MDCurrentPackage getInstance].from_pref = @"";
}

-(void) showEreaAlert{
    [MDUtil makeAlertWithTitle:@"依頼可能エリア外" message:@"申し訳ございません。現在は、預かり先、お届け先ともに東京都23区のみのテストリリースとなっております。ご指定のエリアは、開放されるまで今しばらくお待ちください。" done:@"OK" viewController:self];
}

-(void) inputDidEnd:(MDAddressInputTable *)inputTable{
    
}



@end

