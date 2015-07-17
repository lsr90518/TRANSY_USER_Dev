//
//  MDIndexViewController.m
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDIndexViewController.h"

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
                                      
                                      [self goToMainView:self];
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
    [self initOpeningMovie];
    _indexView = [[MDIndexView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _indexView.delegate = self;
    [self.view addSubview:_indexView];
}

-(void) initOpeningMovie{
    if(self.avPlayer)return;
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
- (void) releaseOpeningMovie{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.avPlayer pause];
    self.avPlayer = nil;
}

#pragma indexDelegate
-(void)signTouched {
    _signNav = [[MDSignUpNavigationController alloc] init];
    _signNav.sign_delegate = self;
    [self presentViewController:_signNav animated:YES completion:nil];
}

-(void)loginTouched {
    MDLoginViewController *loginViewController = [[MDLoginViewController alloc]init];
    loginViewController.delegate = self;
    _loginNav = [[UINavigationController alloc]initWithRootViewController:loginViewController];
    [self presentViewController:_loginNav animated:YES completion:nil];
}

-(void) goToMainView:(UIViewController *)viewController {
    [self releaseOpeningMovie];
    _mdMainNavigationController = [[MDMainNavigationController alloc]init];
    _mdMainNavigationController.main_delegate = self;
    if([viewController.navigationController isKindOfClass:[MDSignUpNavigationController class]]){
        [viewController presentViewController:_mdMainNavigationController animated:YES completion:^{
            [viewController.navigationController popToRootViewControllerAnimated:NO];
        }];
    }else{
        [viewController presentViewController:_mdMainNavigationController animated:YES completion:nil];
    }
}

-(void) closeAllView {
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
