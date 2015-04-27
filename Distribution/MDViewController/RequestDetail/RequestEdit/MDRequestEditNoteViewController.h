//
//  MDRequestEditNoteViewController.h
//  Distribution
//
//  Created by Lsr on 4/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDRequestEditNoteViewController : UIViewController<UITextViewDelegate>
@property (strong, nonatomic) UITextView *serviceInputView;
@property (strong, nonatomic) NSString *contentText;

-(void) setText:(NSString *)text;

@end
