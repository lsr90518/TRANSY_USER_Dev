//
//  MDSettingView.h
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDSelect.h"
#import "MDTabButton.h"
#import "MDUtil.h"
#import "MDUser.h"
#import "MDCreditView.h"

@protocol MDSettingViewDelegate;

@interface MDSettingView : UIView <UIScrollViewAccessibilityDelegate, UIScrollViewDelegate, MDCreditViewDelegate>

@property (strong, nonatomic) UIScrollView  *scrollView;
@property (strong, nonatomic) UIView        *tabbar;

@property (nonatomic, assign) id<MDSettingViewDelegate> delegate;

-(void) setViewData:(MDUser *)data;

@end

@protocol MDSettingViewDelegate <NSObject>

@optional
-(void) nameButtonPushed;
-(void) phoneNumberPushed;
-(void) paymentButtonPushed;
-(void) showCardIO;
-(void) blockDriverPushed;
-(void) aqButtonPushed;
-(void) privacyButtonPushed;
-(void) agreementButtonPushed;
-(void) gotoRequestView;
-(void) gotoDeliveryView;
@end
