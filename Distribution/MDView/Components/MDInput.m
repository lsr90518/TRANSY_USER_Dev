//
//  MDInput.m
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDInput.h"

@implementation MDInput

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        //border
        self.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = 2.5;
        
        //title
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(19, 18, 20, 14)];
        self.title.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:14];
        self.title.text = @"お題";
        [self addSubview:self.title];
        
        
        //input
        self.input = [[UITextField alloc]initWithFrame:CGRectMake(frame.size.width-150, 19, 130, 15)];
        self.input.placeholder = @"090XXXXXXXX";
        self.input.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
        self.input.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.input];
        
    }
    
    return self;
}

@end
