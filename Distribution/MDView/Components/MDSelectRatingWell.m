//
//  MDSelectRatingWell.m
//  Distribution
//
//  Created by 劉 松然 on 2015/05/20.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import "MDSelectRatingWell.h"

@implementation MDSelectRatingWell

-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _selectRating = [[MDSelectRating alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];

        _selectRating.buttonTitle.text = @"ドライバーの評価";
        [_selectRating.buttonTitle sizeToFit];
        [_selectRating.starLabel setRating:5];
        _selectRating.userInteractionEnabled = NO;
        [_selectRating.rightArrow setHidden:YES];
        [_selectRating addTarget:self action:@selector(selectButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_selectRating];
        
        
        //well
        _content = [[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x + 20, _selectRating.frame.origin.y+_selectRating.frame.size.height + 15, frame.size.width - 40, 70)];
        _content.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:11];
        _content.textColor = [UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1];
        _content.numberOfLines = 0;
        [self addSubview:_content];
        
        
        self.layer.cornerRadius = 2.0;
        self.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        self.layer.borderWidth = 0.5;
        
    }
    return self;
}

-(void) setContentText:(NSString *)text{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    _content.attributedText = attributedString;
    [_content sizeToFit];

    [self resize];
}

-(void) resize{
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _content.frame.size.height + 80)];
}

-(void) selectButtonTouched {
    if([self.delegate respondsToSelector:@selector(selectPushed:)]){
        [self.delegate selectPushed:self];
    }
}

@end
