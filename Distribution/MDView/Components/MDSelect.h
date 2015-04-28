//
//  MDSelect.h
//  Distribution
//
//  Created by Lsr on 3/30/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MDSelectDelegate;

@interface MDSelect : UIButton

@property (strong, nonatomic) UILabel       *buttonTitle;
@property (strong, nonatomic) UILabel       *selectLabel;
@property (strong, nonatomic) UIImageView   *rightArrow;
@property (strong, nonatomic) NSArray       *options;
@property (nonatomic, assign) id<MDSelectDelegate> delegate;

-(void) setUnactive;
-(void) setActive;
-(void) setReadOnly;

@end


@protocol MDSelectDelegate <NSObject>

@optional

-(void) buttonPushed:(MDSelect *)view;

@end