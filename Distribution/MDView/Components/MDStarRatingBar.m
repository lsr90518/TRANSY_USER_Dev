//
//  MDStarRatingBar.m
//  DistributionDriver
//
//  Created by 劉 松然 on 2015/05/08.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import "MDStarRatingBar.h"
const NSUInteger DEFAULT_STAR_COUNT = 5;

@implementation MDStarRatingBar{
    UIView *starBackView;
}


-(void)setRating:(NSUInteger)rating
{
    _rating = rating;
    [self.stars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [obj setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    }];
    
    [self.stars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if(idx < rating){
            [obj setImage:[UIImage imageNamed:@"star_highlight"] forState:UIControlStateNormal];
        }
    }];
}

-(void)initWithStarCount:(NSUInteger)count
{
    starBackView = [[UIView alloc]initWithFrame:CGRectMake(0.06*self.frame.size.width,
                                                           0.05*self.frame.size.width,
                                                           self.frame.size.width - self.frame.size.width*0.12,
                                                           self.frame.size.height - 0.1*self.frame.size.width)];
    
    float intervalWidth = (starBackView.frame.size.width - count * starBackView.frame.size.height)/(count - 1);
    self.stars = [NSMutableArray array];
    for (NSUInteger idx = 0; idx < count; ++idx) {
        UIButton *star = [[UIButton alloc]initWithFrame:CGRectMake(idx * (intervalWidth + starBackView.frame.size.height), 0, starBackView.frame.size.height, starBackView.frame.size.height)];
        [star setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        [star addTarget:self action:@selector(starTouched:) forControlEvents:UIControlEventTouchUpInside];
        [starBackView addSubview:star];
        [self.stars addObject:star];
    }
    
    [self addSubview:starBackView];
}

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initWithStarCount:DEFAULT_STAR_COUNT];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        if(self.tag <= 0)
        {
            [self initWithStarCount:DEFAULT_STAR_COUNT];
        }else{
            [self initWithStarCount:self.tag];
        }
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame starCount:(NSUInteger)count
{
    if (self = [super initWithFrame:frame]) {
        [self initWithStarCount:count];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame
          starSize:(float)starSize{
    starBackView = [[UIView alloc]initWithFrame:CGRectMake(0.06*frame.size.width,
                                                           0.05*frame.size.width,
                                                           frame.size.width - frame.size.width*0.12,
                                                           frame.size.height/2)];
    
    float intervalWidth = (starBackView.frame.size.width - DEFAULT_STAR_COUNT * starBackView.frame.size.height)/(DEFAULT_STAR_COUNT - 1);
    self.stars = [NSMutableArray array];
    for (NSUInteger idx = 0; idx < DEFAULT_STAR_COUNT; ++idx) {
        UIButton *star = [[UIButton alloc]initWithFrame:CGRectMake(idx * (intervalWidth + starBackView.frame.size.height), 0, starBackView.frame.size.height, starBackView.frame.size.height)];
        [star setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        [star addTarget:self action:@selector(starTouched:) forControlEvents:UIControlEventTouchUpInside];
        [starBackView addSubview:star];
        [self.stars addObject:star];
    }
    
    [self addSubview:starBackView];
    return self;
}


-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"abab");
    __block MDStarRatingBar *blockSelf = self;
    [self.stars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([blockSelf touch:touch inStar:obj]) {
            self.rating = idx + 1;
            *stop = YES;
        }
    }];
    return YES;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"abab1");
    __block MDStarRatingBar *blockSelf = self;
    [self.stars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([blockSelf touch:touch inStar:obj]) {
            self.rating = idx + 1;
            *stop = YES;
        }
    }];
    return YES;
}

#pragma mark - Private Method
-(BOOL)touch:(UITouch *)touch inStar:(UIImageView *)star
{
    NSLog(@"abab2");
    
    CGPoint pt = [touch locationInView:self];
    return CGRectContainsPoint(star.frame, pt);
}

-(void) starTouched:(UIButton *)button{
    _rating =[self.stars indexOfObject:button]+1;
    [self setRating:_rating];
}

@end
