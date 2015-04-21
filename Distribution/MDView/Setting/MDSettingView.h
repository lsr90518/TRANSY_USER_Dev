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

@protocol MDSettingViewDelegate;

@interface MDSettingView : UIView <UIScrollViewAccessibilityDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView  *scrollView;
@property (strong, nonatomic) UIView        *tabbar;

@property (nonatomic, assign) id<MDSettingViewDelegate> delegate;

@end

@protocol MDSettingViewDelegate <NSObject>

@optional
-(void) nameButtonPushed;
-(void) phoneNumberPushed;
-(void) blockDriverPushed;
-(void) aqButtonPushed;
-(void) privacyButtonPushed;
-(void) agreementButtonPushed;
-(void) gotoRequestView;
-(void) gotoDeliveryView;

@end
