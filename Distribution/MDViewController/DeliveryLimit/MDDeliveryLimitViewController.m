//
//  MDDeliveryLimitViewController.m
//  Distribution
//
//  Created by Lsr on 4/16/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDDeliveryLimitViewController.h"
#import "MDCurrentPackage.h"
#import "MDInput.h"

@interface MDDeliveryLimitViewController ()<UIPickerViewDataSource, UIPickerViewDelegate> {
    UIPickerView *dataPicker;
    NSMutableArray* time;
    NSMutableArray* realDate;
    NSMutableArray* date;
    NSMutableArray* minute;
    MDInput *dateInput;
    MDInput *timeInput;
    MDInput *minuteInput;
}

@end

@implementation MDDeliveryLimitViewController

- (void) loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    dateInput = [[MDInput alloc]initWithFrame:CGRectMake(10, self.view.frame.origin.y+74, self.view.frame.size.width-20, 50)];
    dateInput.title.text = @"お届け日付";
    [dateInput.title sizeToFit];
    [dateInput.input setUserInteractionEnabled:NO];
    dateInput.input.placeholder = @"日付";
    [self.view addSubview:dateInput];
    
    timeInput = [[MDInput alloc]initWithFrame:CGRectMake(10, dateInput.frame.origin.y+49, self.view.frame.size.width-20, 50)];
    [timeInput setBackgroundColor:[UIColor whiteColor]];
    timeInput.title.text = @"時刻";
    [timeInput.title sizeToFit];
    [timeInput.input setUserInteractionEnabled:NO];
    timeInput.input.placeholder = @"時刻";
    [self.view addSubview:timeInput];
    
    minuteInput = [[MDInput alloc]initWithFrame:CGRectMake(10, timeInput.frame.origin.y+49, self.view.frame.size.width-20, 50)];
    [minuteInput setBackgroundColor:[UIColor whiteColor]];
    minuteInput.title.text = @"分";
    [minuteInput.title sizeToFit];
    [minuteInput.input setUserInteractionEnabled:NO];
    minuteInput.input.placeholder = @"分";
    [self.view addSubview:minuteInput];
    
    dataPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-300, self.view.frame.size.width, 150)];
    [self.view addSubview:dataPicker];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    dataPicker.dataSource = self;
    dataPicker.delegate = self;
    
    [self initNavigationBar];
}

-(void) initNavigationBar {
    self.navigationItem.title = @"お届け期限";
    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    
}

-(void) initStr {

    NSArray *tmpStr = [[MDCurrentPackage getInstance].deliver_limit componentsSeparatedByString:@" "];
    NSString *dateStr = tmpStr[0];
    NSArray *dateStrArray = [dateStr componentsSeparatedByString:@"-"];
    dateInput.input.text = [NSString stringWithFormat:@"%d月%d日",
                            [dateStrArray[1] intValue],
                            [dateStrArray[2] intValue]];
    NSString *timeStr = tmpStr[1];
    timeInput.input.text = [NSString stringWithFormat:@"%@時", [timeStr componentsSeparatedByString:@":"][0]];
    minuteInput.input.text = [NSString stringWithFormat:@"%@分", [timeStr componentsSeparatedByString:@":"][1]];
}

-(void) initData {
    
    [self initStr];
    
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

-(void) backButtonTouched {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UIPicker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return date.count;
    } else if(component == 1){
        return time.count;
    } else {
        return minute.count;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [date objectAtIndex:row];
    } else if(component == 1) {
        return [NSString stringWithFormat:@"%@時",[time objectAtIndex:row]];
    } else {
        return [NSString stringWithFormat:@"%@分",[minute objectAtIndex:row]];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    
    //input to mdcurrent
    if(component == 0){
        dateInput.input.text = [date objectAtIndex:row];
        
        NSString *oldTime = [[MDCurrentPackage getInstance].deliver_limit componentsSeparatedByString:@" "][1];
        NSString *newDeliveryStr = [NSString stringWithFormat:@"%@ %@",[realDate objectAtIndex:row], oldTime];
        [MDCurrentPackage getInstance].deliver_limit = newDeliveryStr;
        
    } else if(component == 1) {
        timeInput.input.text = [NSString stringWithFormat:@"%@時",[time objectAtIndex:row]];
        
        //make string
        NSString *oldDate = [[MDCurrentPackage getInstance].deliver_limit componentsSeparatedByString:@" "][0];
        NSString *oldTime = [[MDCurrentPackage getInstance].deliver_limit componentsSeparatedByString:@" "][1];
        NSString *oldMinute = [oldTime componentsSeparatedByString:@":"][1];
        NSString *newDeliveryStr = [NSString stringWithFormat:@"%@ %@:%@:00",oldDate, [time objectAtIndex:row], oldMinute];
        [MDCurrentPackage getInstance].deliver_limit = newDeliveryStr;
    } else {
        minuteInput.input.text = [NSString stringWithFormat:@"%@分", [minute objectAtIndex:row]];
        
        NSString *oldDate = [[MDCurrentPackage getInstance].deliver_limit componentsSeparatedByString:@":"][0];
        NSString *newDeliveryStr = [NSString stringWithFormat:@"%@:%@:00",oldDate, [minute objectAtIndex:row]];
        [MDCurrentPackage getInstance].deliver_limit = newDeliveryStr;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component
{
    if (component == 0) {
        return self.view.frame.size.width/3;
    } else if(component == 1) {
        return self.view.frame.size.width/3;
    } else {
        return self.view.frame.size.width/3;
    }
}
@end
