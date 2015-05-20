//
//  MDAddressButton.h
//  Distribution
//
//  Created by 劉 松然 on 2015/05/20.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDAddressButton : UIButton

@property (strong, nonatomic) UILabel       *buttonTitleLabel;
@property (strong, nonatomic) UIView        *titleContentLine;
@property (strong, nonatomic) UILabel   *zipField;
@property (strong, nonatomic) UILabel   *addressField;
@property (strong, nonatomic) UIImageView   *rightArrow;

-(void) setAddressContent:(NSString *)text;

@end
