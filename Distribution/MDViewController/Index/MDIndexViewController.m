//
//  MDIndexViewController.m
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDIndexViewController.h"
#import "MDViewController.h"
#import "MDCreateProfileViewController.h"

@interface MDIndexViewController ()

@end

@implementation MDIndexViewController

- (void) loadView {
    [super loadView];
    UIImageView *backGroundView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [backGroundView setImage:[UIImage imageNamed:@"firstBG"]];
    [self.view addSubview:backGroundView];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"trux_bgvideo_portrait" ofType:@"mp4"];
    NSURL *fileURL = [NSURL fileURLWithPath:filepath];
    self.avPlayer = [AVPlayer playerWithURL:fileURL];
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view.layer addSublayer: layer];
    
    [self.avPlayer play];
    
    self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.avPlayer currentItem]];
    
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

-(void) viewDidAppear:(BOOL)animated{
    MDUser *user = [MDUser getInstance];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    RLMResults *newconsiger = [MDConsignor allObjectsInRealm:realm];
    if([newconsiger count] == 0){
        
        user.phoneNumber = @"";
        user.password = @"";
        [self initIndexView];
        
    } else {
        
        for(MDConsignor *tmp in newconsiger){
            MDUser *user = [MDUser getInstance];
            [user initDataWithConsignor:tmp];
        }
        
        //call login api
        [[MDAPI sharedAPI]loginWithPhone:[MDUser getInstance].phoneNumber
                                password:[MDUser getInstance].password
                              onComplete:^(MKNetworkOperation *complete) {
                                  if([[complete responseJSON][@"code"] intValue] == 0){
                                  
                                      [MDUser getInstance].user_id  = [[complete responseJSON][@"data"][@"id"] intValue];
                                      [MDUser getInstance].phoneNumber = [MDUtil japanesePhoneNumber:[complete responseJSON][@"data"][@"phone"]];
                                      [MDUser getInstance].mailAddress = [complete responseJSON][@"data"][@"mail"];
                                      [MDUser getInstance].userHash = [complete responseJSON][@"hash"];
                                      NSString *username = [complete responseJSON][@"data"][@"name"];
                                      NSArray *nameArray = [username componentsSeparatedByString:@" "];
                                      [MDUser getInstance].lastname = nameArray[0];
                                      [MDUser getInstance].firstname = nameArray[1];
                                      [MDUser getInstance].credit =[[complete responseJSON][@"data"][@"credit"] intValue];
                                      
                                      [[MDUser getInstance] setLogin];
                                      
                                      [self gotoDelivery];
                                  } else {
                                      [self initIndexView];
                                  }
                                  
                              }onError:^(MKNetworkOperation *operation, NSError *error) {
                                  //
                                  NSLog(@"error %@", error);
                              }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initIndexView{
    _indexView = [[MDIndexView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _indexView.delegate = self;
    [self.view addSubview:_indexView];
}

#pragma indexDelegate
-(void)signTouched {
    MDPhoneViewController *phoneViewController = [[MDPhoneViewController alloc]init];
    UINavigationController *signNavigationController = [[UINavigationController alloc]initWithRootViewController:phoneViewController];
    [self presentViewController:signNavigationController animated:YES completion:nil];
}

-(void)loginTouched {
    MDLoginViewController *loginViewController = [[MDLoginViewController alloc]init];
    UINavigationController *loginNavigationController = [[UINavigationController alloc]initWithRootViewController:loginViewController];
    [self presentViewController:loginNavigationController animated:YES completion:nil];
}

-(void) gotoDelivery{
    MDDeliveryViewController *dvc = [[MDDeliveryViewController alloc]init];
    UINavigationController *dvcNavigationController = [[UINavigationController alloc]initWithRootViewController:dvc];
    [self presentViewController:dvcNavigationController animated:NO completion:nil];
//    MDCreateProfileViewController *cpv = [[MDCreateProfileViewController alloc]init];
//    UINavigationController *dvcNavigationController = [[UINavigationController alloc]initWithRootViewController:cpv];
//    [self presentViewController:dvcNavigationController animated:YES completion:nil];
    
}



@end
