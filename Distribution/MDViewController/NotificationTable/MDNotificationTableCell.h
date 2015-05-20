//
//  MDNotificationTableCell.h
//  Distribution
//
//  Created by 劉 松然 on 2015/05/20.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDNotifacation.h"
#import <UIImageView+WebCache.h>

@interface MDNotificationTableCell : UITableViewCell

-(void) setDataWithModel:(MDNotifacation *)notification;

@end
