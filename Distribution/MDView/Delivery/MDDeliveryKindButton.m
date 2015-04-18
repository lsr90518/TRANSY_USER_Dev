//
//  MDDeliveryKindButton.m
//  Distribution
//
//  Created by Lsr on 3/29/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDDeliveryKindButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation MDDeliveryKindButton {
    CGRect buttonFrame;

}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //make button
        buttonFrame = frame;
        [self setBackgroundColor:[UIColor whiteColor]];
        //color
        self.activeColor = [UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1];
        self.normalColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        //frame
        self.buttonTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height/2+16.5, frame.size.width, 12)];
        self.buttonTitle.textAlignment = NSTextAlignmentCenter;
        self.buttonTitle.text = @"小包";
        self.buttonTitle.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:12];
        self.buttonTitle.textColor = self.normalColor;

//        [self setIconImage:[UIImage imageNamed:@"packageIcon"]];
        
        
        [self addSubview:self.buttonTitle];
        
//        UIImage *iconImage = [UIImage imageNamed:@"packageIcon"];
//        UILabel
        
        //title
    }
    
    return self;
}

-(void) setIconImage:(UIImage *)image {
    if (!self.iconImageView){
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width/2, image.size.height/2)];
    }
    
    self.iconImageView.center = CGPointMake(buttonFrame.size.width/2, buttonFrame.size.height/2-14);
    [self.iconImageView setImage:image];
    [self addSubview:self.iconImageView];
}

-(void) setActive {
    if([self.buttonTitle.text isEqualToString:@"小包"]) {
        [self setIconImage:[UIImage imageNamed:@"packageIcon"]];
    } else {
        [self setIconImage:[UIImage imageNamed:@"movingIconOn"]];
    }
    self.buttonTitle.textColor = self.activeColor;
}
-(void) setUnactive {
    if([self.buttonTitle.text isEqualToString:@"小包"]) {
        [self setIconImage:[UIImage imageNamed:@"packageIconOff"]];
    } else {
        [self setIconImage:[UIImage imageNamed:@"movingIcon"]];
    }
    self.buttonTitle.textColor = self.normalColor;
}

@end
