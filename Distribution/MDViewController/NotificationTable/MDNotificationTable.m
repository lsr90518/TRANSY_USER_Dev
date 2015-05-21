//
//  MDNotificationTable.m
//  Distribution
//
//  Created by 劉 松然 on 2015/05/20.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import "MDNotificationTable.h"
#import "MDNotificationTableCell.h"

@implementation MDNotificationTable

-(void) loadView{
    [super loadView];
    self.tableView.separatorStyle = NO;
    [self initNavigationBar];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.header.updatedTimeHidden = YES;
    
    if([_notificationList count] == 0){
        UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 15)];
        messageLabel.text = @"これ以上通知がありません。";
        messageLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.textColor = [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1];
        [self.view addSubview:messageLabel];
    
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    NSString *text = [_notificationList objectAtIndex:indexPath.row];
//    NSString *text = @"これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、これはテストで、";
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 84, 100)];
    contentLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
    contentLabel.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    contentLabel.attributedText = attributedString;
    [contentLabel sizeToFit];
    
    return contentLabel.frame.size.height + 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MDNotificationTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"notificationCell"];
    
    if (cell == nil) {
        cell = [[MDNotificationTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"notificationCell"];
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
    
    //
//    MDRequestDetailViewController *rdvc = [[MDRequestDetailViewController alloc]init];
//    rdvc.package = [_completePakcageList objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:rdvc animated:YES];
}

-(void) loadNewData{
    [self.tableView.header endRefreshing];
}

@end
