//
//  MDRecieveTimeViewController.m
//  Distribution
//
//  Created by Lsr on 4/16/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDRecieveTimeViewController.h"
#import "MDCurrentPackage.h"
#import "MDInput.h"

@interface MDRecieveTimeViewController ()<UIPickerViewDataSource, UIPickerViewDelegate> {
    UIPickerView *dataPicker;
    NSMutableArray* time;
    NSMutableArray* date;
    NSMutableArray* realDate;
    MDInput *dateInput;
    MDInput *timeInput;
}

@end

@implementation MDRecieveTimeViewController

- (void) loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    dateInput = [[MDInput alloc]initWithFrame:CGRectMake(10, self.view.frame.origin.y+74, self.view.frame.size.width-20, 50)];
    dateInput.title.text = @"在宅日付";
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
    self.navigationItem.title = @"預かり時間";
    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    
}

-(void) initStr {
    NSArray *strArr = [[MDCurrentPackage getInstance].at_home_time[0][0] componentsSeparatedByString:@"-"];
    dateInput.input.text = [NSString stringWithFormat:@"%d月%d日", [strArr[1] intValue], [strArr[2] intValue]];
    
    timeInput.input.text = [NSString stringWithFormat:@"%@時-%@時",
                            [MDCurrentPackage getInstance].at_home_time[0][1],
                            [MDCurrentPackage getInstance].at_home_time[0][2]];
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
    return [time objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component
{
    //input to mdcurrent
    if(component == 0){
//        NSArray* tmp = date;
//        NSString *title = @"日付";
        dateInput.input.text = [date objectAtIndex:row];
        
        [realDate objectAtIndex:row];
        
        [MDCurrentPackage getInstance].at_home_time[0][0] = [realDate objectAtIndex:row];
        
    } else {
        NSArray *tmp = time;
        timeInput.input.text = [tmp objectAtIndex:row];
        NSArray *tmpArray;
        if([[tmp objectAtIndex:row] isEqualToString:@"いつでも"]){
            tmpArray = [NSArray arrayWithObjects:@"0", @"24", nil];
        } else {
            tmpArray = [[tmp objectAtIndex:row] componentsSeparatedByString:@"時"];
        }
        
        [MDCurrentPackage getInstance].at_home_time[0][1] = tmpArray[0]; //時間 から
        [MDCurrentPackage getInstance].at_home_time[0][2] = tmpArray[1]; //時間 まで
        
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
