//
//  MDLoginViewController.h
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDLoginView.h"
#import <Realm.h>
#import "MDConsignor.h"


@protocol MDLoginDelegate;
@interface MDLoginViewController : UIViewController<LoginViewDelegate>

@property (strong,nonatomic) MDLoginView *loginView;
@property (nonatomic, assign) id<MDLoginDelegate> delegate;

@end

@protocol MDLoginDelegate <NSObject>

@optional
-(void) goToMainView:(UIViewController *)viewController;

@end