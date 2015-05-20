//
//  MDSelectRatingWell.h
//  Distribution
//
//  Created by 劉 松然 on 2015/05/20.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import "MDSelectRating.h"
#import "MDWell.h"

@protocol MDSelectRatingWellDelegate;

@interface MDSelectRatingWell : UIView

@property (strong, nonatomic) MDSelectRating    *selectRating;
@property (strong, nonatomic) UILabel           *content;

@property (assign, nonatomic) id<MDSelectRatingWellDelegate> delegate;

-(void) setContentText:(NSString *)text;

@end


@protocol MDSelectRatingWellDelegate <NSObject>

@optional
-(void) selectPushed:(MDSelectRatingWell *)selectRatingWell;

@end