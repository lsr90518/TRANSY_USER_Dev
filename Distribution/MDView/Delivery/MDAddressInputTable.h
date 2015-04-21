//
//  MDAddressInputTable.h
//  Distribution
//
//  Created by Lsr on 3/30/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>

@interface MDAddressInputTable : UIView

@property (strong, nonatomic) UIButton      *autoInputButton;
@property (strong, nonatomic) UIImageView   *zipIcon;
@property (strong, nonatomic) UITextField   *zipField;
@property (strong, nonatomic) UITextField   *addressField;
@property (strong, nonatomic) UIView        *rzaLine;
@property (strong, nonatomic) NSString      *lng;
@property (strong, nonatomic) NSString      *lat;

-(void)setFrameColor:(UIColor *)color;

-(void) setUnAvailable;
@end
