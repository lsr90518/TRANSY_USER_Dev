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
#import "MDUtil.h"

@implementation MDDeliveryView {
    float _frameWidth;
    MDSelect *requestButton;
    MDSelect *destinationButton;
    MDSelect *sizePicker;
    MDSelect *additionalServicePicker;
    MDInput *costPicker;
    MDSelect *cusTodyTimePicker;
    MDSelect *destinateTimePicker;
    MDSelect *requestTerm;
    MDSelect *beCarefulPicker;
    
    UIButton *sizeDescriptionButton;
    UIButton *moneyDescriptionButton;
    
    NSMutableArray *options;
    NSMutableArray* time;
    NSMutableArray* realDate;
    NSMutableArray* date;
    NSMutableArray *cusTodyDate;
    NSMutableArray *destinateDate;
    NSMutableArray* minute;
    NSMutableArray *cusTodyTime;
    NSMutableArray *destinateMinute;
    NSMutableArray *destinateTime;
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
        _scrollView.delegate = self;
        
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
        [_movingButton addTarget:self action:@selector(showSorryAlert) forControlEvents:UIControlEventTouchUpInside];
    
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
        requestButton.selectLabel.text = @"〒";
        [requestButton addTarget:self action:@selector(gotoRequestAddressView) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:requestButton];
        
        //在宅時間
        cusTodyTimePicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, requestButton.frame.origin.y + requestButton.frame.size.height -2, frame.size.width-20, 50)];
        [cusTodyTimePicker setBackgroundColor:[UIColor whiteColor]];
        cusTodyTimePicker.buttonTitle.text = @"預かり時刻";
        cusTodyTimePicker.selectLabel.text = @"いつでも";
        cusTodyTimePicker.tag = 1;
        cusTodyTimePicker.delegate = self;
        NSMutableArray *cusTodyTimePickerOptions = [[NSMutableArray alloc]init];
        [self initReciveTimeData];
        [cusTodyTimePickerOptions addObject:date];
        [cusTodyTimePickerOptions addObject:cusTodyTime];
        [cusTodyTimePicker setOptions:cusTodyTimePickerOptions :@"" :@""];
        [cusTodyTimePicker addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:cusTodyTimePicker];
        
        
        destinationButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, cusTodyTimePicker.frame.origin.y + cusTodyTimePicker.frame.size.height + 10, frame.size.width-20, 50)];
        [destinationButton setBackgroundColor:[UIColor whiteColor]];
        destinationButton.buttonTitle.text = @"お届け先";
        destinationButton.selectLabel.text = @"〒";
        [destinationButton addTarget:self action:@selector(gotoDestinationAddressView) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:destinationButton];
        
        //list
        destinateTimePicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, destinationButton.frame.origin.y + destinationButton.frame.size.height - 2, frame.size.width-20, 50)];
        [destinateTimePicker setBackgroundColor:[UIColor whiteColor]];
        destinateTimePicker.buttonTitle.text = @"お届け期限";
        destinateTimePicker.tag = 2;
        destinateTimePicker.delegate = self;
        [destinateTimePicker setUnactive];
        NSMutableArray *destinateTimePickerOptions = [[NSMutableArray alloc]init];
        [self initDeliveryLimitData];
        [destinateTimePickerOptions addObject:date];
        [destinateTimePickerOptions addObject:destinateTime];
        [destinateTimePickerOptions addObject:destinateMinute];
        [destinateTimePicker setOptions:destinateTimePickerOptions :@"" :@""];
        [destinateTimePicker addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:destinateTimePicker];
        
        
        
        //list
        sizePicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, destinateTimePicker.frame.origin.y + destinateTimePicker.frame.size.height + 10, frame.size.width-20, 50)];
        sizePicker.buttonTitle.text = @"サイズ";
        sizePicker.selectLabel.text = @"合計120以内";
        sizePicker.delegate = self;
        NSMutableArray *sizePickerOptions = [[NSMutableArray alloc]init];
        NSMutableArray *sizePickerFirstOptions = [[NSMutableArray alloc]initWithObjects:@"60",@"80",@"100",@"120",@"140",@"160",@"180",@"200",@"220",@"240",@"260", nil];
        [sizePickerOptions addObject:sizePickerFirstOptions];
        [sizePicker setOptions:sizePickerOptions :@"合計" :@"cm以内"];
        sizePicker.tag = 0;
        [sizePicker addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:sizePicker];
        
        sizeDescriptionButton = [[UIButton alloc]initWithFrame:CGRectMake(10, sizePicker.frame.origin.y + sizePicker.frame.size.height + 10, sizePicker.frame.size.width - 20, 10)];
        sizeDescriptionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [sizeDescriptionButton setTitle:@"> 荷物サイズの測り方" forState:UIControlStateNormal];
        [sizeDescriptionButton setTitleColor:[UIColor colorWithRed:30.0/255.0 green:132.0/255.0 blue:158.0/255.0 alpha:1] forState:UIControlStateNormal];
        [sizeDescriptionButton setTitleColor:[UIColor colorWithRed:110.0/255.0 green:212.0/255.0 blue:238.0/255.0 alpha:1] forState:UIControlStateHighlighted];
        [sizeDescriptionButton.titleLabel setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:10]];
        [sizeDescriptionButton addTarget:self action:@selector(sizeDescriptionButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:sizeDescriptionButton];
        
        
        //list
        costPicker = [[MDInput alloc]initWithFrame:CGRectMake(10, sizeDescriptionButton.frame.origin.y + sizeDescriptionButton.frame.size.height + 17, frame.size.width-20, 50)];
        costPicker.title.text = @"依頼金額";
        [costPicker.title sizeToFit];
        costPicker.input.text = @"1400";
        costPicker.input.delegate = self;
        [costPicker.input setKeyboardType:UIKeyboardTypeNumberPad];
        [_scrollView addSubview:costPicker];
        
        
        moneyDescriptionButton = [[UIButton alloc]initWithFrame:CGRectMake(10, costPicker.frame.origin.y + costPicker.frame.size.height + 10, costPicker.frame.size.width - 20, 10)];
        moneyDescriptionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [moneyDescriptionButton setTitle:@"> 依頼金額について" forState:UIControlStateNormal];
        [moneyDescriptionButton setTitleColor:[UIColor colorWithRed:30.0/255.0 green:132.0/255.0 blue:158.0/255.0 alpha:1] forState:UIControlStateNormal];
        [moneyDescriptionButton setTitleColor:[UIColor colorWithRed:110.0/255.0 green:212.0/255.0 blue:238.0/255.0 alpha:1] forState:UIControlStateHighlighted];
        [moneyDescriptionButton.titleLabel setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:10]];
        [moneyDescriptionButton addTarget:self action:@selector(sizeDescriptionButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:moneyDescriptionButton];
        
        //list
        beCarefulPicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, moneyDescriptionButton.frame.origin.y + moneyDescriptionButton.frame.size.height + 17, frame.size.width-20, 50)];
        beCarefulPicker.buttonTitle.text = @"取扱注意事項";
        beCarefulPicker.selectLabel.text = @"特になし";
        [beCarefulPicker addTarget:self action:@selector(changeViewButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:beCarefulPicker];
        
        
        
        //list
        requestTerm = [[MDSelect alloc]initWithFrame:CGRectMake(10, beCarefulPicker.frame.origin.y + beCarefulPicker.frame.size.height + 10, frame.size.width-20, 50)];
        requestTerm.buttonTitle.text = @"掲載期限";
        requestTerm.delegate = self;
//        requestTerm.options = [[NSArray alloc]initWithObjects:@"3",@"6",@"9",@"12",@"15",@"18",@"21",@"24", nil];
        NSMutableArray *requestTermOptions = [[NSMutableArray alloc]init];
        NSMutableArray *requestTermFirstOptions = [[NSMutableArray alloc]initWithObjects:@"0.5",@"1",@"3",@"6",@"12",@"24",@"72", nil];
        [requestTermOptions addObject:requestTermFirstOptions];
        [requestTerm setOptions:requestTermOptions :@"" :@"時間以内"];
        requestTerm.tag = 3;
        [requestTerm addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:requestTerm];
        
        [_scrollView setContentSize:CGSizeMake(frame.size.width, requestTerm.frame.origin.y + requestTerm.frame.size.height + 70)];
        
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
    options = [[NSMutableArray alloc]init];
    
    if([package.requestType isEqualToString:@"2"]) {
        [_movingButton setActive];
        [_packageButton setUnactive];
    }
    
    [[MDCurrentPackage getInstance] initData];
    
    //預かり先
    if([MDCurrentPackage getInstance].from_zip.length < 1){
        [MDCurrentPackage getInstance].from_zip = @"";
        requestButton.selectLabel.text = @"選択してください";
        [requestButton setUnactive];
    } else {
        requestButton.selectLabel.text = [NSString stringWithFormat:@"〒%@",[MDCurrentPackage getInstance].from_zip];
        [requestButton setActive];
    }
    
    //to_zip
    if([MDCurrentPackage getInstance].to_zip.length < 1) {
        [MDCurrentPackage getInstance].to_zip = @"";
        destinationButton.selectLabel.text = @"選択してください";
        [destinationButton setUnactive];
    } else {
        NSLog(@"to_zip %@", [MDCurrentPackage getInstance].to_zip);
        destinationButton.selectLabel.text = [NSString stringWithFormat:@"〒%@",[MDCurrentPackage getInstance].to_zip];
        [destinationButton setActive];
    }
    
    //size
    sizePicker.selectLabel.text = [NSString stringWithFormat:@"合計%@cm以内",[MDCurrentPackage getInstance].size];
    
    //取扱説明書
    beCarefulPicker.selectLabel.text = ([MDCurrentPackage getInstance].note == nil) ? @"特になし" : [MDCurrentPackage getInstance].note;
    
    //price
    costPicker.input.text = [NSString stringWithFormat:@"¥%@",[MDCurrentPackage getInstance].request_amount];
    
    //at home time;
    NSArray *dateStr = [[MDCurrentPackage getInstance].at_home_time[0][0] componentsSeparatedByString:@"-"];
    NSString *at_home_time_str = @"";
    if([[MDCurrentPackage getInstance].at_home_time[0][2] isEqualToString:@"-1"]){
        at_home_time_str = [NSString stringWithFormat:@"%d月%d日 いつでも", [dateStr[1] intValue], [dateStr[2] intValue]];
    } else {
        at_home_time_str = [NSString stringWithFormat:@"%d月%d日 %@時~%@時", [dateStr[1] intValue], [dateStr[2] intValue], [MDCurrentPackage getInstance].at_home_time[0][1],[MDCurrentPackage getInstance].at_home_time[0][2]];
    }
    cusTodyTimePicker.selectLabel.text = at_home_time_str;
    
    if([MDCurrentPackage getInstance].deliver_limit.length < 1){
        destinateTimePicker.selectLabel.text = @"選択してください";
        [destinateTimePicker setUnactive];
    } else {
    
        destinateTimePicker.selectLabel.text = [self getInitStr];
        [destinateTimePicker setActive];
    }
    
    //expire
    [self setExpireTime:[MDCurrentPackage getInstance].expire];
    
}

