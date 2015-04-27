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
    
    NSMutableArray *options;
    NSMutableArray* time;
    NSMutableArray* realDate;
    NSMutableArray* date;
    NSMutableArray* minute;
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
        
        
        destinationButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 149, frame.size.width-20, 50)];
        [destinationButton setBackgroundColor:[UIColor whiteColor]];
        destinationButton.buttonTitle.text = @"お届け先";
        destinationButton.selectLabel.text = @"〒";
        [destinationButton addTarget:self action:@selector(gotoDestinationAddressView) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:destinationButton];
        
        
        
        //list
        sizePicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, 210, frame.size.width-20, 50)];
        sizePicker.buttonTitle.text = @"サイズ";
        sizePicker.selectLabel.text = @"120";
        sizePicker.options = [[NSArray alloc]initWithObjects:@"60",@"80",@"100",@"120",@"140",@"160",@"180",@"200",@"220",@"240",@"260",@"相談", nil];
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
        [beCarefulPicker addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:beCarefulPicker];
        
        //list
        costPicker = [[MDInput alloc]initWithFrame:CGRectMake(10, 330, frame.size.width-20, 50)];
        costPicker.title.text = @"依頼金額";
        [costPicker.title sizeToFit];
        costPicker.input.text = @"1400";
        costPicker.delegate = self;
        [costPicker.input setKeyboardType:UIKeyboardTypeNumberPad];
        [_scrollView addSubview:costPicker];
        
        //list
        cusTodyTimePicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, 390, frame.size.width-20, 50)];
        cusTodyTimePicker.buttonTitle.text = @"預かり時刻";
        cusTodyTimePicker.selectLabel.text = @"いつでも";
        cusTodyTimePicker.tag = 1;
        [cusTodyTimePicker addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:cusTodyTimePicker];
        
        //list
        destinateTimePicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, 450, frame.size.width-20, 50)];
        destinateTimePicker.buttonTitle.text = @"お届け期限";
        destinateTimePicker.tag = 2;
        [destinateTimePicker addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:destinateTimePicker];
        
        
        
        //list
        requestTerm = [[MDSelect alloc]initWithFrame:CGRectMake(10, 510, frame.size.width-20, 50)];
        requestTerm.buttonTitle.text = @"依頼期限";
        requestTerm.options = [[NSArray alloc]initWithObjects:@"3",@"6",@"9",@"12",@"15",@"18",@"21",@"24", nil];
        [requestTerm addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        requestTerm.tag = 3;
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
        
        
        //pickerView
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(-2, frame.size.height, frame.size.width + 4, 216)];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:138.0/255.0 blue:0 alpha:1].CGColor;
        _pickerView.layer.borderWidth = 2.0;
        _pickerView.tag = 0;
        
        [self addSubview:_pickerView];
        
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
        [requestButton setUnactive];
    } else {
        [requestButton setActive];
    }
    if([MDCurrentPackage getInstance].to_zip.length < 1) {
        [MDCurrentPackage getInstance].to_zip = @"";
        [destinationButton setUnactive];
    } else {
        [destinationButton setActive];
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
    costPicker.input.text = [NSString stringWithFormat:@"%@",[MDCurrentPackage getInstance].request_amount];
    //at home time;
    NSArray *dateStr = [[MDCurrentPackage getInstance].at_home_time[0][0] componentsSeparatedByString:@"-"];
    cusTodyTimePicker.selectLabel.text = [NSString stringWithFormat:@"%d月%d日 %@時-%@時", [dateStr[1] intValue], [dateStr[2] intValue], [MDCurrentPackage getInstance].at_home_time[0][1],[MDCurrentPackage getInstance].at_home_time[0][2]];
    
//    destinateTimePicker.selectLabel.text = [NSString stringWithFormat:@"%@時", [[MDCurrentPackage getInstance].deliver_limit substringToIndex:13]];
    destinateTimePicker.selectLabel.text = [self getInitStr];
    
    //expire
    [self setExpireTime:[MDCurrentPackage getInstance].expire];
    
}

