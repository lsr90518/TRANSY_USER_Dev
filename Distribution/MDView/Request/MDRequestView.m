//
//  MDRequestView.m
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDRequestView.h"

@implementation MDRequestView

#pragma mark - View Life Cycle

-(id) init
{
    return self;
}

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //add code
        [self setBackgroundColor:[UIColor whiteColor]];
        _requestTableView = [[MDRequestTableView alloc]initWithFrame:frame];
        [self addSubview:_requestTableView];
    }
    return self;
}


@end
