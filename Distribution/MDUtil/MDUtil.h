//
//  MDUtil.h
//  Distribution
//
//  Created by Lsr on 4/7/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MDUtil : NSObject

typedef NS_ENUM (NSUInteger, viewTagNames) {
    paymentSelect = 1000
};


+(MDUtil *)getInstance;

+(NSString *)internationalPhoneNumber:(NSString *)phoneNumber;
+(NSString *)japanesePhoneNumber:(NSString *)phoneNumber;
+(NSString *)getAnHourAfterDate:(NSString *)expire;

+(NSDate *)getLocalDateTimeFromString:(NSString *)datetime utc:(BOOL)utc;
+(NSString *)getLocalDateTimeStrFromString:(NSString *)datetime format:(NSString *)format;

+(NSString *)getUTCDateTimeStr:(NSString *)datetime;
+(NSDate *)getUTCDate;

+(NSString *)getPaymentSelectLabel;
+(float)getPaymentSelectLabelAlpha;
+(UIColor *)getPaymentButtonBackground;


+(float) getOSVersion;

// 1ボタンアラートの生成
// 指定のviewControllerをUIAlertViewのdelegateとして扱う(iOS8以上でも同じ動作にしてある)
+(void) makeAlertWithTitle: (NSString *)title message: (NSString *)message done:(NSString *)done viewController:(UIViewController *)viewController;

@end
