//
//  MDReviewView.h
//  DistributionDriver
//
//  Created by 劉 松然 on 2015/05/08.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDStarRatingBar.h"
#import "MDPackage.h"
#import "MDReview.h"
#import "MDDriver.h"
#import "MDPackage.h"
#import "MDSelect.h"

@protocol MDReviewDelegate;

@interface MDReviewView : UIView<UIScrollViewDelegate,UITextViewDelegate>

@property (assign ,nonatomic) id<MDReviewDelegate> delegate;
@property (strong, nonatomic) MDReview      *review;
@property (strong, nonatomic) MDDriver      *driver;
@property (strong, nonatomic) MDPackage     *package;


-(void) initWithPackage:(MDPackage *)package
                 driver:(MDDriver *)driver;
-(void) closeKeyBoard;

@end

@protocol MDReviewDelegate <NSObject>

@optional
-(void) postButtonPushed;
-(void) phoneButtonPushed:(MDSelect *)button;

@end
