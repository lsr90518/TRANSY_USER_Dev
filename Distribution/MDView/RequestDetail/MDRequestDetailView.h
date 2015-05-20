//
//  MDRequestDetailView.h
//  Distribution
//
//  Created by Lsr on 4/19/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDPackage.h"
#import "MDDriver.h"
#import "MDAddressButton.h"
#import "MDReviewWell.h"

@protocol MDRequestDetailViewDelegate;

@interface MDRequestDetailView : UIView<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView  *scrollView;
@property (strong, nonatomic) NSString      *process;
@property (strong, nonatomic) id<MDRequestDetailViewDelegate> delegate;
@property (strong, nonatomic) MDPackage     *package;
@property (strong, nonatomic) MDDriver      *driver;

-(void) setStatus:(int) status;
-(void) makeupByData:(MDPackage *)package;
-(void) setDriverData:(MDDriver *)driver;
-(UIImageView *) getUploadedImage;

-(void) setReviewContent:(MDReview *)review;


@end

@protocol MDRequestDetailViewDelegate <NSObject>

@optional
-(void) cameraButtonTouched;
-(void) reviewButtonPushed;
-(void) profileButtonPushed;
-(void) sizeDescriptionButtonPushed;
-(void) matchButtonPushed;
-(void) cancelButtonPushed;
-(void) addressButtonPushed:(MDAddressButton *)button;

@end