-(void) setExpireTime:(NSString *)expire{
    NSDate * now = [NSDate date];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateFormatter *tmpFormatter = [[NSDateFormatter alloc]init];
    [tmpFormatter setCalendar:gregorianCalendar];
    [tmpFormatter setLocale:[NSLocale systemLocale]];
    [tmpFormatter setDateFormat:@"YYYY-MM-dd HH:mm:00"];
    NSDate *expireDate =[tmpFormatter dateFromString:expire];
    NSTimeInterval timeBetween = [expireDate timeIntervalSinceDate:now];
    int hour = timeBetween/60/60;
    requestTerm.selectLabel.text = [NSString stringWithFormat:@"%d時間以内",hour+1];
}



-(void) postButtonTouched {
    if([self.delegate respondsToSelector:@selector(postButtonTouched)]) {
        [self.delegate postButtonTouched];
    }
}

-(void) changeViewButtonTouched:(MDSelect *)select {
    if([self.delegate respondsToSelector:@selector(selectButtonTouched:)]){
        [self.delegate selectButtonTouched:select];
    }
}

-(void) pickerButtonTouched:(MDSelect*)select {
    
    _MDPicker = [[MDPicker alloc]initWithFrame:self.frame];
    _MDPicker.delegate = self;
    [self addSubview:_MDPicker];
    
    
    if(select.tag == 0){
        [_MDPicker setOptions:sizePicker.showOptions : 1 : 0];
    } else if(select.tag == 1){
        [_MDPicker setOptions:cusTodyTimePicker.options : 2 : 1];
    } else if(select.tag == 2){
        [_MDPicker setOptions:destinateTimePicker.options :3 :2];
    } else if(select.tag == 3){
        [_MDPicker setOptions:requestTerm.showOptions :1 :3];
    }
    
    [_MDPicker showView];
}

