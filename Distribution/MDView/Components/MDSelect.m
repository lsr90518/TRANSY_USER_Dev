//
//  MDSelect.m
//  Distribution
//
//  Created by Lsr on 3/30/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDSelect.h"

@implementation MDSelect

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        //add frame
        self.layer.cornerRadius = 2.5;
        self.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        self.layer.borderWidth = 0.5;
        
        
        //add title
        self.buttonTitle = [[UILabel alloc]initWithFrame:CGRectMake(19, 18, 90, 14)];
        self.buttonTitle.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:14];
        [self addSubview:self.buttonTitle];
        
        //add select
        self.selectLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width-180, 19, 149, 13)];
        self.selectLabel.textAlignment = NSTextAlignmentRight;
        self.selectLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
        [self addSubview:self.selectLabel];
        
        //add right arrow
        self.rightArrow = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-22, 20, 7, 11)];
        [self.rightArrow setImage:[UIImage imageNamed:@"rightArrow"]];
        [self addSubview:self.rightArrow];
        //add options
    }
    
    return self;
}

-(void) setUnactive {
    self.selectLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
}
-(void) setReadOnly {
    [self.rightArrow setHidden:YES];
    [self setUserInteractionEnabled:NO];
    
}

@end
