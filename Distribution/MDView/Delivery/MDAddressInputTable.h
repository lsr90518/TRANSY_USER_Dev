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
#import "MDButtonInput.h"
#import "MDInput.h"

@interface MDAddressInputTable : UIView<UIScrollViewDelegate,UITextFieldDelegate,MDInputDelegate>

@property (strong, nonatomic) MDButtonInput   *zipField;
@property (strong, nonatomic) MDInput   *metropolitanField;
@property (strong, nonatomic) MDInput   *cityField;
@property (strong, nonatomic) MDInput   *townField;
@property (strong, nonatomic) MDInput   *houseField;
@property (strong, nonatomic) MDInput   *buildingNameField;
@property (strong, nonatomic) UIView        *rzaLine;
@property (strong, nonatomic) NSString      *lng;
@property (strong, nonatomic) NSString      *lat;

@property (strong, nonatomic) UIScrollView  *scrollView;

-(void)setFrameColor:(UIColor *)color;
-(void)clearData;

-(void) setUnAvailable;
@end
