//
//  MDStarRatingBar.h
//  DistributionDriver
//
//  Created by 劉 松然 on 2015/05/08.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDStarRatingBar : UIControl


@property (nonatomic) NSUInteger rating;
@property (nonatomic,strong) NSMutableArray *stars;

@property (nonatomic,copy) void (^ratingChangedBlock)(NSUInteger rating);

-(id)initWithFrame:(CGRect)frame;
-(id)initWithFrame:(CGRect)frame starCount:(NSUInteger)count;
-(void)initWithStarCount:(NSUInteger)count;
-(BOOL)touch:(UITouch*)touch inStar:(UIImageView*)star;
-(id)initWithFrame:(CGRect)frame starSize:(float)starSize;
-(void)setRating:(NSUInteger)rating;

@end
