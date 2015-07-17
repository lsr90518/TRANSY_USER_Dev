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
#import "MDSelectRating.h"

@protocol MDSettingViewDelegate;

@interface MDSettingView : UIView <UIScrollViewAccessibilityDelegate, UIScrollViewDelegate, MDCreditViewDelegate>

@property (strong, nonatomic) UIScrollView  *scrollView;
@property (nonatomic, assign) id<MDSettingViewDelegate> delegate;
@property (strong, nonatomic) MDSelect *pay;

-(void) setViewData:(MDUser *)data;
-(void) setRating:(int)star;
-(void) setNotificationCount:(int)count;

@end

@protocol MDSettingViewDelegate <NSObject>

@optional
-(void) notificationButtonPushed;
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
-(void) logoutButtonPushed;
-(void) averageButtonPushed;
-(void) privateButtonPushed;
-(void) protocolButtonPushed;

@end
