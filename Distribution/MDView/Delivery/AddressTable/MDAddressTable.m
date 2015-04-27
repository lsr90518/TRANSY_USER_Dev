//
//  MDAddressTable.m
//  Distribution
//
//  Created by Lsr on 4/25/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDAddressTable.h"

@implementation MDAddressTable

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //add code
        //make frame line
        //request zip address line
        self.rzaLine = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height/2, frame.size.width, 0.5)];
        [self.rzaLine setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1]];
        [self addSubview:self.rzaLine];
        
        //zipcode
        self.zipIcon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 19, 92, 11)];
        [self.zipIcon setImage:[UIImage imageNamed:@"zipcode"]];
        [self addSubview:self.zipIcon];
        
        //zipInput
        self.zipField = [[UITextField alloc]initWithFrame:CGRectMake(42, 19, 92, 12)];
        self.zipField.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
        self.zipField.placeholder = @"XXXXXXX";
        self.zipField.keyboardType = UIKeyboardTypeNumberPad;
        [self.zipField setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.zipField];
        
        //autoInputButton
        self.autoInputButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-93, 0, 93, frame.size.height/2)];
        [self.autoInputButton setTitle:@"自動入力" forState:UIControlStateNormal];
        self.autoInputButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
        [self.autoInputButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.autoInputButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.autoInputButton addTarget:self action:@selector(autoInputAddress) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.autoInputButton];
        
        //address input field
        self.addressField = [[UITextField alloc]initWithFrame:CGRectMake(19, 68, frame.size.width-40, 13)];
        self.addressField.font = [UIFont fontWithName:@"HiraKakuProN-w3" size:14];
        self.addressField.placeholder = @"例: 東京都 渋谷区";
        
        [self addSubview:self.addressField];
        
    }
    return self;
}

-(void) setFrameColor:(UIColor *)color {
    [self.rzaLine setBackgroundColor:color];
}

-(void)autoInputAddress {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:self.zipField.text completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = placemarks.firstObject;
        
        NSDictionary *addressDictionary = placemark.addressDictionary;
        if(addressDictionary[(NSString *)kABPersonAddressStateKey]){
            self.addressField.text = [NSString stringWithFormat:@"%@ %@ ",addressDictionary[(NSString *)kABPersonAddressStateKey],addressDictionary[(NSString *)kABPersonAddressCityKey]];
        }
    }];
    
}

-(void) setUnAvailable{
    [self.zipField setUserInteractionEnabled:NO];
    [self.autoInputButton setHidden:YES];
    [self.addressField setUserInteractionEnabled:NO];
}

@end
