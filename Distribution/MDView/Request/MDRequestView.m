//
//  MDRequestView.m
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDRequestView.h"
#import "MDUtil.h"
#import <MJRefresh.h>

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
        _requestTableView = [[MDRequestTableView alloc]initWithFrame:CGRectMake(frame.origin.x,
                                                                                frame.origin.y,
                                                                                frame.size.width,
                                                                                frame.size.height)];
        [self addSubview:_requestTableView];
        _requestTableView.requestTableViewDelegate = self;
        
        [_requestTableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(pullRefresh)];
        _requestTableView.header.updatedTimeHidden = YES;
        
        // Add Package Butotn
        UIButton *addPackageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addPackageButton setFrame:CGRectMake(frame.size.width-70, frame.size.height-70, 50, 50)];
        [addPackageButton.layer setCornerRadius:25.0];
        [addPackageButton.layer setBorderWidth:1.0];
        [addPackageButton.layer setBorderColor:[[MDUtil getThemeColor] CGColor]];
        [addPackageButton setImage:[UIImage imageNamed:@"delivery_tab_unactive"] forState:UIControlStateNormal];
        [addPackageButton setBackgroundColor:[UIColor whiteColor]];
        [addPackageButton addTarget:self action:@selector(gotoDeliveryView) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview: addPackageButton];
    }
    return self;
}

-(void) initWithArray:(NSArray *)array{
    [_requestTableView initWithArray:array];
}

-(void) gotoDeliveryView{
    if([self.delegate respondsToSelector:@selector(gotoDeliveryView)]) {
        [self.delegate gotoDeliveryView];
    }
}

-(void) gotoSettingView {
    if([self.delegate respondsToSelector:@selector(gotoSettingView)]) {
        [self.delegate gotoSettingView];
    }
}

-(void) didSelectedRowWithData:(MDPackage *)data {
    if([self.delegate respondsToSelector:@selector(makeUpData:)]){
        [self.delegate makeUpData:data];
    }
}

-(void) endRefresh{
    [_requestTableView.header endRefreshing];
}

-(void) pullRefresh{
    if([self.delegate respondsToSelector:@selector(refreshData)]){
        [self.delegate refreshData];
    }
}

@end
