//
//  MDSelectRating.m
//  Distribution
//
//  Created by Lsr on 5/17/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDSelectRating.h"

@implementation MDSelectRating

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //add frame
        self.layer.cornerRadius = 2.0;
        self.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        self.layer.borderWidth = 0.5;
        
        
        //add title
        self.buttonTitle = [[UILabel alloc]initWithFrame:CGRectMake(19, 17, 90, 17)];
        self.buttonTitle.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:14];
        [self addSubview:self.buttonTitle];
        
        //add select
        self.starLabel = [[MDStarRatingBar alloc]initWithFrame:CGRectMake(frame.size.width-150, 9, 130, 32)];
        [self addSubview:self.starLabel];
        
        //add right arrow
        self.rightArrow = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-22, 20, 7, 11)];
        [self.rightArrow setImage:[UIImage imageNamed:@"rightArrow"]];
        [self addSubview:self.rightArrow];
        //add options
    }
    
    return self;
}

-(void) setReadOnly {
    [self.starLabel setUserInteractionEnabled:NO];
}

-(void) setNoArrow{
    [self.starLabel setUserInteractionEnabled:NO];
    [self.starLabel setFrame:CGRectMake(self.frame.size.width - 140, 9, 130, 32)];
}

@end
