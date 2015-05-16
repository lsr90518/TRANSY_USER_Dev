//
//  MDCreditView.h
//  Distribution
//
//  Created by 各務 将士 on 2015/05/13.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MDCreditViewDelegate;

@interface MDCreditView : UIWebView <UIWebViewDelegate>

@property (nonatomic, assign) id<MDCreditViewDelegate> creditDelegate;

@end

@protocol MDCreditViewDelegate <NSObject>

@optional
-(void) hasNoAuthorizedCard;
@end