//
//  MDNotificationTable.m
//  Distribution
//
//  Created by 劉 松然 on 2015/05/20.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import "MDNotificationTable.h"
#import "MDNotificationTableCell.h"
#import "MDRequestDetailViewController.h"
#import "MDPackageService.h"
#import "MDRealmPushNotice.h"
#import "MDNotificationService.h"
#import "MDAPI.h"

@implementation MDNotificationTable

-(void) loadView{
    [super loadView];
    self.tableView.separatorStyle = NO;
    [self initNavigationBar];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.tableView.header.updatedTimeHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDataFromDB];
    
    if([_notificationList count] == 0){
        UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 15)];
        messageLabel.text = @"これ以上通知がありません。";
        messageLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.textColor = [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1];
        [self.view addSubview:messageLabel];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavigationBar {
    self.navigationItem.title = @"通知";
    //add right button item
    UIButton *_backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
    _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    _backButton.frame = CGRectMake(0, 0, 25, 44);
    [_backButton addTarget:self action:@selector(backButtonPushed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}

-(void) backButtonPushed{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return [_notificationList count];
    //    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MDNotifacation *notification = [_notificationList objectAtIndex:indexPath.row];
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 84, 100)];
    contentLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
    contentLabel.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:notification.message];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [notification.message length])];
    contentLabel.attributedText = attributedString;
    [contentLabel sizeToFit];
    
    return contentLabel.frame.size.height + 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MDNotificationTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"notificationCell"];
    
    if (cell == nil) {
        cell = [[MDNotificationTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"notificationCell"];
    } else{
        [cell removeFromSuperview];
    }
    
    return cell;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(MDNotificationTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell setDataWithModel:[_notificationList objectAtIndex:indexPath.row]];
    //    MDNotifacation *noti = [[MDNotifacation alloc]init];
    //    [cell setDataWithModel:noti];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MDNotifacation *notification = [_notificationList objectAtIndex:indexPath.row];
    MDPackage *package = [[MDPackageService getInstance] getPackageByPackageId:notification.package_id];
    MDRequestDetailViewController *rdvc = [[MDRequestDetailViewController alloc]init];
    rdvc.package = package;
    [self.navigationController pushViewController:rdvc animated:YES];
}

-(void) refreshData{
    [self loadNewData];
    [self loadDataFromDB];
    [self.tableView reloadData];
    [self.tableView.header endRefreshing];
}

-(void) loadNewData{
    
    [self updateNotificationData];
}

-(void) loadDataFromDB{
    
    _notificationList = [[NSMutableArray alloc]init];
    
    //get data from db
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *oldNotice = [[MDRealmPushNotice allObjectsInRealm:realm] sortedResultsUsingProperty:@"notification_id" ascending:YES];
    
    for(MDRealmPushNotice *tmpNotice in oldNotice){
        MDNotifacation *notice = [[MDNotifacation alloc]init];
        notice.package_id       = tmpNotice.package_id;
        notice.notification_id  = tmpNotice.notification_id;
        notice.created_time     = tmpNotice.created_time;
        notice.message          = tmpNotice.message;
        [_notificationList addObject:notice];
    }
    
    //sort
    [_notificationList sortUsingComparator:^NSComparisonResult(MDNotifacation *obj1, MDNotifacation *obj2) {
        
        //排序
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
        NSDate *date1 = [dateFormat dateFromString:obj1.created_time];
        NSDate *date2 = [dateFormat dateFromString:obj2.created_time];
        
        NSTimeInterval time1 = [date1 timeIntervalSince1970];
        NSTimeInterval time2 = [date2 timeIntervalSince1970];
        
        
        if (time1 > time2) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
        
    }];
}

-(void) updateNotificationData{
    //get data from db
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *oldNotice = [MDRealmPushNotice allObjectsInRealm:realm];
    
    NSString *lastId;
    
    if([oldNotice count] > 0){
        MDRealmPushNotice *noti = [oldNotice firstObject];
        lastId = noti.notification_id;
    } else {
        lastId = @"0";
    }
    
    [[MDAPI sharedAPI] getNotificationWithHash:[MDUser getInstance].userHash
                                        lastId:lastId
                                    OnComplete:^(MKNetworkOperation *complete) {
                                        if([[complete responseJSON][@"code"] intValue] == 0){
                                            [[MDNotificationService getInstance] initWithDataArray:[complete responseJSON][@"Notifications"]];
                                            
                                            if([[MDNotificationService getInstance].notificationList count] > 0){
                                                //save to realm
                                                [self saveNotiToDB];
                                            }
                                            
                                        }
                                    } onError:^(MKNetworkOperation *operation, NSError *error) {
                                        
                                    }];
}

-(void) saveNotiToDB{
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSMutableArray *noticArray = [[NSMutableArray alloc]init];
    @autoreleasepool {
        [realm beginWriteTransaction];
        
        [[MDNotificationService getInstance].notificationList enumerateObjectsUsingBlock:^(MDNotifacation *obj, NSUInteger idx, BOOL *stop) {
            MDRealmPushNotice *noti = [[MDRealmPushNotice alloc]init];
            
            noti.notification_id        = obj.notification_id;
            noti.package_id             = obj.package_id;
            noti.created_time           = obj.created_time;
            noti.message                = obj.message;
            [noticArray addObject:noti];
            
        }];
        [realm addOrUpdateObjectsFromArray:noticArray];
        [realm commitWriteTransaction];
    }
}

@end
