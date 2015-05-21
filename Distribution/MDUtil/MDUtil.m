//
//  MDUtil.m
//  Distribution
//
//  Created by Lsr on 4/7/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDUtil.h"
#import "MDUser.h"
#import <Security/Security.h>

@implementation MDUtil

+(MDUtil *)getInstance {
    static MDUtil *sharedInstance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[MDUtil alloc] init];
    });
    return sharedInstance;
}

+(NSString *)internationalPhoneNumber:(NSString *)phoneNumber {
    if ( ![[phoneNumber substringToIndex:3] isEqualToString:@"+81"] ) {
        NSString *tmpNumber = [NSString stringWithFormat:@"+81%@",[phoneNumber substringFromIndex:1]];
        phoneNumber = tmpNumber;
    }
    
    return phoneNumber;
}

+(NSString *)japanesePhoneNumber:(NSString *)phoneNumber {
    if(phoneNumber.length > 0){
        if ( [[phoneNumber substringToIndex:3] isEqualToString:@"+81"] ) {
            NSString *tmpNumber = [NSString stringWithFormat:@"0%@",[phoneNumber substringFromIndex:3]];
            phoneNumber = tmpNumber;
        }
    }
    
    return phoneNumber;
}

+(NSString *)getAnHourAfterDate:(NSString *)expire{
    NSDate *now = [NSDate date];
    //4時間後
    NSDate *nHoursAfter = [now dateByAddingTimeInterval:[expire intValue]*60*60];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateFormatter *tmpFormatter = [[NSDateFormatter alloc]init];
    [tmpFormatter setCalendar:gregorianCalendar];
    [tmpFormatter setDateFormat:@"YYYY-MM-dd HH:mm:00"];
    return [tmpFormatter stringFromDate:nHoursAfter];
}

+(NSString *)getPaymentSelectLabel {
    MDUser *user = [MDUser getInstance];
    [user initDataClear];
    if(user.credit == 0){
        return @"新規登録";
    }else if(user.credit == 1){
        return @"認証済みのカード";
    }else{
        return @"";     // web view
    }
}
+(float)getPaymentSelectLabelAlpha {
    MDUser *user = [MDUser getInstance];
    [user initDataClear];
    if(user.credit == 0){
        return 1.0f;
    }else if(user.credit == 1){
        return 1.0f;
    }else{
        return 0.0f;     // web view
    }
}
+(UIColor *)getPaymentButtonBackground {
    MDUser *user = [MDUser getInstance];
    [user initDataClear];
    if(user.credit == 0){
        return [UIColor whiteColor];
    }else if(user.credit == 1){
        return [UIColor whiteColor];
    }else{
        return [UIColor clearColor];     // web view
    }
}

+(float)getOSVersion {
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+(void)makeAlertWithTitle:(NSString *)title message:(NSString *)message done:(NSString *)done viewController:(UIViewController *)viewController{
    if([self getOSVersion] < 8.0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:viewController
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:done, nil];
        [alertView show];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:done style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // ボタンが押された時の処理
            if([viewController respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]){
                [(UIViewController <UIAlertViewDelegate> *)viewController alertView:nil clickedButtonAtIndex:0];
            }
        }]];
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
}

+(NSDate *)getLocalDateTimeFromString:(NSString *)datetime utc:(BOOL)utc{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 文字列からNSDateオブジェクトを生成
    NSDate *fromFormatDate = [dateFormatter dateFromString: datetime];
    if(utc)return [fromFormatDate initWithTimeInterval:[[NSTimeZone systemTimeZone] secondsFromGMT] sinceDate:fromFormatDate];
    else return fromFormatDate;
}
+(NSString *)getLocalDateTimeStrFromString:(NSString *)datetime format:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: format];
    return [dateFormatter stringFromDate:[self getLocalDateTimeFromString:datetime utc:YES]];
}

+(NSString *)getUTCDateTimeStr:(NSString *)datetime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 文字列からNSDateオブジェクトを生成
    NSDate *fromFormatDate = [dateFormatter dateFromString: datetime];
    NSDate *utcDate = [fromFormatDate initWithTimeInterval:(-3600*90) sinceDate:fromFormatDate];
    return [dateFormatter stringFromDate:utcDate];
}

+(NSDate *) getUTCDate {
    return [NSDate dateWithTimeIntervalSinceNow:(60*60*9)];
}

@end
