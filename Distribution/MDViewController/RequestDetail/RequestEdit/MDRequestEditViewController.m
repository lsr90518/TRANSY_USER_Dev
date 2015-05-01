//
//  MDRequestEditViewController.m
//  Distribution
//
//  Created by Lsr on 4/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDRequestEditViewController.h"
#import "MDRequestEditNoteViewController.h"
#import "MDPicker.h"
#import <SVProgressHUD.h>
#import "MDAPI.h"

@interface MDRequestEditViewController () {
    MDSelect *beCarefulPicker;
    MDSelect *requestTerm;
    MDPicker *picker;
    
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
    //list
    requestTerm = [[MDSelect alloc]initWithFrame:CGRectMake(10, beCarefulPicker.frame.origin.y + beCarefulPicker.frame.size.height + 10, self.view.frame.size.width-20, 50)];
    requestTerm.buttonTitle.text = @"掲載期限";
    requestTerm.delegate = self;
    //        requestTerm.options = [[NSArray alloc]initWithObjects:@"3",@"6",@"9",@"12",@"15",@"18",@"21",@"24", nil];
    NSMutableArray *requestTermOptions = [[NSMutableArray alloc]init];
    NSMutableArray *requestTermFirstOptions = [[NSMutableArray alloc]initWithObjects:@"0.5",@"1",@"3",@"6",@"12",@"24",@"72", nil];
    [requestTermOptions addObject:requestTermFirstOptions];
    [requestTerm setOptions:requestTermOptions :@"" :@"時間以内"];
    requestTerm.tag = 3;
    [requestTerm addTarget:self action:@selector(showPickerView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:requestTerm];
    
    
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

-(void) viewWillAppear:(BOOL)animated{
    [self initData];
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

-(void) backButtonPushed {
    //call API
    [SVProgressHUD show];
    [[MDAPI sharedAPI] editMyPackageWithHash:[MDUser getInstance].userHash
                                     Package:_data
                                  OnComplete:^(MKNetworkOperation *completeOperation){
                                      [SVProgressHUD dismiss];
                                  } onError:^(MKNetworkOperation *completeOperarion, NSError *error){
                                  }];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) editNote{
    
    MDRequestEditNoteViewController *renvc = [[MDRequestEditNoteViewController alloc]init];
    renvc.data = _data;
//    [renvc setContentText:_data[@"note"]];
    [self.navigationController pushViewController:renvc animated:YES];
}

-(void) showExpireView:(MDSelect *)button{
    if(options == nil){
        options = [[NSMutableArray alloc]init];
    }
    [options removeAllObjects];
    [options addObjectsFromArray:button.options];
}

-(void) showPickerView:(MDSelect *)select {
    
    picker = [[MDPicker alloc]initWithFrame:self.view.frame];
    picker.delegate = self;
    [self.view addSubview:picker];
    
    [picker setOptions:select.showOptions :1 :3];
    [picker showView];
}

#pragma MDPickerDelegate
-(void) didSelectedRow:(NSMutableArray *)resultList :(int)tag{
    requestTerm.selectLabel.text = [[requestTerm.showOptions objectAtIndex:0] objectAtIndex:[resultList[0][0] integerValue]];
    [self convertRequestTermToSave:(NSString *)[[requestTerm.options objectAtIndex:0] objectAtIndex:[resultList[0][0] integerValue]]];
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
    [_data setValue:[tmpFormatter stringFromDate:nHoursAfter] forKey:@"expire"];
}

@end
