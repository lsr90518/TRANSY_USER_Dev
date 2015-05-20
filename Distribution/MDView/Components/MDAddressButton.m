//
//  MDAddressButton.m
//  Distribution
//
//  Created by 劉 松然 on 2015/05/20.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import "MDAddressButton.h"

@implementation MDAddressButton

-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        //line
        _titleContentLine = [[UIView alloc]initWithFrame:CGRectMake(95, 0, 0.5, frame.size.height)];
        [_titleContentLine setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1]];
        [self addSubview:_titleContentLine];
        
        //button title
        _buttonTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 42, 56, 15)];
        _buttonTitleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:14];
        [self addSubview:_buttonTitleLabel];
        
        //content
        _zipField = [[UILabel alloc]initWithFrame:CGRectMake(_titleContentLine.frame.origin.x
                                                                 + 20, 20, frame.size.width - _titleContentLine.frame.origin.x - 55, 15)];
        _zipField.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
        [self addSubview:_zipField];
        
        //content
        _addressField = [[UILabel alloc]initWithFrame:CGRectMake(_zipField.frame.origin.x, _zipField.frame.origin.y + _zipField.frame.size.height + 7, _zipField.frame.size.width, 40)];
        _addressField.font = [UIFont fontWithName:@"HirakakuProN-W3" size:14];
        _addressField.numberOfLines = 0;
        [self addSubview:_addressField];
        
        //right arrow
        _rightArrow = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-22, frame.size.height/2 - 5, 7, 11)];
        [_rightArrow setImage:[UIImage imageNamed:@"rightArrow"]];
        [self addSubview:self.rightArrow];
    }
    return self;
}

-(void) setAddressContent:(NSString *)text {
    CGFloat customLineHeight = 8;
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrahStyle setLineSpacing:customLineHeight];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedText addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, attributedText.length)];
    _addressField.attributedText = attributedText;
    //resize
    [self resize];
}

-(void) resize {
    float contentHeight = _addressField.frame.size.height + _zipField.frame.size.height + 7;
    float newHeight = contentHeight + 47;
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newHeight)];
    [_titleContentLine setFrame:CGRectMake(95, 0, 0.5, newHeight)];
    [_buttonTitleLabel setFrame:CGRectMake(20, newHeight/2-7, 56, 15)];
    [_rightArrow setFrame:CGRectMake(self.frame.size.width-22, newHeight/2 - 5, 7, 11)];
}

@end