-(NSString *) getReciveTimeStr {
    NSString *returnStr;
    NSArray *strArr = [[MDCurrentPackage getInstance].at_home_time[0][0] componentsSeparatedByString:@"-"];
    returnStr = [NSString stringWithFormat:@"%d月%d日", [strArr[1] intValue], [strArr[2] intValue]];
    
    returnStr = [NSString stringWithFormat:@"%@ %@時~%@時",returnStr,
                            [MDCurrentPackage getInstance].at_home_time[0][1],
                            [MDCurrentPackage getInstance].at_home_time[0][2]];
    //bug
    return returnStr;
}

-(void) initReciveTimeData {
    
    [self getReciveTimeStr];
    
    NSMutableArray *eightArr = [[NSMutableArray alloc] init];
    realDate = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 14; i ++) {
        NSTimeInterval secondsPerDay = i * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"M月d日"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];
        
//        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
//        [weekFormatter setDateFormat:@"EEEE"];
//        NSString *weekStr = [weekFormatter stringFromDate:curDate];
        
        //server date formate
        NSDateFormatter *serverDateFormatter = [[NSDateFormatter alloc]init];
        [serverDateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *serverStr = [serverDateFormatter stringFromDate:curDate];
        [realDate addObject:serverStr];
        
        //translate to Japanese
        
        //make string
        NSString *strTime = [NSString stringWithFormat:@"%@",dateStr];
        [eightArr addObject:strTime];
    }
    
    date = [NSMutableArray arrayWithArray:eightArr];
    cusTodyTime = [NSMutableArray arrayWithObjects:@"いつでも" , @"10時~12時" , @"12時~14時"
            , @"14時~16時",@"16時~18時", @"18時~20時", @"20時~22時",
            @"22時~24時", @"0時~2時" , @"2時~4時",@"4時~6時",@"6時~8時",@"8時~10時", nil];
}

