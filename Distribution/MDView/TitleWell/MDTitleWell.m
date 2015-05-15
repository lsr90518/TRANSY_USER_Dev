//
//  MDTitleWell.m
//  DistributionDriver
//
//  Created by Lsr on 5/3/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDTitleWell.h"

@implementation MDTitleWell{
    UILabel *introTitle;
    UILabel *subTitle;
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
        subTitle = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width - 100, 18, 80, 11)];
        subTitle.textAlignment = NSTextAlignmentRight;
        subTitle.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:11];
        subTitle.textColor = [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1];
        [self addSubview:subTitle];
        
        
        //text
        introText = [[UILabel alloc]initWithFrame:CGRectMake(20, 38, frame.size.width - 40, 50)];
        introText.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:11];
        introText.textColor = [UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1];
        [introText setNumberOfLines:0];
        [self addSubview:introText];
    }
    return self;
}

-(void) setDataWithTitle:(NSString *)title subtitle:(NSString*)subtitle text:(NSString*)text{
    introTitle.text = title;
    subTitle.text = subtitle;
    
    
//    text = @"一所懸命一やっていただいてありがとうございました。";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    introText.attributedText = attributedString;
}

-(void) setDataWithTitle:(NSString *)title Text:(NSString*)text{
    introTitle.text = title;
    subTitle.text = @"";
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    introText.attributedText = attributedString;
}


@end
