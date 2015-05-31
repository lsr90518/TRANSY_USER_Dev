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

-(void) setKeyboardToolbar;     // initWithFrame内でsetされる
-(void) disableKeyboardToolbar; // 必要ない場合はこれを呼ぶ

@end

@protocol MDInputDelegate <NSObject>

@optional
-(void) inputPushed:(MDInput *)input;
-(void) endInput:(MDInput *)input;
-(void) returnKeyPushed:(MDInput *)input;
-(void) buttonPushed:(MDInput *)view;

@end
