//
//  MDReportDriverViewController.h
//  Distribution
//
//  Created by Lsr on 5/10/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDReportDriverViewController : UIViewController<UITextViewDelegate>
@property (strong, nonatomic) UITextView *serviceInputView;
@property (strong, nonatomic) NSString *contentText;
@property (strong, nonatomic) NSString *driver_id;

-(void) setText:(NSString *)text;

@end
