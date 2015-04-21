//
//  MDDeliveryView.h
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDSelect.h"
#import "MDCurrentPackage.h"
#import "MDDeliveryKindButton.h"

@protocol DeliveryViewDelegate;

@interface MDDeliveryView : UIView <UIScrollViewAccessibilityDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) UIButton      *postButton;
@property (strong, nonatomic) UIScrollView  *scrollView;
@property (strong, nonatomic) UIColor       *frameColor;
@property (strong, nonatomic) MDDeliveryKindButton *packageButton;
@property (strong, nonatomic) MDDeliveryKindButton *movingButton;
@property (nonatomic, assign) id<DeliveryViewDelegate> delegate;
@property (strong, nonatomic) UIView        *tabbar;

-(void) postButtonTouched;
-(void) initViewData:(MDCurrentPackage *)package;
-(NSString*) checkInput;

@end

@protocol DeliveryViewDelegate <NSObject>

@optional
-(void) postButtonTouched;
-(void) selectButtonTouched:(MDSelect *)select;
-(void) gotoRequestAddressView;
-(void) gotoDestinationAddressView;
-(void) gotoRequestView;
-(void) gotoSettingView;

@end
