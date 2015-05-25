//
//  MDSelectRating.h
//  Distribution
//
//  Created by Lsr on 5/17/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDStarRatingBar.h"

@protocol  MDSelectRatingDelegate;

@interface MDSelectRating : UIButton

@property (strong, nonatomic) UILabel           *buttonTitle;
@property (strong, nonatomic) MDStarRatingBar   *starLabel;
@property (strong, nonatomic) UIImageView       *rightArrow;

@property (strong, nonatomic) id<MDSelectRatingDelegate> delegate;

-(void) setReadOnly;
-(void) setNoArrow;


@end

@protocol MDSelectRatingDelegate <NSObject>

@optional

@end