-(NSString *) getInitStr {
    
    NSString *showStr;
    NSArray *tmpStr = [[MDCurrentPackage getInstance].deliver_limit componentsSeparatedByString:@" "];
    NSString *dateStr = tmpStr[0];
    NSArray *dateStrArray = [dateStr componentsSeparatedByString:@"-"];

    NSString *timeStr = tmpStr[1];
    showStr = [NSString stringWithFormat:@"%d月%d日 %@時%@分迄",
                                        [dateStrArray[1] intValue],
                                        [dateStrArray[2] intValue],
                                        [timeStr componentsSeparatedByString:@":"][0],
                                        [timeStr componentsSeparatedByString:@":"][1]];
    return showStr;
}

-(void) initDeliveryLimitData {
    
//    [self getInitStr];
    
    NSMutableArray *eightArr = [[NSMutableArray alloc] init];
    realDate = [[NSMutableArray alloc]init];
    for (int i = 0; i < 14; i ++) {
        NSTimeInterval secondsPerDay = i * 24*60*60;
        NSDate *curDate = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"M月d日"];
        NSString *dateStr = [dateFormatter stringFromDate:curDate];
        
        
        //server date formate
        NSDateFormatter *serverDateFormatter = [[NSDateFormatter alloc]init];
        [serverDateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *serverStr = [serverDateFormatter stringFromDate:curDate];
        [realDate addObject:serverStr];
        
        
        //make string
        NSString *strTime = [NSString stringWithFormat:@"%@",dateStr];
        [eightArr addObject:strTime];
    }
    
    date = [NSMutableArray arrayWithArray:eightArr];
    destinateTime = [NSMutableArray arrayWithObjects:@"01時",@"02時",@"03時",@"04時",@"05時",@"06時",@"07時",@"08時",@"09時",@"10時",@"11時",@"12時",@"13時",@"14時",@"15時",@"16時",@"17時",@"18時",@"19時",@"20時",@"21時",@"22時",@"23時",@"00時", nil];
    destinateMinute = [[NSMutableArray alloc]init];
    for(int i = 0; i < 60;i++){
        [destinateMinute addObject:(i < 10) ? [NSString stringWithFormat:@"0%d分",i] :  [NSString stringWithFormat:@"%d分",i]];
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
    if(requestButton.selectLabel.text.length > 0){
        result = @"預かり先";
    } else if(destinationButton.selectLabel.text.length > 0){
        result = @"お届け先";
    } else {
        result = @"";
    }
    return result;
}

#pragma UIScrollview delegate
// scrollView 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    for (UIView *view in [scrollView subviews]) {
        if([view isKindOfClass:[MDInput class]]){
            MDInput *tmpView = (MDInput *)view;
            [tmpView.input resignFirstResponder];
        }
    }
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

