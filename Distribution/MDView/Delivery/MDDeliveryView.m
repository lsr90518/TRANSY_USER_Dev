//
//  MDDeliveryView.m
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDDeliveryView.h"
#import "MDDeliveryKindButton.h"
#import "MDAddressInputTable.h"
#import "MDSelect.h"
#import "MDTabButton.h"

@implementation MDDeliveryView {
    float _frameWidth;
    MDSelect *requestButton;
    MDSelect *destinationButton;
    MDSelect *sizePicker;
    MDSelect *additionalServicePicker;
    MDSelect *costPicker;
    MDSelect *cusTodyTimePicker;
    MDSelect *destinateTimePicker;
    MDSelect *requestTerm;
    MDSelect *beCarefulPicker;
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
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        
        //add code
        [self setBackgroundColor:[UIColor whiteColor]];
        self.frameColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        _frameWidth = 0.5;
        //post Button
        _postButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_postButton setTitle:@"以下で依頼" forState:UIControlStateNormal];
        _postButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
        _postButton.frame = CGRectMake(0, 0, 60, 44);
        [_postButton addTarget:self action:@selector(postButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        
        //scroll view
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        _scrollView.scrollEnabled = YES;
        _scrollView.delegate = self;
        [_scrollView setContentSize:CGSizeMake(frame.size.width, 886)];
        _scrollView.bounces = YES;
        _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        [self addSubview:_scrollView];
        
        //package moving buttons
        UIView *tabButtonView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, frame.size.width-20, 80)];
            //package
            _packageButton = [[MDDeliveryKindButton alloc]initWithFrame:CGRectMake(0, 0, tabButtonView.frame.size.width/2, 80)];
            [_packageButton setActive];
            [_packageButton setIconImage:[UIImage imageNamed:@"packageIcon"]];
            [_packageButton addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
            [tabButtonView addSubview:_packageButton];
            //moving
            _movingButton = [[MDDeliveryKindButton alloc]initWithFrame:CGRectMake(tabButtonView.frame.size.width/2, 0, tabButtonView.frame.size.width/2, 80)];
            [_movingButton setIconImage:[UIImage imageNamed:@"movingIcon"]];
            _movingButton.buttonTitle.text = @"引っ越し";
            [_movingButton addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
            [tabButtonView addSubview:_movingButton];
        UIView *tabIsolationLine = [[UIView alloc]initWithFrame:CGRectMake(tabButtonView.frame.size.width/2, 0, _frameWidth, tabButtonView.frame.size.height)];
        [tabIsolationLine setBackgroundColor:self.frameColor];
        [tabButtonView addSubview:tabIsolationLine];
        tabButtonView.layer.cornerRadius = 2.5;
        tabButtonView.layer.masksToBounds = YES;
        tabButtonView.layer.borderWidth = _frameWidth;
        tabButtonView.layer.borderColor = self.frameColor.CGColor;
        [_scrollView addSubview:tabButtonView];
        
        requestButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 100, frame.size.width-20, 50)];
        requestButton.buttonTitle.text = @"預かり先";
        requestButton.selectLabel.text = @"〒1540002";
        [requestButton setUnactive];
        [requestButton addTarget:self action:@selector(gotoRequestAddressView) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:requestButton];
        
        
        destinationButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 149, frame.size.width-20, 50)];
        [destinationButton setBackgroundColor:[UIColor whiteColor]];
        destinationButton.buttonTitle.text = @"お届け先";
        destinationButton.selectLabel.text = @"〒7700813";
        [destinationButton setUnactive];
        [destinationButton addTarget:self action:@selector(gotoDestinationAddressView) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:destinationButton];
        
        
        
        //list
        sizePicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, 210, frame.size.width-20, 50)];
        sizePicker.buttonTitle.text = @"サイズ";
        sizePicker.selectLabel.text = @"120";
        sizePicker.options = [[NSArray alloc]initWithObjects:@"60",@"80",@"100",@"120",@"140",@"160", nil];
        [sizePicker addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:sizePicker];
        
        //list
