//
//  MDReviewHistoryCell.h
//  Distribution
//
//  Created by Lsr on 5/17/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDPackage.h"
#import "MDStarRatingBar.h"

@interface MDReviewHistoryCell : UITableViewCell

@property (strong, nonatomic) UIImageView       *cargoImageView;
@property (strong, nonatomic) UILabel           *statusLeft;
@property (strong, nonatomic) MDStarRatingBar   *starLabel;
@property (strong, nonatomic) UILabel           *statusLabel;
@property (strong, nonatomic) UIImageView       *rightArrow;

-(void) setDataWithPackage:(MDPackage *)package;

@end
