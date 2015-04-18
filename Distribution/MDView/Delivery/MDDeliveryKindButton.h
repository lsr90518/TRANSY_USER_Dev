//
//  MDDeliveryKindButton.h
//  Distribution
//
//  Created by Lsr on 3/29/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDDeliveryKindButton : UIButton

@property (strong, nonatomic) UIImageView   *iconImageView;
@property (strong, nonatomic) UILabel       *buttonTitle;
@property (strong, nonatomic) UIColor       *activeColor;
@property (strong, nonatomic) UIColor       *normalColor;

-(void) setActive;
-(void) setIconImage:(UIImage *)image;
-(void) setUnactive;

@end
