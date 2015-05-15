//
//  MDProfileView.h
//  Distribution
//
//  Created by Lsr on 5/9/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//


#import "MDInput.h"
#import "MDSelect.h"
#import "MDWell.h"
#import "MDNoframeButton.h"
#import "MDDriver.h"

@protocol MDProfileViewDelegate;

@interface MDProfileView : UIView <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView  *scrollView;
@property (strong, nonatomic) MDDriver      *driver;

@property (assign, nonatomic) id<MDProfileViewDelegate> delegate;

-(void) setDriverData:(MDDriver *)driver;

@end

@protocol MDProfileViewDelegate <NSObject>

@optional
-(void)phoneButtonPushed:(MDSelect *)button;
-(void)blockButtonPushed;
-(void)reportButtonPushed;

@end
