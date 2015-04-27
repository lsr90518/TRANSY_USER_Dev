//
//  MDButtonInput.h
//  Distribution
//
//  Created by Lsr on 4/25/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDInput.h"

@protocol MDButtonInputDelegate;

@interface MDButtonInput : MDInput

@property (strong, nonatomic) UIButton      *button;

@property (nonatomic, assign) id<MDButtonInputDelegate> delegate;

@end

@protocol MDButtonInputDelegate <NSObject>

@optional
-(void) buttonPushed:(MDButtonInput *)view;

@end