-(void) setExpireTime:(NSString *)expire{
    NSDate * now = [NSDate date];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSLocale systemLocale]];
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:00"];
    NSDate *expireDate =[dateFormat dateFromString:expire];
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
    if(select.tag == 3){
    //init data
        [options removeAllObjects];
        [options addObjectsFromArray:select.options];
    } else if(select.tag == 2){
        [self initDeliveryLimitData];
    } else {
        [self initReciveTimeData];
    }
    //reload view;
    _pickerView.tag = select.tag;
    [_pickerView reloadAllComponents];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         [_pickerView setFrame:CGRectMake(-2, self.frame.size.height - _pickerView.frame.size.height + 2, self.frame.size.width+4, 216)];
                     }];
    
}

-(NSString *) getReciveTimeStr {
    NSString *returnStr;
    NSArray *strArr = [[MDCurrentPackage getInstance].at_home_time[0][0] componentsSeparatedByString:@"-"];
    returnStr = [NSString stringWithFormat:@"%d月%d日", [strArr[1] intValue], [strArr[2] intValue]];
    
    returnStr = [NSString stringWithFormat:@"%@ %@時%@時",returnStr,
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
        
        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init];
        [weekFormatter setDateFormat:@"EEEE"];
        NSString *weekStr = [weekFormatter stringFromDate:curDate];
        
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
    time = [NSMutableArray arrayWithObjects:@"いつでも" , @"10時-12時" , @"12時-14時"
            , @"14時-16時",@"16時-18時", @"18時-20時", @"20時-22時",
            @"22時-24時", @"0時-2時" , @"2時-4時",@"4時-6時",@"6時-8時",@"8時-10時", nil];
}

-(NSString *) getInitStr {
    
    NSString *showStr;
    NSArray *tmpStr = [[MDCurrentPackage getInstance].deliver_limit componentsSeparatedByString:@" "];
    NSString *dateStr = tmpStr[0];
    NSArray *dateStrArray = [dateStr componentsSeparatedByString:@"-"];
//    dateInput.input.text = [NSString stringWithFormat:@"%d月%d日",
//                            [dateStrArray[1] intValue],
//                            [dateStrArray[2] intValue]];
    NSString *timeStr = tmpStr[1];
//    timeInput.input.text = [NSString stringWithFormat:@"%@時", [timeStr componentsSeparatedByString:@":"][0]];
//    minuteInput.input.text = [NSString stringWithFormat:@"%@分", [timeStr componentsSeparatedByString:@":"][1]];
    showStr = [NSString stringWithFormat:@"%d月%d日 %@:%@",
                                        [dateStrArray[1] intValue],
                                        [dateStrArray[2] intValue],
                                        [timeStr componentsSeparatedByString:@":"][0],
                                        [timeStr componentsSeparatedByString:@":"][1]];
    return showStr;
}

