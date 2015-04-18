//
//  MDSettingView.m
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDSettingView.h"
#import "MDUser.h"

@implementation MDSettingView

#pragma mark - View Life Cycle

-(id) init
{
    return self;
}

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        MDUser *user = [MDUser getInstance];
        [user initDataClear];
        
        //scroll view
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        _scrollView.scrollEnabled = YES;
        _scrollView.delegate = self;
        [_scrollView setContentSize:CGSizeMake(frame.size.width, frame.size.height)];
        _scrollView.bounces = YES;
        [_scrollView setBackgroundColor:[UIColor whiteColor]];
        _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        [self addSubview:_scrollView];
        
        //name button
        MDSelect *nameButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 10, frame.size.width-20, 50)];
        nameButton.buttonTitle.text = @"お名前";
        nameButton.selectLabel.text = [NSString stringWithFormat:@"%@ %@", user.lastname, user.firstname];
        [nameButton setUnactive];
        [nameButton addTarget:self action:@selector(nameButtonPushed) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:nameButton];
        
        //phone button
        MDSelect *phoneButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 70, frame.size.width-20, 50)];
        phoneButton.buttonTitle.text = @"電話番号";
        phoneButton.selectLabel.text = [NSString stringWithFormat:@"%@", user.phoneNumber];
        [phoneButton setUnactive];
        [phoneButton addTarget:self action:@selector(nameButtonPushed) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:phoneButton];
        
        //pay button
        MDSelect *payButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 130, frame.size.width-20, 50)];
        payButton.buttonTitle.text = @"お支払い方法";
        payButton.selectLabel.text = [NSString stringWithFormat:@"%@",user.creditNumber];
        [payButton setUnactive];
        [payButton addTarget:self action:@selector(nameButtonPushed) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:payButton];
        
        //name button
        MDSelect *blockButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 190, frame.size.width-20, 50)];
        blockButton.buttonTitle.text = @"ブロックドライバー";
        [blockButton.buttonTitle sizeToFit];
        blockButton.selectLabel.text = @"";
        [blockButton setUnactive];
        [blockButton addTarget:self action:@selector(nameButtonPushed) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:blockButton];
        
        //name button
        MDSelect *qaButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 250, frame.size.width-20, 50)];
        qaButton.buttonTitle.text = @"よくある質問";
        qaButton.selectLabel.text = @"";
        [qaButton setUnactive];
        [qaButton addTarget:self action:@selector(nameButtonPushed) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:qaButton];
        
        //name button
        MDSelect *privateButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 310, frame.size.width-20, 50)];
        privateButton.buttonTitle.text = @"プライバシーポリシー";
        [privateButton.buttonTitle sizeToFit];
        privateButton.selectLabel.text = @"";
        [privateButton setUnactive];
        [privateButton addTarget:self action:@selector(nameButtonPushed) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:privateButton];
        
        //name button
        MDSelect *protocolButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 370, frame.size.width-20, 50)];
        protocolButton.buttonTitle.text = @"利用契約";
        protocolButton.selectLabel.text = @"";
        [protocolButton setUnactive];
        [protocolButton addTarget:self action:@selector(nameButtonPushed) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:protocolButton];
        
        
    }
    return self;
}

-(void) nameButtonPushed {
    NSLog(@"input name");
}


@end
