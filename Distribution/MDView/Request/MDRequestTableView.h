//
//  MDRequestTableView.h
//  Distribution
//
//  Created by Lsr on 4/7/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDPackage.h"

@protocol MDRequestTableViewDelegate;

@interface MDRequestTableView : UITableView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) id<MDRequestTableViewDelegate> requestTableViewDelegate;

-(void) initWithArray:(NSArray *)array;

@end

@protocol MDRequestTableViewDelegate <NSObject>

@optional
-(void) didSelectedRowWithData:(MDPackage *)data;

@end