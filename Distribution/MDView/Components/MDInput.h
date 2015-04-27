//
//  MDInput.h
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MDInputDelegate;

@interface MDInput : UIView<UITextFieldDelegate>

@property (strong, nonatomic) UILabel       *title;
@property (strong, nonatomic) UITextField   *input;

@property (nonatomic, assign) id<MDInputDelegate> delegate;

@end

@protocol MDInputDelegate <NSObject>

@optional
-(void) inputPushed:(MDInput *)input;
-(void) endInput:(MDInput *)input;

@end
