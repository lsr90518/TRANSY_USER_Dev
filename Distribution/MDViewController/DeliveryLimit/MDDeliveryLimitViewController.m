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
    MDInput *dateInput;
    MDInput *timeInput;
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
    
    timeInput = [[MDInput alloc]initWithFrame:CGRectMake(10, self.view.frame.origin.y+123, self.view.frame.size.width-20, 50)];
    timeInput.title.text = @"時刻";
    [timeInput.title sizeToFit];
    [timeInput.input setUserInteractionEnabled:NO];
    timeInput.input.placeholder = @"時刻";
    
    [self.view addSubview:timeInput];
    dataPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-350, self.view.frame.size.width, 150)];
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
    timeInput.input.text = [NSString stringWithFormat:@"%@時", [tmpStr[1] substringToIndex:2]];
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
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return date.count;
    }
    return time.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [date objectAtIndex:row];
    }
    return [NSString stringWithFormat:@"%@時",[time objectAtIndex:row]];
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
        
    } else {
        timeInput.input.text = [NSString stringWithFormat:@"%@時",[time objectAtIndex:row]];
        
        //make string
        NSString *oldDate = [[MDCurrentPackage getInstance].deliver_limit componentsSeparatedByString:@" "][0];
        NSString *newDeliveryStr = [NSString stringWithFormat:@"%@ %@:00:00",oldDate, [time objectAtIndex:row]];
        [MDCurrentPackage getInstance].deliver_limit = newDeliveryStr;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component
{
    if (component == 0) {
        return self.view.frame.size.width/2;
    }
    return self.view.frame.size.width/2;
}
@end
