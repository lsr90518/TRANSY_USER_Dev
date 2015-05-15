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
#import "MDUser.h"
#import "MDDevice.h"
#import "MDCurrentPackage.h"
#import <Crashlytics/Crashlytics.h>

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
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[MDIndexViewController alloc] init];
    self.window.rootViewController = self.viewController;
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

-(void) configure {
    //core data
    //open api
    
    MDSQLManager *sqlManager = [[MDSQLManager alloc]init];
    [sqlManager initCoreData];
    MDAPI *api = [[MDAPI alloc]init];
    MDCurrentPackage *currentPackage = [[MDCurrentPackage alloc]init];
    MDCustomerDAO   *customerDAO = [[MDCustomerDAO alloc]init];
    
    MDUser *customer = [customerDAO findCustomer];
    [customer initDataClear];
    
    [self checkIOS7];
    NSLog(@"%@",[MDDevice getInstance].iosVersion);
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
