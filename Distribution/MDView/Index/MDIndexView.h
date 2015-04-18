//
//  MDIndexView.h
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol indexDelegate;


@interface MDIndexView : UIView

@property (nonatomic, assign) id<indexDelegate> delegate;


@end

@protocol indexDelegate <NSObject>

@optional
-(void) signTouched;
-(void) loginTouched;

@end
