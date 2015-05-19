//
//  MDInputRequestViewController.h
//  Distribution
//
//  Created by Lsr on 4/13/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDInput.h"
#import "MDAddressInputTable.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface MDInputRequestViewController : UIViewController<MDAddressInputTableDelegate, UIActionSheetDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end
