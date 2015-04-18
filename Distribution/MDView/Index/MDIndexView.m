//
//  MDIndexView.m
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDIndexView.h"

@implementation MDIndexView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        //add code
        
        //background
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:frame];
        [bgImageView setImage:[UIImage imageNamed:@"firstBG"]];
        [self addSubview:bgImageView];
        
        //title
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, frame.size.width, 30)];
        titleLabel.text = @"TRANSY";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:37];
        [self addSubview:titleLabel];
        
        //さっそく使う
        UIButton *useButton = [[UIButton alloc]initWithFrame:CGRectMake(15, frame.size.height-124, frame.size.width-30, 50)];
        [useButton setTitle:@"さっそく使う" forState:UIControlStateNormal];
        [useButton setBackgroundColor:[UIColor colorWithRed:226.0/255.0 green:138.0/255.0 blue:0 alpha:1]];
        useButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:18];
        useButton.layer.cornerRadius = 2.5;
        [useButton addTarget:self action:@selector(signButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:useButton];
        
        //ログイン
        UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake(15, frame.size.height-60, frame.size.width-30, 50)];
        [loginButton setTitle:@"ログイン" forState:UIControlStateNormal];
        [loginButton setBackgroundColor:[UIColor whiteColor]];
        loginButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:18];
        [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        loginButton.layer.cornerRadius = 2.5;
        [loginButton addTarget:self action:@selector(loginButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:loginButton];
    }
    
    return self;
}

-(void)signButtonTouched {
    if([self.delegate respondsToSelector:@selector(signTouched)]){
        [self.delegate signTouched];
    }
}

-(void)loginButtonTouched {
    if([self.delegate respondsToSelector:@selector(loginTouched)]){
        [self.delegate loginTouched];
    }
    
}

@end
