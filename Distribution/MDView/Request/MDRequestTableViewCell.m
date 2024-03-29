//
//  MDRequestTableViewCell.m
//  Distribution
//
//  Created by Lsr on 4/7/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDRequestTableViewCell.h"
#import "MDRequest.h"
#import <UIImageView+WebCache.h>
#import "MDPackage.h"

@implementation MDRequestTableViewCell

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
        _statusLeft = [[UILabel alloc]initWithFrame:CGRectMake(78, 15, 200, 17)];
        _statusLeft.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:10];
        _statusLeft.textAlignment = NSTextAlignmentCenter;
        _statusLeft.layer.cornerRadius = 2.5;
        _statusLeft.layer.borderWidth = 0.5;
        _statusLeft.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        _statusLeft.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        _statusLeft.text = @"期限になってもマッチしなかったため取消";
    

    [self addSubview:_statusLeft];
    
    
    //main label
    _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(78, 42, 200, 17)];
    _statusLabel.text = @"番号: 75723 - 32493";
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
}

-(void) initCellWithData:(MDPackage *)data {
    //status
    long status = [data.status integerValue];
    
    NSString *userReviewed = [NSString stringWithFormat:@"%@", data.userReview.reviewed];
    NSString *driverReviewed = [NSString stringWithFormat:@"%@", data.driverReview.reviewed];
    
    if([userReviewed isEqualToString:@"0"] && status == 3){
        _statusLabel.text = [NSString stringWithFormat:@"評価をお願い致します。"];
        _statusLabel.textColor = [UIColor colorWithRed:226.0/255.0 green:138.0/255.0 blue:0 alpha:1];
    } else if([userReviewed isEqualToString:@"1"] && status == 3){
//        _statusLabel.text = [NSString stringWithFormat:@"評価済み"];
//        _statusLabel.textColor = [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1];
        
        if([driverReviewed isEqualToString:@"1"]){
            _statusLabel.text = [NSString stringWithFormat:@"両方評価済み"];
            _statusLabel.textColor = [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1];
        } else {
            _statusLabel.text = [NSString stringWithFormat:@"評価済み"];
            _statusLabel.textColor = [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1];
        }
        
    } else {
        //show package_number
        NSString *number = [NSString stringWithFormat:@"%@", data.package_number];
        long length = number.length/2;
        NSString *numberLeft = [number substringToIndex:length];
        NSString *numberRight = [number substringFromIndex:length];
        _statusLabel.text = [NSString stringWithFormat:@"番号: %@ - %@",numberLeft, numberRight];
        _statusLabel.textColor = [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1];
    }
    
    
    //add image
    NSString *imagePath = [NSString stringWithFormat:@"%@", data.image];
    if (![imagePath isEqualToString:@"<null>"]) {
        [_cargoImageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@"cargo"] options:SDWebImageRetryFailed];
        _cargoImageView.layer.cornerRadius = 2.5;
        _cargoImageView.layer.masksToBounds = YES;
    }
    
    switch (status) {
        case -1:
            _statusLeft.text = @"期限になってもマッチしなかったため取消";
            _statusLeft.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
            _statusLeft.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
            _statusLeft.frame = CGRectMake(_statusLeft.frame.origin.x, _statusLeft.frame.origin.y, 200 , _statusLeft.frame.size.height);
            break;
        case 0:
            _statusLeft.text = @"配送員未定";
            _statusLeft.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:0/255.0 blue:0/255.0 alpha:1].CGColor;
            _statusLeft.textColor = [UIColor colorWithRed:226.0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
            _statusLeft.frame = CGRectMake(_statusLeft.frame.origin.x, _statusLeft.frame.origin.y, 60 , _statusLeft.frame.size.height);
            break;
        case 1:
            _statusLeft.text = @"荷物を預かりにお伺い中";
            _statusLeft.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:138.0/255.0 blue:0/255.0 alpha:1].CGColor;
            _statusLeft.textColor = [UIColor colorWithRed:226.0/255.0 green:138.0/255.0 blue:0/255.0 alpha:1];
            _statusLeft.frame = CGRectMake(_statusLeft.frame.origin.x, _statusLeft.frame.origin.y, 140 , _statusLeft.frame.size.height);
            break;
        case 2:
            _statusLeft.text = @"お届け先へ配送中";
            _statusLeft.layer.borderColor = [UIColor colorWithRed:0/255.0 green:124.0/255.0 blue:226.0/255.0 alpha:1].CGColor;
            _statusLeft.textColor = [UIColor colorWithRed:0/255.0 green:124.0/255.0 blue:226.0/255.0 alpha:1];
            _statusLeft.frame = CGRectMake(_statusLeft.frame.origin.x, _statusLeft.frame.origin.y, 125 , _statusLeft.frame.size.height);
            break;
        case 3:
            _statusLeft.text = @"配達完了の報告";
            _statusLeft.layer.borderColor = [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1].CGColor;
            _statusLeft.textColor = [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1];
            _statusLeft.frame = CGRectMake(_statusLeft.frame.origin.x, _statusLeft.frame.origin.y, 88 , _statusLeft.frame.size.height);
            break;
        case 4:
            _statusLeft.text = @"期限になってもマッチしなかったため取消";
            _statusLeft.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
            _statusLeft.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
            _statusLeft.frame = CGRectMake(_statusLeft.frame.origin.x, _statusLeft.frame.origin.y, 200 , _statusLeft.frame.size.height);
            break;
        default:
            break;
    }
}

@end
