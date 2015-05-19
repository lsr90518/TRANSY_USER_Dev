//
//  MDLoginView.h
//  Distribution
//
//  Created by Lsr on 4/12/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDInput.h"
#import "MDUtil.h"
#import "MDUser.h"

@protocol LoginViewDelegate;

@interface MDLoginView : UIView

@property (strong, nonatomic) MDInput *phoneInput;
@property (strong, nonatomic) MDInput *passwordInput;

@property (nonatomic, assign) id<LoginViewDelegate> delegate;

-(void) setLoginData:(MDUser *)user;

@end

@protocol LoginViewDelegate <NSObject>

@optional
-(void) postData:(MDLoginView *)loginView;

@end