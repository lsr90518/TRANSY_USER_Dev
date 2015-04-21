//
//  MDRequestTableViewCell.h
//  Distribution
//
//  Created by Lsr on 4/7/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDRequestTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *cargoImageView;
@property (strong, nonatomic) UILabel *statusLeft;
@property (strong, nonatomic) UILabel *statusRight;
@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UIImageView *rightArrow;

-(void) initCellWithData:(NSDictionary *)data;

@end
