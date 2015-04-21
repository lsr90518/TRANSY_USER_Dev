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
        _requestTableView = [[MDRequestTableView alloc]initWithFrame:CGRectMake(frame.origin.x,
                                                                                frame.origin.y,
                                                                                frame.size.width,
                                                                                frame.size.height-50)];
        
        //call api
        
        [self addSubview:_requestTableView];
        _requestTableView.requestTableViewDelegate = self;
        
        //tabbar
        _tabbar = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-50, frame.size.width, 50)];
        //tab bar shadow
        UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
        [shadowView setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1]];
        [_tabbar addSubview:shadowView];
        
        //tab bar button
        for (int i = 0; i < 3; i++) {
            MDTabButton *tabButton = [[MDTabButton alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width / 3) * i, 0.5, ([UIScreen mainScreen].bounds.size.width / 3), 49.5) withTabType:i];
            if (i == 0) {
                [tabButton setButtonImage:YES];
            } else {
                [tabButton setButtonImage:NO];
            }
            [tabButton addTarget:self action:@selector(changeTab:) forControlEvents:UIControlEventTouchDown];
            [_tabbar addSubview:tabButton];
        }
        [self addSubview:_tabbar];
    }
    return self;
}

-(void) initWithArray:(NSArray *)array{
    [_requestTableView initWithArray:array];
}

-(void) changeTab:(MDTabButton *)button {
    switch (button.type) {
        case 1:
            [self gotoDeliveryView];
            break;
        case 2:
            [self gotoSettingView];
            break;
        default:
            break;
    }
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

-(void) didSelectedRowWithData:(NSDictionary *)data {
    if([self.delegate respondsToSelector:@selector(makeUpData:)]){
        [self.delegate makeUpData:data];
    }
}

@end