-(void) initDeliveryLimitData {
    
    [self getInitStr];
    
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
    time = [NSMutableArray arrayWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"00", nil];
    minute = [[NSMutableArray alloc]init];
    for(int i = 0; i < 60;i++){
        [minute addObject:(i < 10) ? [NSString stringWithFormat:@"0%d",i] :  [NSString stringWithFormat:@"%d",i]];
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
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    for (UIView *view in [scrollView subviews]) {
        if([view isKindOfClass:[MDInput class]]){
            MDInput *tmpView = view;
            [tmpView.input resignFirstResponder];
        }
    }
    [UIView animateWithDuration:0.3f
                     animations:^{
                         [_pickerView setFrame:CGRectMake(-2, self.frame.size.height, self.frame.size.width+4, 216)];
                     }];
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
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"引っ越し"
                                                    message:@"引っ越しは近日リリース予定です。お手数をおかけしますが、今しばらくお待ち下さい。"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    alert.delegate = self;
    [alert show];
}

#pragma MDInput delegate
-(void) inputPushed:(MDInput *)input{
    int offset = input.frame.origin.y + input.frame.size.height + 60 - (_scrollView.frame.size.height - 216.0);//键盘高度216
    CGPoint point = CGPointMake(0, offset);
    [_scrollView setContentOffset:point animated:YES];
}

-(void) endInput:(MDInput *)input{
    [MDCurrentPackage getInstance].request_amount = input.input.text;
    NSLog(@"%@", [MDCurrentPackage getInstance].request_amount);
}

#pragma UIPicker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    int componentCount = 0;
    switch (pickerView.tag) {
        case 3:
            componentCount = 1;
            break;
        case 2:
            componentCount = 3;
            break;
        case 1:
            componentCount = 2;
            break;
        default:
            break;
    }
    if(pickerView.tag == 3){
        componentCount = 1;
    }
    return componentCount;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView.tag == 3){
        return [options count];
    } else if(pickerView.tag == 2){
        if (component == 0) {
            return date.count;
        } else if(component == 1){
            return time.count;
        } else {
            return minute.count;
        }
    } else {
        if (component == 0) {
            return date.count;
        }
        return time.count;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component {
    NSString *returnStr;
    switch (pickerView.tag) {
        case 3:
            returnStr = [NSString stringWithFormat:@"%@時間以内",options[row]];
            break;
        case 2:
            if (component == 0) {
                return [date objectAtIndex:row];
            } else if(component == 1) {
                return [NSString stringWithFormat:@"%@時",[time objectAtIndex:row]];
            } else {
                return [NSString stringWithFormat:@"%@分",[minute objectAtIndex:row]];
            }
            break;
        case 1:
            if (component == 0) {
                return [date objectAtIndex:row];
            }
            return [time objectAtIndex:row];
            break;
        default:
            break;
    }
    return returnStr;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //input to mdcurrent
    
    if (pickerView.tag == 3) {
        requestTerm.selectLabel.text = [NSString stringWithFormat:@"%@時間以内",options[row]];
        [MDCurrentPackage getInstance].expire = [[MDUtil getInstance] getAnHourAfterDate:[options objectAtIndex:row]];
    } else if(pickerView.tag == 2){
        //input to mdcurrent
        //お届け期限
        if(component == 0){
            
            NSString *oldTime = [[MDCurrentPackage getInstance].deliver_limit componentsSeparatedByString:@" "][1];
            NSString *newDeliveryStr = [NSString stringWithFormat:@"%@ %@",[realDate objectAtIndex:row], oldTime];
            [MDCurrentPackage getInstance].deliver_limit = newDeliveryStr;
            
        } else if(component == 1) {
            
            //make string
            NSString *oldDate = [[MDCurrentPackage getInstance].deliver_limit componentsSeparatedByString:@" "][0];
            NSString *oldTime = [[MDCurrentPackage getInstance].deliver_limit componentsSeparatedByString:@" "][1];
            NSString *oldMinute = [oldTime componentsSeparatedByString:@":"][1];
            NSString *newDeliveryStr = [NSString stringWithFormat:@"%@ %@:%@:00",oldDate, [time objectAtIndex:row], oldMinute];
            [MDCurrentPackage getInstance].deliver_limit = newDeliveryStr;
        } else {
            NSString *oldDate = [[MDCurrentPackage getInstance].deliver_limit componentsSeparatedByString:@":"][0];
            NSString *newDeliveryStr = [NSString stringWithFormat:@"%@:%@:00",oldDate, [minute objectAtIndex:row]];
            [MDCurrentPackage getInstance].deliver_limit = newDeliveryStr;
        }
        NSLog(@"%@", [MDCurrentPackage getInstance].deliver_limit);
        destinateTimePicker.selectLabel.text = [self getInitStr];
    } else {
        if(component == 0){
            //        NSArray* tmp = date;
            //        NSString *title = @"日付";
//            dateInput.input.text = [date objectAtIndex:row];
            
            [realDate objectAtIndex:row];
            
            [MDCurrentPackage getInstance].at_home_time[0][0] = [realDate objectAtIndex:row];
            
        } else {
            NSArray *tmp = time;
//            timeInput.input.text = [tmp objectAtIndex:row];
            NSArray *tmpArray;
            if([[tmp objectAtIndex:row] isEqualToString:@"いつでも"]){
                tmpArray = [NSArray arrayWithObjects:@"0", @"24", nil];
            } else {
                tmpArray = [[tmp objectAtIndex:row] componentsSeparatedByString:@"時"];
            }
            
            [MDCurrentPackage getInstance].at_home_time[0][1] = tmpArray[0]; //時間 から
            [MDCurrentPackage getInstance].at_home_time[0][2] = tmpArray[1]; //時間 まで
            
        }
        cusTodyTimePicker.selectLabel.text = [self getReciveTimeStr];
    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component {
    if(pickerView.tag == 3){
        return self.frame.size.width;
    } else if(pickerView.tag == 2){
        if (component == 0) {
            return self.frame.size.width/3;
        } else if(component == 1) {
            return self.frame.size.width/3;
        } else {
            return self.frame.size.width/3;
        }
    } else {
        return self.frame.size.width/2;
    }
}

@end
