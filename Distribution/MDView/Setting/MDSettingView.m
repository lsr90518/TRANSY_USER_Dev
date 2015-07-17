//
//  MDSettingView.m
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDSettingView.h"


@implementation MDSettingView{
    MDSelect *notificationButton;
    MDSelectRating *averageButton;
    MDSelect *nameButton;
    MDCreditView *payInner;
    MDSelect *phoneButton;
    MDSelect *blockButton;
    UIButton *logoutButton;
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
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
        _scrollView.scrollEnabled = YES;
        _scrollView.delegate = self;
        [_scrollView setContentSize:CGSizeMake(frame.size.width, frame.size.height)];
        _scrollView.bounces = YES;
        [_scrollView setBackgroundColor:[UIColor whiteColor]];
        _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        [self addSubview:_scrollView];
        
        notificationButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 10, frame.size.width - 20, 50)];
        notificationButton.buttonTitle.text = @"通知";
        [notificationButton addTarget:self action:@selector(notificationButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:notificationButton];
        
        averageButton = [[MDSelectRating alloc]initWithFrame:CGRectMake(10, notificationButton.frame.origin.y + notificationButton.frame.size.height + 10, frame.size.width - 20, 50)];
        averageButton.buttonTitle.text = @"平均評価";
        [averageButton.starLabel setRating:5];
        [averageButton setReadOnly];
        [averageButton addTarget:self action:@selector(averageButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:averageButton];
        
        //name button
        nameButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, averageButton.frame.origin.y + averageButton.frame.size.height + 10, frame.size.width-20, 50)];
        nameButton.buttonTitle.text = @"お名前";
        [nameButton addTarget:self action:@selector(nameButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:nameButton];
        
        //phone button
        phoneButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, nameButton.frame.origin.y + nameButton.frame.size.height + 10, frame.size.width-20, 50)];
        phoneButton.buttonTitle.text = @"電話番号";
        [phoneButton addTarget:self action:@selector(phoneNumberTouched) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:phoneButton];
        
        // pay button inner
        payInner = [[MDCreditView alloc] initWithFrame:CGRectMake(10, phoneButton.frame.origin.y + phoneButton.frame.size.height + 10, frame.size.width-20, 50)];
        payInner.creditDelegate = self;
        [_scrollView addSubview:payInner];
        
        //pay button
        _pay = [[MDSelect alloc]initWithFrame:CGRectMake(10, phoneButton.frame.origin.y + phoneButton.frame.size.height + 10, frame.size.width-20, 50)];
        _pay.buttonTitle.text = @"お支払い方法";
        _pay.selectLabel.text = [MDUtil getPaymentSelectLabel];
        [_pay addTarget:self action:@selector(paymentButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [_pay.selectLabel setAlpha: 0.0f];
        [_scrollView addSubview:_pay];
        
        UIButton *creditAutoCompletionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        creditAutoCompletionButton.frame = CGRectMake(30, _pay.frame.origin.y + _pay.frame.size.height + 8, frame.size.width-60, 15);
        creditAutoCompletionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [creditAutoCompletionButton setTitle:@">クレジットカードのスキャン入力" forState:UIControlStateNormal];
        [creditAutoCompletionButton setTitleColor:[UIColor colorWithRed:30.0/255.0 green:132.0/255.0 blue:158.0/255.0 alpha:1] forState:UIControlStateNormal];
        [creditAutoCompletionButton setTitleColor:[UIColor colorWithRed:110.0/255.0 green:212.0/255.0 blue:238.0/255.0 alpha:1] forState:UIControlStateHighlighted];
        [creditAutoCompletionButton.titleLabel setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:10]];
        [creditAutoCompletionButton addTarget:self action:@selector(showCardIO) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:creditAutoCompletionButton];
        
        //name button
        blockButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, creditAutoCompletionButton.frame.origin.y + creditAutoCompletionButton.frame.size.height + 17, frame.size.width-20, 50)];
        blockButton.buttonTitle.text = @"ブロックドライバー";
        [blockButton.buttonTitle sizeToFit];
        blockButton.selectLabel.text = @"";
        [blockButton setUnactive];
