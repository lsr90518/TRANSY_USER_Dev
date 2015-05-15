//
//  MDReviewWell.m
//  Distribution
//
//  Created by Lsr on 5/9/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDReviewWell.h"
#import "MDStarRatingBar.h"

@implementation MDReviewWell{
    UILabel *introTitle;
    MDStarRatingBar *starBar;
    UILabel *introText;
}

-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.layer.cornerRadius = 1;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        
        //title
        introTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 18, frame.size.width - 40, 12)];
        introTitle.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:11];
        introTitle.textColor = [UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1];
        
        [self addSubview:introTitle];
        
        //subtitle
        starBar = [[MDStarRatingBar alloc]initWithFrame:CGRectMake(frame.size.width - 100, 14, 80, 20)];
        [self addSubview:starBar];
        
        
        //text
        introText = [[UILabel alloc]initWithFrame:CGRectMake(20, 38, frame.size.width - 40, 50)];
        introText.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:11];
        introText.textColor = [UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1];
        [introText setNumberOfLines:0];
        [self addSubview:introText];
    }
    return self;
}


-(void)setDataWithTitle:(NSString *)title
                   star:(NSInteger)star
                   text:(NSString *)text{
    //intro
    introTitle.text = title;
    
    //star
    [starBar setRating:star];
    
    //text
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    introText.attributedText = attributedString;
}

@end