//        additionalServicePicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, 270, frame.size.width-20, 50)];
//        additionalServicePicker.buttonTitle.text = @"付帯サービス";
//        additionalServicePicker.selectLabel.text = @"なし";
//        [additionalServicePicker setUnactive];
//        [additionalServicePicker addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
//        [_scrollView addSubview:additionalServicePicker];
        
        //list
        beCarefulPicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, 270, frame.size.width-20, 50)];
        beCarefulPicker.buttonTitle.text = @"取扱説明書";
        beCarefulPicker.selectLabel.text = @"特になし";
        [beCarefulPicker setUnactive];
        [beCarefulPicker addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:beCarefulPicker];
        
        //list
        costPicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, 330, frame.size.width-20, 50)];
        costPicker.buttonTitle.text = @"依頼金額";
        costPicker.selectLabel.text = @"1400円";
        [costPicker addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:costPicker];
        
        //list
        cusTodyTimePicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, 390, frame.size.width-20, 50)];
        cusTodyTimePicker.buttonTitle.text = @"預かり時刻";
        cusTodyTimePicker.selectLabel.text = @"いつでも";
        [cusTodyTimePicker setUnactive];
        [cusTodyTimePicker addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:cusTodyTimePicker];
        
        //list
        destinateTimePicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, 450, frame.size.width-20, 50)];
        destinateTimePicker.buttonTitle.text = @"お届け期限";
        [destinateTimePicker setUnactive];
        [destinateTimePicker addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:destinateTimePicker];
        
        
        
        //list
        requestTerm = [[MDSelect alloc]initWithFrame:CGRectMake(10, 510, frame.size.width-20, 50)];
        requestTerm.buttonTitle.text = @"依頼期限";
        requestTerm.options = [[NSArray alloc]initWithObjects:@"3",@"6",@"9",@"12",@"15",@"18",@"21",@"24", nil];
        [requestTerm addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:requestTerm];
        
        //tabbar
        _tabbar = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-50, frame.size.width, 50)];
        //tab bar shadow
        UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
        [shadowView setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1]];
        [_tabbar addSubview:shadowView];
        
        //tab bar button
        for (int i = 0; i < 3; i++) {
            MDTabButton *tabButton = [[MDTabButton alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width / 3) * i, 0.5, ([UIScreen mainScreen].bounds.size.width / 3), 49.5) withTabType:i];
            if (i == 1) {
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

-(void) initViewData:(MDCurrentPackage *)package {
    if([package.requestType isEqualToString:@"2"]) {
        [_movingButton setActive];
        [_packageButton setUnactive];
    }
    
    [[MDCurrentPackage getInstance] initData];
    
    //預かり先
    if([MDCurrentPackage getInstance].from_zip.length < 1){
        [MDCurrentPackage getInstance].from_zip = @"";
    }
    if([MDCurrentPackage getInstance].to_zip.length < 1) {
        [MDCurrentPackage getInstance].to_zip = @"";
    }
    requestButton.selectLabel.text = [NSString stringWithFormat:@"〒%@",[MDCurrentPackage getInstance].from_zip];
    //お届け先
    destinationButton.selectLabel.text = [NSString stringWithFormat:@"〒%@",[MDCurrentPackage getInstance].to_zip];
    //size
    sizePicker.selectLabel.text = [NSString stringWithFormat:@"%@cm以内",[MDCurrentPackage getInstance].size];
    //note
//    additionalServicePicker.selectLabel.text = [MDCurrentPackage getInstance].note;
    //取扱説明書
    beCarefulPicker.selectLabel.text = ([MDCurrentPackage getInstance].note == nil) ? @"特になし" : [MDCurrentPackage getInstance].note;
    //price
    costPicker.selectLabel.text = [NSString stringWithFormat:@"%@円",[MDCurrentPackage getInstance].request_amount];
    //at home time;
    NSArray *dateStr = [[MDCurrentPackage getInstance].at_home_time[0][0] componentsSeparatedByString:@"-"];
    cusTodyTimePicker.selectLabel.text = [NSString stringWithFormat:@"%d月%d日 %@時-%@時", [dateStr[1] intValue], [dateStr[2] intValue], [MDCurrentPackage getInstance].at_home_time[0][1],[MDCurrentPackage getInstance].at_home_time[0][2]];
    
    destinateTimePicker.selectLabel.text = [NSString stringWithFormat:@"%@時", [[MDCurrentPackage getInstance].deliver_limit substringToIndex:13]];
    
    //expire
    NSDate * now = [NSDate date];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSLocale systemLocale]];
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:00"];
    NSDate *expireDate =[dateFormat dateFromString:[MDCurrentPackage getInstance].expire];
    NSTimeInterval timeBetween = [expireDate timeIntervalSinceDate:now];
    int hour = timeBetween/60/60;
    requestTerm.selectLabel.text = [NSString stringWithFormat:@"%d時間以内",hour+1];
}

-(void) postButtonTouched {
    if([self.delegate respondsToSelector:@selector(postButtonTouched)]) {
        [self.delegate postButtonTouched];
    }
}

-(void) pickerButtonTouched:(MDSelect*)select {
    if ([self.delegate respondsToSelector:@selector(selectButtonTouched:)]){
        [self.delegate selectButtonTouched:select];
    }
}

-(void) changeType:(MDDeliveryKindButton *)button {
    if([button.buttonTitle.text isEqualToString:@"引っ越し"]){
        [_movingButton setActive];
        [_packageButton setUnactive];
        [MDCurrentPackage getInstance].requestType = @"1";
    } else {
        [_movingButton setUnactive];
        [_packageButton setActive];
        [MDCurrentPackage getInstance].requestType = @"0";
    }
    
}

- (NSString*) checkInput {
    NSString *result;
    if([requestButton.selectLabel.text isEqualToString:@"〒"]){
        result = @"預かり先";
    } else if([destinationButton.selectLabel.text isEqualToString:@"〒"]){
        result = @"お届け先";
    } else {
        result = @"";
    }
    return result;
}

#pragma UIScrollview delegate
// scrollView 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
}

-(void)gotoRequestAddressView {
    if([self.delegate respondsToSelector:@selector(gotoRequestAddressView)]){
        [self.delegate gotoRequestAddressView];
    }
}

-(void) gotoDestinationAddressView {
    if([self.delegate respondsToSelector:@selector(gotoDestinationAddressView)]) {
        [self.delegate gotoDestinationAddressView];
    }
    
}

-(void) changeTab:(MDTabButton *)button {
    switch (button.type) {
        case 0:
            [self gotoRequestView];
            break;
        case 2:
            [self gotoSettingView];
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

-(void) gotoSettingView {
    if([self.delegate respondsToSelector:@selector(gotoSettingView)]) {
        [self.delegate gotoSettingView];
    }
}

@end
