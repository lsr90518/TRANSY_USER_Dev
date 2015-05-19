//
//  MDLocalNotificationManager.m
//  Distribution
//
//  Created by 各務 将士 on 2015/05/19.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import "MDLocalNotificationManager.h"

@implementation MDLocalNotificationManager
#pragma mark - Scheduler
- (void)scheduleLocalNotifications {
    // 一度通知を全てキャンセルする
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    // 通知を設定していく...
    [self schedulePackageWork];
}

- (void)schedulePackageWork {
    if(![MDUser getInstance].isLogin)return;
    // makeNotification: を呼び出して通知を登録する
    MDPackageService *packageService = [MDPackageService alloc];
    [[MDAPI sharedAPI] getMyPackageWithHash:[MDUser getInstance].userHash
                                 OnComplete:^(MKNetworkOperation *complete){
                                     if([[complete responseJSON][@"code"] integerValue] == 0){
                                         //
                                         [packageService initDataWithArray:[complete responseJSON][@"Packages"] SortByDate:YES];
                                         for (MDPackage *package in packageService.packageList){
                                              // NSLog(@"expire: %@",[MDUtil getLocalDateTimeStrFromString:package.expire format:@"yyyy年MM月dd日 HH時mm分"]);
                                             if([package.status isEqualToString:@"0"]){
                                                 [self makeNotification:[MDUtil getLocalDateTimeFromString:package.expire utc:YES]
                                                              alertBody:@"依頼の掲載期限が切れました。もう一度依頼する場合は、依頼をし直してください。"
                                                               userInfo:[NSDictionary dictionaryWithObjectsAndKeys:package.package_id, @"package_id", nil]];
                                             }
                                             if([package.status isEqualToString:@"1"] && [[[package.at_home_time objectAtIndex:0] objectAtIndex:0] intValue] != -1){
                                                 NSString *time;
                                                 if([[[package.at_home_time objectAtIndex:0] objectAtIndex:1] intValue] == -1)time = [NSString stringWithFormat:@"00:00:00"];
                                                 else time = [NSString stringWithFormat:@"%2d:00:00",[[[package.at_home_time objectAtIndex:0] objectAtIndex:1] intValue]];
                                                 NSDate *home_date = [MDUtil getLocalDateTimeFromString:[NSString stringWithFormat:@"%@ %@",[[package.at_home_time objectAtIndex:0] objectAtIndex:0],time] utc:NO];
                                                 // 2時間前
                                                 [self makeNotification:[home_date initWithTimeInterval:-7200 sinceDate:home_date]
                                                              alertBody:@"預かり時刻が迫っています。預かり先にてドライバーをお待ち下さい。"
                                                               userInfo:[NSDictionary dictionaryWithObjectsAndKeys:package.package_id, @"package_id", nil]];
                                                 // NSLog(@"at home time alert: %@",time);
                                             }
                                             if([package.status isEqualToString:@"2"]){
                                                 [self makeNotification:[MDUtil getLocalDateTimeFromString:package.deliver_limit utc:YES]
                                                              alertBody:@"お届けまでの期限を過ぎました。至急ドライバーに確認し、荷物が届いてない場合や、問題があった場合、ドライバー情報画面より通報してください。"
                                                               userInfo:[NSDictionary dictionaryWithObjectsAndKeys:package.package_id, @"package_id", nil]];
                                             }
                                             if([package.status isEqualToString:@"3"] && ![package.review_limit isEqualToString:@""] && [package.userReview.star isEqualToString:@""]){
                                                 NSDate *review_date = [MDUtil getLocalDateTimeFromString:package.review_limit utc:YES];
                                                 // 3日前
                                                 [self makeNotification:[review_date initWithTimeInterval:-259200 sinceDate:review_date]
                                                              alertBody:@"ドライバー評価を3日以内にしてください。期限を過ぎると自動的に☆5となります。"
                                                               userInfo:[NSDictionary dictionaryWithObjectsAndKeys:package.package_id, @"package_id", nil]];
                                                 // 1日前
                                                 [self makeNotification:[review_date initWithTimeInterval:-86400 sinceDate:review_date]
                                                              alertBody:@"ドライバー評価を1日以内にしてください。期限を過ぎると自動的に☆5となります。"
                                                               userInfo:[NSDictionary dictionaryWithObjectsAndKeys:package.package_id, @"package_id", nil]];
                                                 // 3時間前
                                                 [self makeNotification:[review_date initWithTimeInterval:-10800 sinceDate:review_date]
                                                              alertBody:@"ドライバー評価を3時間以内にしてください。期限を過ぎると自動的に☆5となります。"
                                                               userInfo:[NSDictionary dictionaryWithObjectsAndKeys:package.package_id, @"package_id", nil]];
                                                 // 30分前
                                                 [self makeNotification:[review_date initWithTimeInterval:-1800 sinceDate:review_date]
                                                              alertBody:@"ドライバー評価を30分以内にしてください。期限を過ぎると自動的に☆5となります。"
                                                               userInfo:[NSDictionary dictionaryWithObjectsAndKeys:package.package_id, @"package_id", nil]];
                                             }
                                         }
                                     }
                                 }
                                onError:^(MKNetworkOperation *complete, NSError *error){
                                    NSLog(@"error ------------------------ %@", error);
                                }];
}

#pragma mark - helper
- (void)makeNotification:(NSDate *) fireDate alertBody:(NSString *) alertBody userInfo:(NSDictionary *) userInfo {
    // 現在より前の通知は設定しない
    if (fireDate == nil || [fireDate timeIntervalSinceNow] <= 0) {
        return;
    }
    [self schedule:fireDate alertBody:alertBody userInfo:userInfo];
}

- (void)schedule:(NSDate *) fireDate alertBody:(NSString *) alertBody userInfo:(NSDictionary *) userInfo {
    // ローカル通知を作成する
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    [notification setFireDate:fireDate];
    [notification setTimeZone:[NSTimeZone systemTimeZone]];
    [notification setAlertBody:alertBody];
    [notification setUserInfo:userInfo];
    [notification setSoundName:UILocalNotificationDefaultSoundName];
    [notification setAlertAction:@"Open"];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    NSLog(@"Setting LocalNotification: %@", fireDate);
}
@end
