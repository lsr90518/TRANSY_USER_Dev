//
//  MDSelect.h
//  Distribution
//
//  Created by Lsr on 3/30/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDSelect : UIButton

@property (strong, nonatomic) UILabel       *buttonTitle;
@property (strong, nonatomic) UILabel       *selectLabel;
@property (strong, nonatomic) UIImageView   *rightArrow;
@property (strong, nonatomic) NSArray       *options;

-(void) setUnactive;
-(void) setReadOnly;

@end
