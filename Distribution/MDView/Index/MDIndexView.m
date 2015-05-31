//
//  MDIndexView.m
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDIndexView.h"
#import "MDWell.h"

@implementation MDIndexView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        //add code
        
        //background
//        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:frame];
//        [bgImageView setImage:[UIImage imageNamed:@"firstBG"]];
//        [self addSubview:bgImageView];
        
        //title
//        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, frame.size.width, 30)];
//        titleLabel.text = @"TRANSY";
//        titleLabel.textAlignment = NSTextAlignmentCenter;
//        titleLabel.textColor = [UIColor whiteColor];
//        titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:37];
//        [self addSubview:titleLabel];
        
        
        MDWell *descriptionWell = [[MDWell alloc]initWithFrame:CGRectMake(15, self.frame.size.height - 234, frame.size.width - 30, 106)];
        [descriptionWell setContentText:@"『TRUX(トラックス)』は、6月から東京都 23区 限定で開始しました。現在はそれ以外の地域の荷物を依頼・配送することができませんので、あらかじめご了承ください。"];
        [descriptionWell.content sizeToFit];
        descriptionWell.layer.cornerRadius = 2.5;
        descriptionWell.content.textColor = [UIColor whiteColor];
        [descriptionWell setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
        
        [descriptionWell setFrame:CGRectMake(15, frame.size.height - descriptionWell.content.frame.size.height - 154, frame.size.width - 30, descriptionWell.content.frame.size.height + 20)];
        
        [self addSubview:descriptionWell];
        
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
        
        UIView *logoView = [[UIView alloc]initWithFrame:CGRectMake(0, (frame.size.height - descriptionWell.frame.origin.y)/2, frame.size.width, 90)];
        
        UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 10)];
        topLabel.textAlignment = NSTextAlignmentCenter;
        topLabel.text = @"荷物を運びたい、そんな時、トラックス";
        topLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:10];
        topLabel.textColor = [UIColor whiteColor];
        [logoView addSubview:topLabel];
        
        UILabel *bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, logoView.frame.size.height-9, logoView.frame.size.width, 15)];
        bottomLabel.textAlignment = NSTextAlignmentCenter;
        bottomLabel.text = @"BREAK OUT TOKYO";
        bottomLabel.textColor = [UIColor whiteColor];
        bottomLabel.font = [UIFont fontWithName:@"Gulim" size:4];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:bottomLabel.text];
        
        float spacing = 4.0f;
//        [attributedString addAttribute:NSKernAttributeName
//                                 value:@(spacing)
//                                 range:NSMakeRange(0, [bottomLabel.text length])];
        
        bottomLabel.attributedText = attributedString;
        
        [logoView addSubview:bottomLabel];
        [self addSubview:logoView];
        
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