//        [blockButton addTarget:self action:@selector(nameButtonPushed) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:blockButton];
        
        //name button
        MDSelect *qaButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, blockButton.frame.origin.y + blockButton.frame.size.height + 10, frame.size.width-20, 50)];
        qaButton.buttonTitle.text = @"よくある質問";
        qaButton.selectLabel.text = @"";
        [qaButton setUnactive];
        [qaButton addTarget:self action:@selector(aqButtonPushed) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:qaButton];
        
        //name button
        MDSelect *privateButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, qaButton.frame.origin.y + qaButton.frame.size.height + 10, frame.size.width-20, 50)];
        privateButton.buttonTitle.text = @"プライバシーポリシー";
        [privateButton.buttonTitle sizeToFit];
        privateButton.selectLabel.text = @"";
        [privateButton setUnactive];
        [privateButton addTarget:self action:@selector(privateButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:privateButton];
        
        //name button
        MDSelect *protocolButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, privateButton.frame.origin.y + privateButton.frame.size.height + 10, frame.size.width-20, 50)];
        protocolButton.buttonTitle.text = @"利用規約";
        protocolButton.selectLabel.text = @"";
        [protocolButton setUnactive];
        [protocolButton addTarget:self action:@selector(protocolButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:protocolButton];
        
        //button
        logoutButton = [[UIButton alloc]initWithFrame:CGRectMake(10, protocolButton.frame.origin.y + protocolButton.frame.size.height + 23, frame.size.width-20, 50)];
        [logoutButton setBackgroundColor:[UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1]];
        [logoutButton setTitle:@"ログアウト" forState:UIControlStateNormal];
        logoutButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:18];
        logoutButton.layer.cornerRadius = 2.5;
        [logoutButton addTarget:self action:@selector(logoutButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:logoutButton];
        [_scrollView setContentSize:CGSizeMake(frame.size.width, logoutButton.frame.origin.y + logoutButton.frame.size.height + 10)];
        
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
    notificationButton.selectLabel.text = [NSString stringWithFormat:@"新着通知はありません"];
    
}

-(void) setRating:(int)star{
    [averageButton.starLabel setRating:star];
}

-(void)setNotificationCount:(int)count{
    
    if(count == 0){
        notificationButton.selectLabel.text = @"新着通知はありません";
    } else {
        notificationButton.selectLabel.text = [NSString stringWithFormat:@"%d件の新着", count];
    }
}

-(void) logoutButtonTouched{
    if([self.delegate respondsToSelector:@selector(logoutButtonPushed)]){
        [self.delegate logoutButtonPushed];
    }
}

-(void) notificationButtonTouched {
    if([self.delegate respondsToSelector:@selector(notificationButtonPushed)]){
        [self.delegate notificationButtonPushed];
    }
}

-(void) averageButtonTouched{
    if([self.delegate respondsToSelector:@selector(averageButtonPushed)]){
        [self.delegate averageButtonPushed];
    }
}

-(void) privateButtonTouched{
    if([self.delegate respondsToSelector:@selector(privacyButtonPushed)]){
        [self.delegate privacyButtonPushed];
    }
}

-(void) protocolButtonTouched {
    if([self.delegate respondsToSelector:@selector(protocolButtonPushed)]){
        [self.delegate protocolButtonPushed];
    }
}

-(void) aqButtonPushed{
    if([self.delegate respondsToSelector:@selector(aqButtonPushed)]){
        [self.delegate aqButtonPushed];
    }
}

/*
 * MDCreditViewDelegate
 */
-(void)hasNoAuthorizedCard {
    [[MDUser getInstance] setCredit:0];
    [_pay.selectLabel setText:[MDUtil getPaymentSelectLabel]];
    [_pay.selectLabel setAlpha: 1.0f];
}


@end

