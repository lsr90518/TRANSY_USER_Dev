//
//  MDNotificationTableCell.m
//  Distribution
//
//  Created by 劉 松然 on 2015/05/20.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import "MDNotificationTableCell.h"

@implementation MDNotificationTableCell{
    UIImageView *iconImageView;
    UILabel     *contentLabel;
    UILabel     *timeLabel;
    UIView      *footerLine;
}

#pragma mark - Init
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void) initView {
    
}

-(void) setDataWithModel:(MDNotifacation *)notification{
    NSString *text = notification.message;
    
    [contentLabel removeFromSuperview];
    [iconImageView removeFromSuperview];
    [timeLabel removeFromSuperview];
    [footerLine removeFromSuperview];
    
    //content
    contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(67, 14, self.frame.size.width - 84, 60)];
    contentLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
    contentLabel.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    contentLabel.attributedText = attributedString;
    [contentLabel sizeToFit];
    [self addSubview:contentLabel];
    
//    float contentHeight = contentLabel.frame.size.height;
//    float cellHeight = contentHeight + 50;
    
    //icon
    iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 43, 43)];
    [iconImageView setImage:[UIImage imageNamed:@"cargo"]];
    iconImageView.layer.cornerRadius = 2.5;
    [self addSubview:iconImageView];
    
    
    //time
    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(contentLabel.frame.origin.x, contentLabel.frame.origin.y + contentLabel.frame.size.height + 10, contentLabel.frame.size.width, 11)];
    timeLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:10];
    
    timeLabel.text = [NSString stringWithFormat:@"%@",notification.created_time];
    timeLabel.textColor = [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1];
    [self addSubview:timeLabel];
    
    footerLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 0.5)];
    [footerLine setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1]];
    [self addSubview:footerLine];
}

@end
