//
//  MDButtonInput.m
//  Distribution
//
//  Created by Lsr on 4/25/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDButtonInput.h"

@implementation MDButtonInput

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        //border
        self.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = 1;
        
        //title
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(19, 18, 20, 14)];
        self.title.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:14];
        self.title.text = @"お題";
        [self addSubview:self.title];
        
        
        //autoInputButton
        self.button = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-93, 0, 93, frame.size.height)];
        [self.button setTitle:@"自動入力" forState:UIControlStateNormal];
        self.button.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
        [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.button addTarget:self action:@selector(buttonTouched) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.button];
        
        //input
        self.input.frame = CGRectMake(self.button.frame.origin.x-150, 19, 130, 15);
        self.input.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
        self.input.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.input];
        
    }
    
    return self;
}

-(void) buttonTouched {
    if([self.delegate respondsToSelector:@selector(buttonPushed:)]){
        [self.delegate buttonPushed:self];
    }
}

@end
