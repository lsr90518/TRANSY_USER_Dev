//
//  MDReviewHistoryCell.m
//  Distribution
//
//  Created by Lsr on 5/17/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDReviewHistoryCell.h"
#import <UIImageView+WebCache.h>

@implementation MDReviewHistoryCell{
    
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
    //image icon
    _cargoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 54, 54)];
    [_cargoImageView setImage:[UIImage imageNamed:@"cargo"]];
    _cargoImageView.layer.cornerRadius = 2.5;
    [self addSubview:_cargoImageView];
    
    
    //status label 期限になってもマッチしなかったため取消
    _statusLeft = [[UILabel alloc]initWithFrame:CGRectMake(78, 15, 88, 17)];
    _statusLeft.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:10];
    _statusLeft.textAlignment = NSTextAlignmentCenter;
    _statusLeft.layer.cornerRadius = 2.5;
    _statusLeft.layer.borderWidth = 0.5;
    _statusLeft.layer.borderColor = [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1].CGColor;
    _statusLeft.textColor = [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1];
    _statusLeft.text = @"配達完了の報告";
    [self addSubview:_statusLeft];
    
    //rating bar
    _starLabel = [[MDStarRatingBar alloc]initWithFrame:CGRectMake(self.frame.size.width -150, 10, 100, 25)];
    [_starLabel setUserInteractionEnabled:NO];
    [self addSubview:_starLabel];
    
    //main label
    _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(78, 42, 200, 17)];
    _statusLabel.text = @"評価済み";
    _statusLabel.textColor = [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1];
    _statusLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:17];
    [self addSubview:_statusLabel];
    
    //right arrow
    _rightArrow = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-20, 30, 9, 15)];
    [_rightArrow setImage:[UIImage imageNamed:@"grayRightArrow"]];
    [self addSubview:_rightArrow];
    
    //footer
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 73, [UIScreen mainScreen].bounds.size.width, 0.5)];
    [footer setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1]];
    [self addSubview:footer];
    
//    previewWell = [[MDReviewWell alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 100)];
//    [previewWell setBackgroundColor:[UIColor whiteColor]];
//    [self addSubview:previewWell];
}

-(void) setDataWithPackage:(MDPackage *)package{
    [_starLabel setRating:[package.driverReview.star intValue]];
    [_cargoImageView sd_setImageWithURL:[NSURL URLWithString:package.image] placeholderImage:[UIImage imageNamed:@"cargo"] options:SDWebImageRetryFailed];
}

@end
