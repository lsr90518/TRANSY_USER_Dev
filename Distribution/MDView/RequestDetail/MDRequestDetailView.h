//
//  MDRequestDetailView.h
//  Distribution
//
//  Created by Lsr on 4/19/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDRequestDetailView : UIView<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView  *scrollView;
@property (strong, nonatomic) NSString      *process;

-(void) setStatus:(int) status;
-(void) makeupByData:(NSDictionary *)data;

@end
