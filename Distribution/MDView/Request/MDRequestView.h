//
//  MDRequestView.h
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDRequestTableView.h"
#import "MDRequestTableViewCell.h"
#import "MDTabButton.h"

@protocol MDRequestViewDelegate;

@interface MDRequestView : UIView<MDRequestTableViewDelegate>

@property (strong, nonatomic) MDRequestTableView        *requestTableView;
@property (strong, nonatomic) UIView                    *tabbar;

@property (nonatomic, assign) id<MDRequestViewDelegate>   delegate;

-(void) initWithArray:(NSArray *)array;

@end

@protocol MDRequestViewDelegate <NSObject>

@optional
-(void) gotoDeliveryView;
-(void) gotoSettingView;
-(void) makeUpData:(NSDictionary *)data;

@end
