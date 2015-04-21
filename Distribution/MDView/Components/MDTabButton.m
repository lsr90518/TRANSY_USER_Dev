//
//  MDTabButton.m
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDTabButton.h"
#import "MDDevice.h"

@implementation MDTabButton
{
    // ButtonImage
    UIImage *_normalImage;
    UIImage *_selectedImage;
    UILabel *title;
    CGRect  buttonFrame;
}

#pragma mark - Init
- (id)initWithFrame:(CGRect)frame withTabType:(TAB_TYPE)type
{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        buttonFrame = frame;
        [self initButton];
    }
    return self;
}

- (void)initButton
{
    //title
    title = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, buttonFrame.size.width, 8)];
    title.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:8];
    title.textAlignment = NSTextAlignmentCenter;
    switch (_type) {
        case TAB_REQUEST:
            _normalImage   = [UIImage imageNamed:@"request_tab_unactive@2x"];
            _selectedImage = [UIImage imageNamed:@"request_tab_active@2x"];
            title.text = @"引き受け依頼";
            break;
        case TAB_DELIVERY:
            _normalImage   = [UIImage imageNamed:@"delivery_tab_unactive@2x"];
            _selectedImage = [UIImage imageNamed:@"delivery_tab_active@2x"];
            title.text = @"配送の依頼";
            break;
        case TAB_SETTING:
            _normalImage   = [UIImage imageNamed:@"setting_tab_unactive@2x"];
            _selectedImage = [UIImage imageNamed:@"setting_tab_active@2x"];
            title.text = @"設定";
            break;
        default:
            break;
    }
    //判断ios7
    
    int x = 1;
    if ([[MDDevice getInstance].iosVersion isEqualToString:@"7"]) {
        x = 2;
    }
    _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(buttonFrame.size.width/2 - _normalImage.size.width/(2*x),
                                                                  buttonFrame.size.height/2 - _normalImage.size.height/(2*x)-6,
                                                                  _normalImage.size.width/(1*x),
                                                                  _normalImage.size.height/(1*x))];
    [self addSubview:_iconImageView];
    [self addSubview:title];
    
//    [self setImage:_normalImage   forState:UIControlStateNormal];
//    [self setImage:_selectedImage forState:UIControlStateHighlighted];
    title.textColor = [UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1];
    [self setBackgroundColor:[UIColor whiteColor]];
}

- (void)setButtonImage:(BOOL)selected
{
    if (selected) {
        [_iconImageView setImage:_selectedImage];
        [self setBackgroundColor:[UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1]];
        title.textColor = [UIColor whiteColor];
    } else {
        [_iconImageView setImage:_normalImage];
        [self setBackgroundColor:[UIColor whiteColor]];
        title.textColor = [UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1];
    }
}


@end
