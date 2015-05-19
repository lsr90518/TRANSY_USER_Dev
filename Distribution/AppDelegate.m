//
//  AppDelegate.m
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "AppDelegate.h"
#import "MDViewController.h"
#import "MDAPI.h"
#import <CoreData/CoreData.h>
#import "MDCustomer.h"
#import "MDSQLManager.h"
#import "MDCustomerDAO.h"
#import "MDConsignor.h"
#import "MDUser.h"
#import "MDDevice.h"
#import "MDCurrentPackage.h"
#import <Crashlytics/Crashlytics.h>
#import <Realm.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Crashlytics startWithAPIKey:@"b3bf459fee27b33c2f19f338b31b00b8e4590f72"];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        // 这里判断是否第一次
        NSLog(@"first time");
    }
    
    
    //notification config
    // プッシュ許可の確認を表示
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1){
        // iOS8以降
        UIUserNotificationType types =  UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [application registerUserNotificationSettings:mySettings];
    }else{
        // iOS8以前
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    
    
    
    //init navigationBar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // NavigationBar Image
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBarBg"] forBarMetrics:UIBarMetricsDefault];
        // Customize the title text for *all* UINavigationBars
        [[UINavigationBar appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset, [UIFont fontWithName:@"Arial-Bold" size:0.0], UITextAttributeFont, nil]];
        
    }else{
        
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBarBg"] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
        // Titles
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                               [UIColor whiteColor],
                                                               UITextAttributeTextColor,
                                                               [UIFont fontWithName:@"HiraKakuProN-W6" size:16],
                                                               UITextAttributeFont,
                                                               nil]];
    }
    
    [self configure];
//    [[NSFileManager defaultManager] removeItemAtPath:[RLMRealm defaultRealmPath] error:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.indexViewController = [[MDIndexViewController alloc] init];
    self.window.rootViewController = self.indexViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

// iOS8以降ここを通る
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings{
    // これ呼ばないとデバイストークン取得できない
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // デバイストークン取得完了
    
    NSString *token = deviceToken.description;
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [MDDevice getInstance].token = token;
    NSLog(@"token %@", [MDDevice getInstance].token);
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    // APNSへの登録失敗
}

-(void) configure {
    //open api
    MDAPI *api = [[MDAPI alloc]init];
    [self checkIOS7];
}

- (void)checkIOS7
{
    NSArray  *aOsVersions = [[[UIDevice currentDevice]systemVersion] componentsSeparatedByString:@"."];
    NSInteger iOsVersionMajor  = [[aOsVersions objectAtIndex:0] intValue];
    if (iOsVersionMajor == 7)
    {
        [MDDevice getInstance].iosVersion = @"7";
    } else {
        [MDDevice getInstance].iosVersion = @"8";
    }
}

-(void)initDB {
    MDCustomerDAO   *customerDAO = [[MDCustomerDAO alloc]init];
    [customerDAO deleteCustomer];
}

@end
