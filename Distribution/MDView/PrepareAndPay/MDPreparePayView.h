//
//  MDPreparePayView.h
//  Distribution
//
//  Created by Lsr on 3/31/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDSelect.h"
#import "MDUtil.h"

@protocol PreparePayViewDelegate;

@interface MDPreparePayView : UIView<UIScrollViewAccessibilityDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIButton *postButton;
@property (strong, nonatomic) UIButton *backButton;


@property (nonatomic, assign) id<PreparePayViewDelegate> delegate;

-(void) backButtonPushed;
-(void) initPackageNumber:(NSString *)packageNumber;
-(void) setBoxImage:(UIImage *)image;
-(void) updateData;
-(BOOL) isChecked;
-(UIImageView *) getUploadedImage;

@end

@protocol PreparePayViewDelegate <NSObject>

@optional
-(void) backButtonPushed;
-(void) cameraButtonTouched;
-(void) postData;
-(void) requestPersonPushed;
-(void) paymentButtonPushed;
-(void) showCardIO;
-(void) phoneNumberPushed;
-(void) updateImagePushed;

@end
