//
//  MDWell.m
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDWell.h"

@implementation MDWell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView:frame];
    }
    return self;
}

-(void) initView:(CGRect)frame
{
    _themeColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
    _contentColor = [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1];
    [self setBackgroundColor:_themeColor];
    
    _content = [[UILabel alloc]initWithFrame:CGRectMake(14, 6.5, frame.size.width-28, frame.size.height-13)];
    _content.font = [UIFont fontWithName:@"HiraKakuProN-w3" size:11];
    _content.textColor = _contentColor;
    _contentText = @"入力が終われば、画面右上から「次へ」を選んで頂き、送られてくるSMSに記載してある5桁の数字を記入してください。";
    CGFloat customLineHeight = 8;
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrahStyle setLineSpacing:customLineHeight];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:_contentText];
    [attributedText addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, attributedText.length)];
    _content.attributedText = attributedText;
    _content.numberOfLines = 3;
    [self addSubview:_content];
    
}

-(void) setContentText:(NSString *)contentText {
    CGFloat customLineHeight = 8;
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrahStyle setLineSpacing:customLineHeight];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:contentText];
    [attributedText addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, attributedText.length)];
    _content.attributedText = attributedText;
    _content.numberOfLines = 3;

}

@end
