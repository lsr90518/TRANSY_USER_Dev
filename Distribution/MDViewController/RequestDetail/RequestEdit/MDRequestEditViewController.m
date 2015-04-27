//
//  MDRequestEditViewController.m
//  Distribution
//
//  Created by Lsr on 4/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDRequestEditViewController.h"
#import "MDRequestEditNoteViewController.h"

@interface MDRequestEditViewController () {
    MDSelect *beCarefulPicker;
    MDSelect *requestTerm;
    
    NSMutableArray *options;
}

@end

@implementation MDRequestEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) loadView {
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    beCarefulPicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, 74, self.view.frame.size.width-20, 50)];
    beCarefulPicker.buttonTitle.text = @"取扱説明書";
    [beCarefulPicker setUnactive];
    [beCarefulPicker addTarget:self action:@selector(editNote) forControlEvents:UIControlEventTouchUpInside];
//    [beCarefulPicker setReadOnly];
    [self.view addSubview:beCarefulPicker];
    
    //list
    requestTerm = [[MDSelect alloc]initWithFrame:CGRectMake(10, beCarefulPicker.frame.origin.y + beCarefulPicker.frame.size.height + 10, self.view.frame.size.width-20, 50)];
    requestTerm.buttonTitle.text = @"依頼期限";
    [requestTerm.rightArrow setHidden:YES];
    requestTerm.options = [[NSArray alloc]initWithObjects:@"3",@"6",@"9",@"12",@"15",@"18",@"21",@"24", nil];
    [requestTerm addTarget:self action:@selector(showExpireView:) forControlEvents:UIControlEventTouchUpInside];
//    [requestTerm setReadOnly];
    [self.view addSubview:requestTerm];
    
    [self initData];
    [self initNavigationBar];
}

-(void) initData {
    
    //依頼期限
    NSDate * now = [NSDate date];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSLocale systemLocale]];
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:00"];
    NSDate *expireDate =[dateFormat dateFromString:_data[@"expire"]];
    NSTimeInterval timeBetween = [expireDate timeIntervalSinceDate:now];
    int hour = timeBetween/60/60;
    requestTerm.selectLabel.text = [NSString stringWithFormat:@"%d時間以内",hour+1];
    
    //説明書
    beCarefulPicker.selectLabel.text = _data[@"note"];
}

-(void)initNavigationBar {
    
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonPushed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setData:(NSDictionary *)data{
    _data = data;
}

-(void) backButtonPushed {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) editNote{
    
    MDRequestEditNoteViewController *renvc = [[MDRequestEditNoteViewController alloc]init];
    [renvc setContentText:_data[@"note"]];
    [self.navigationController pushViewController:renvc animated:YES];
}

-(void) showExpireView:(MDSelect *)button{
    if(options == nil){
        options = [[NSMutableArray alloc]init];
    }
    [options removeAllObjects];
    [options addObjectsFromArray:button.options];
    
    UIPickerView * pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(-2, self.view.frame.size.height, self.view.frame.size.width + 4, 500)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.layer.borderColor = [UIColor colorWithRed:226.0/255.0 green:138.0/255.0 blue:0 alpha:1].CGColor;
    pickerView.layer.borderWidth = 2.0;
    pickerView.tag = 3;
    
    [self.view addSubview:pickerView];
    
    [UIView animateWithDuration:0.3f
                     animations:^{
                         [pickerView setFrame:CGRectMake(-2, self.view.frame.size.height - pickerView.frame.size.height + 2, self.view.frame.size.width+4, 500)];
                     }];
    
}

#pragma UIPicker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    int componentCount = 0;
    if(pickerView.tag == 3){
        componentCount = 1;
    }
    return componentCount;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [options count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component {
    
    return [NSString stringWithFormat:@"%@時間以内",options[row]];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //input to mdcurrent
    NSLog(@"%@", [options objectAtIndex:row]);
    
    NSDate *now = [NSDate date];
    //4時間後
    NSDate *nHoursAfter = [now dateByAddingTimeInterval:[[options objectAtIndex:row] intValue]*60*60];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateFormatter *tmpFormatter = [[NSDateFormatter alloc]init];
    [tmpFormatter setCalendar:gregorianCalendar];
    [tmpFormatter setDateFormat:@"YYYY-MM-dd HH:mm:00"];
    [_data setValue:[tmpFormatter stringFromDate:nHoursAfter] forKey:@"expire"];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component {
    return self.view.frame.size.width;
}


@end
