//
//  MDSettingView.m
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDSettingView.h"


@implementation MDSettingView{
    MDSelect *nameButton;
    MDCreditView *payInner;
    MDSelect *pay;
    MDSelect *phoneButton;
    MDSelect *blockButton;
}

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
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height-50)];
        _scrollView.scrollEnabled = YES;
        _scrollView.delegate = self;
        [_scrollView setContentSize:CGSizeMake(frame.size.width, frame.size.height)];
        _scrollView.bounces = YES;
        [_scrollView setBackgroundColor:[UIColor whiteColor]];
        _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        [self addSubview:_scrollView];
        
        //name button
        nameButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 10, frame.size.width-20, 50)];
        nameButton.buttonTitle.text = @"お名前";
        [nameButton addTarget:self action:@selector(nameButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:nameButton];
        
        //phone button
        phoneButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 70, frame.size.width-20, 50)];
        phoneButton.buttonTitle.text = @"電話番号";
        [phoneButton addTarget:self action:@selector(phoneNumberTouched) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:phoneButton];
        
        // pay button inner
        payInner = [[MDCreditView alloc] initWithFrame:CGRectMake(10, 130, frame.size.width-20, 50)];
        payInner.creditDelegate = self;
        [_scrollView addSubview:payInner];
        
        //pay button
        pay = [[MDSelect alloc]initWithFrame:CGRectMake(10, 130, frame.size.width-20, 50)];
        pay.buttonTitle.text = @"お支払い方法";
        pay.selectLabel.text = [MDUtil getPaymentSelectLabel];
        [pay addTarget:self action:@selector(paymentButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [pay setTag:paymentSelect];
        [pay.selectLabel setAlpha: 0.0f];
        [_scrollView addSubview:pay];
        
        UIButton *creditAutoCompletionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        creditAutoCompletionButton.frame = CGRectMake(30, 188, frame.size.width-60, 15);
        creditAutoCompletionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [creditAutoCompletionButton setTitle:@">クレジットカードのスキャン入力" forState:UIControlStateNormal];
        [creditAutoCompletionButton setTitleColor:[UIColor colorWithRed:30.0/255.0 green:132.0/255.0 blue:158.0/255.0 alpha:1] forState:UIControlStateNormal];
        [creditAutoCompletionButton setTitleColor:[UIColor colorWithRed:110.0/255.0 green:212.0/255.0 blue:238.0/255.0 alpha:1] forState:UIControlStateHighlighted];
        [creditAutoCompletionButton.titleLabel setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:10]];
        [creditAutoCompletionButton addTarget:self action:@selector(showCardIO) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:creditAutoCompletionButton];
        
        //name button
        blockButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 220, frame.size.width-20, 50)];
        blockButton.buttonTitle.text = @"ブロックドライバー";
        [blockButton.buttonTitle sizeToFit];
        blockButton.selectLabel.text = @"";
        [blockButton setUnactive];
//        [blockButton addTarget:self action:@selector(nameButtonPushed) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:blockButton];
        
        //name button
        MDSelect *qaButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 280, frame.size.width-20, 50)];
        qaButton.buttonTitle.text = @"よくある質問";
        qaButton.selectLabel.text = @"";
        [qaButton setUnactive];
//        [qaButton addTarget:self action:@selector(nameButtonPushed) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:qaButton];
        
        //name button
        MDSelect *privateButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 340, frame.size.width-20, 50)];
        privateButton.buttonTitle.text = @"プライバシーポリシー";
        [privateButton.buttonTitle sizeToFit];
        privateButton.selectLabel.text = @"";
        [privateButton setUnactive];
//        [privateButton addTarget:self action:@selector(nameButtonPushed) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:privateButton];
        
        //name button
        MDSelect *protocolButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 400, frame.size.width-20, 50)];
        protocolButton.buttonTitle.text = @"利用規約";
        protocolButton.selectLabel.text = @"";
        [protocolButton setUnactive];
//        [protocolButton addTarget:self action:@selector(nameButtonPushed) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:protocolButton];
        
        //tabbar
        _tabbar = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-50, frame.size.width, 50)];
        //tab bar shadow
        UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
        [shadowView setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1]];
        [_tabbar addSubview:shadowView];
        
        //tab bar button
        for (int i = 0; i < 3; i++) {
            MDTabButton *tabButton = [[MDTabButton alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width / 3) * i, 0.5, ([UIScreen mainScreen].bounds.size.width / 3), 49.5) withTabType:i];
            if (i == 2) {
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

-(void) nameButtonTouched {
    if([self.delegate respondsToSelector:@selector(nameButtonPushed)]){
        [self.delegate nameButtonPushed];
    }
}

- (void) phoneNumberTouched {
    if([self.delegate respondsToSelector:@selector(phoneNumberPushed)]){
        [self.delegate phoneNumberPushed];
    }
}

-(void) paymentButtonTouched {
    if([self.delegate respondsToSelector:@selector(nameButtonPushed)]){
        [self.delegate paymentButtonPushed];
    }
}
-(void) showCardIO {
    if([self.delegate respondsToSelector:@selector(showCardIO)]){
        [self.delegate showCardIO];
    }
}

-(void) privacyButtonTouched {
    if([self.delegate respondsToSelector:@selector(privacyButtonPushed)]){
        [self.delegate privacyButtonPushed];
    }
}

-(void) blockDriverTouched {
    if([self.delegate respondsToSelector:@selector(blockDriverPushed)]){
        [self.delegate blockDriverPushed];
    }
}

-(void) changeTab:(MDTabButton *)button {
    switch (button.type) {
        case 0:
            [self gotoRequestView];
            break;
        case 1:
            [self gotoDeliveryView];
            break;
        default:
            break;
    }
}

-(void) gotoRequestView{
    if([self.delegate respondsToSelector:@selector(gotoRequestView)]) {
        [self.delegate gotoRequestView];
    }
}

-(void) gotoDeliveryView {
    if([self.delegate respondsToSelector:@selector(gotoDeliveryView)]) {
        [self.delegate gotoDeliveryView];
    }
}

-(void) setViewData:(MDUser *)user{
    nameButton.selectLabel.text = [NSString stringWithFormat:@"%@ %@", user.lastname, user.firstname];
    phoneButton.selectLabel.text = [NSString stringWithFormat:@"%@", user.phoneNumber];
}


/*
 * MDCreditViewDelegate
 */
-(void)hasNoAuthorizedCard {
    [pay.selectLabel setAlpha: 1.0f];
}


@end

