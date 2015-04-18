//
//  MDCheckBox.m
//  Distribution
//
//  Created by Lsr on 4/3/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDCheckBox.h"

@implementation MDCheckBox

-(id) init {
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 2.5;
        self.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        self.layer.borderWidth = 0.5;
        
        self.checkImage = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 30, 30)];
        [self addSubview:self.checkImage];
    }
    return self;
}

@end
