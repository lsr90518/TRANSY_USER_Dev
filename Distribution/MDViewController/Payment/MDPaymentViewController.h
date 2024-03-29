//
//  MDPaymentViewController.h
//  Distribution
//
//  Created by 各務 将士 on 2015/04/23.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import "MDWebViewController.h"
#import "CardIO.h"

@interface MDPaymentViewController : MDWebViewController <UIWebViewDelegate, CardIOViewDelegate>

@property (nonatomic) BOOL withCardIO;
@property (nonatomic) CardIOCreditCardInfo *cardInfo;
@property (strong,nonatomic) CardIOView *cardIOView;

-(MDPaymentViewController *) initWithCardIO;
-(void)openPaymentView;
@end