-(void) showSorryAlert {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"引っ越し機能は近日リリース予定です"
                                                    message:@"お手数をおかけいたしますが、今しばらくお待ちください。"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    alert.delegate = self;
    [alert show];
}

#pragma MDInput delegate
-(void) inputPushed:(MDInput *)input{
    int offset = input.frame.origin.y + input.frame.size.height + 54 - (_scrollView.frame.size.height - 216.0);//键盘高度216
    CGPoint point = CGPointMake(0, offset);
    [_scrollView setContentOffset:point animated:YES];
}

-(void) endInput:(MDInput *)input{
    [MDCurrentPackage getInstance].request_amount = input.input.text;
    [self resizeScrollView];
}

#pragma MDSelect delegate
-(void) buttonPushed:(MDSelect *)view{
    int offset = view.frame.origin.y + view.frame.size.height + 40 - (_scrollView.frame.size.height - 216.0);//键盘高度216
    CGPoint point = CGPointMake(0, offset);
    [_scrollView setContentOffset:point animated:YES];
}

-(void)didClosed {
    
    [self resizeScrollView];
}

-(void) resizeScrollView {
    // 下に空白ができたらスクロールで調整
    int scrollOffset = [_scrollView contentOffset].y;
    int contentBottomOffset = _scrollView.contentSize.height - _scrollView.frame.size.height;
    
    if(contentBottomOffset > 0){
        if(scrollOffset > contentBottomOffset){
            CGPoint point = CGPointMake(0, contentBottomOffset);
            [_scrollView setContentOffset:point animated:YES];
        } else {
            CGPoint point = CGPointMake(0, -64);
            [_scrollView setContentOffset:point animated:YES];
        }
    } else {
        
        CGPoint point = CGPointMake(0, -64);
        [_scrollView setContentOffset:point animated:YES];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    int offset = costPicker.frame.origin.y + costPicker.frame.size.height + 54 - (_scrollView.frame.size.height - 216.0);//键盘高度216
    CGPoint point = CGPointMake(0, offset);
    [_scrollView setContentOffset:point animated:YES];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(![textField.text hasPrefix:@"¥"]){
        textField.text = [NSString stringWithFormat:@"¥%@", textField.text];
    }
    return YES;
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
    
    [self resizeScrollView];
    
    if([textField.text hasPrefix:@"¥"]){
        if([[textField.text substringFromIndex:1] intValue] < 100){
            if([self.delegate respondsToSelector:@selector(amountNotEnough)]){
                textField.text = @"¥100";
                [self.delegate amountNotEnough];
            }
        }
        [MDCurrentPackage getInstance].request_amount = [textField.text substringFromIndex:1];
    } else {
        [MDCurrentPackage getInstance].request_amount = textField.text;
    }
}


#pragma MDPicker
-(void) didSelectedRow:(NSMutableArray *)resultList :(int)tag{
    
    switch (tag) {
        case 0:
            sizePicker.selectLabel.text = [[sizePicker.showOptions objectAtIndex:0] objectAtIndex:[resultList[0][0] integerValue]];
            [MDCurrentPackage getInstance].size = [[sizePicker.options objectAtIndex:0] objectAtIndex:[resultList[0][0] integerValue]];
            break;
        case 1:
//            cusTodyTimePicker.options
            //date
            [MDCurrentPackage getInstance].at_home_time[0][0] = [realDate objectAtIndex:[resultList[0][0] integerValue]];
            cusTodyTimePicker.selectLabel.text = [NSString stringWithFormat:@"%@ %@",
                                                  [[cusTodyTimePicker.options objectAtIndex:0] objectAtIndex:[resultList[0][0] integerValue]],
                                                  [[cusTodyTimePicker.options objectAtIndex:1] objectAtIndex:[resultList[1][0] integerValue]]];
            
            [self convertReciveTimeToSave];
            break;
        case 2:
            destinateTimePicker.selectLabel.text = [NSString stringWithFormat:@"%@ %@%@迄",
                                                    [[destinateTimePicker.options objectAtIndex:0] objectAtIndex:[resultList[0][0] integerValue]],
                                                    [[destinateTimePicker.options objectAtIndex:1] objectAtIndex:[resultList[1][0] integerValue]],
                                                    [[destinateTimePicker.options objectAtIndex:2] objectAtIndex:[resultList[2][0] integerValue]]];
            
            [self convertDestinateTimeToSave:[realDate objectAtIndex:[resultList[0][0] integerValue]]
                                     newHour:[[destinateTimePicker.options objectAtIndex:1] objectAtIndex:[resultList[1][0] integerValue]]
                                   newMinute:[[destinateTimePicker.options objectAtIndex:2] objectAtIndex:[resultList[2][0] integerValue]]];
            [destinateTimePicker setActive];
            
            break;
        case 3:
            requestTerm.selectLabel.text = [[requestTerm.showOptions objectAtIndex:0] objectAtIndex:[resultList[0][0] integerValue]];
            [self convertRequestTermToSave:(NSString *)[[requestTerm.options objectAtIndex:0] objectAtIndex:[resultList[0][0] integerValue]]];
            
            break;
        default:
            break;
    }
    
}

-(void)convertReciveTimeToSave {
    NSArray *cusTodyTimePickerTextArray = [cusTodyTimePicker.selectLabel.text componentsSeparatedByString:@" "];
    NSArray *tmpArray;
    if([cusTodyTimePickerTextArray[1] isEqualToString:@"いつでも"]){
        tmpArray = [NSArray arrayWithObjects:@"0", @"24", nil];
        
        [MDCurrentPackage getInstance].at_home_time[0][1] = tmpArray[0]; //時間 から
        [MDCurrentPackage getInstance].at_home_time[0][2] = tmpArray[1]; //時間 まで
    } else {
        
        tmpArray = [cusTodyTimePickerTextArray[1] componentsSeparatedByString:@"時"];
        [MDCurrentPackage getInstance].at_home_time[0][1] = tmpArray[0]; //時間 から
        [MDCurrentPackage getInstance].at_home_time[0][2] = [tmpArray[1] substringFromIndex:1]; //時間 まで
    }
}

-(void) convertDestinateTimeToSave:(NSString*)newDate newHour:(NSString*)newHour newMinute:(NSString*)newMinute {
    
    NSString *stardardHour = [newHour substringToIndex:2];
    NSString *stardardMinute = [newMinute substringToIndex:2];
    
    [MDCurrentPackage getInstance].deliver_limit = [NSString stringWithFormat:@"%@ %@:%@:00",newDate, stardardHour, stardardMinute];
}

-(void) convertRequestTermToSave:(NSString *)term{
    NSDate *now = [NSDate date];
    //n時間後
    NSDate *nHoursAfter = [now dateByAddingTimeInterval:[term intValue]*60*60];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateFormatter *tmpFormatter = [[NSDateFormatter alloc]init];
    [tmpFormatter setCalendar:gregorianCalendar];
    [tmpFormatter setLocale:[NSLocale systemLocale]];
    [tmpFormatter setDateFormat:@"YYYY-MM-dd HH:mm:00"];
    [MDCurrentPackage getInstance].expire = [tmpFormatter stringFromDate:nHoursAfter];}

-(void) sizeDescriptionButtonTouched {
    if([self.delegate respondsToSelector:@selector(sizeDescriptionButtonPushed)]){
        [self.delegate sizeDescriptionButtonPushed];
    }
}



@end
