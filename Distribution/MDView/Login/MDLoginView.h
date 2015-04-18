//
//  MDLoginView.h
//  Distribution
//
//  Created by Lsr on 4/12/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDInput.h"

@protocol LoginViewDelegate;

@interface MDLoginView : UIView

@property (strong, nonatomic) MDInput *phoneInput;
@property (strong, nonatomic) MDInput *passwordInput;

@property (nonatomic, assign) id<LoginViewDelegate> delegate;

@end

@protocol LoginViewDelegate <NSObject>

@optional
-(void) postData:(MDLoginView *)loginView;

@end