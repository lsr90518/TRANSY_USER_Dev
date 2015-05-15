//
//  MDCreateProfileView.h
//  Distribution
//
//  Created by Lsr on 4/12/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDUtil.h"
#import "MDInput.h"
#import "MDSelect.h"
#import "MDCreditView.h"

@protocol CreateProfileViewDelegate;

@interface MDCreateProfileView : UIView<UIScrollViewAccessibilityDelegate,UIScrollViewDelegate,MDCreditViewDelegate>

@property (strong, nonatomic) UIScrollView  *scrollView;
@property (strong, nonatomic) MDInput       *lastnameInput;
@property (strong, nonatomic) MDInput       *givennameInput;
@property (strong, nonatomic) MDCreditView  *creditView;
@property (strong, nonatomic) MDSelect      *creditButton;
@property (strong, nonatomic) UIButton      *creditAutoCompletionButton;
@property (strong, nonatomic) MDInput       *passwordInput;
@property (strong, nonatomic) MDInput       *repeatInput;

@property (strong, nonatomic) UIButton      *postButton;

@property (assign, nonatomic) id<CreateProfileViewDelegate> delegate;

@end

@protocol CreateProfileViewDelegate <NSObject>

@optional
-(void) postData:(MDCreateProfileView *)createProfileView;
-(void) scrollDidMove:(MDCreateProfileView *)createProfileView;
-(void) showCreditView;
-(void) showCardIO;
@end