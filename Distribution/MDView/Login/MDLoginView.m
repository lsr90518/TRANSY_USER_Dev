//
//  MDLoginView.m
//  Distribution
//
//  Created by Lsr on 4/12/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDLoginView.h"
#import "MDInput.h"

@implementation MDLoginView

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        _phoneInput = [[MDInput alloc]initWithFrame:CGRectMake(10, 74, frame.size.width-20, 50)];
        _phoneInput.title.text = @"電話番号";
        _phoneInput.input.placeholder = @"番号入力(「-」無し)";
        [_phoneInput.input setKeyboardType:UIKeyboardTypeNumberPad];
        [_phoneInput.title sizeToFit];
        [self addSubview:_phoneInput];
        
        _passwordInput = [[MDInput alloc]initWithFrame:CGRectMake(10, 134, frame.size.width-20, 50)];
        _passwordInput.title.text = @"パスワード";
        _passwordInput.input.placeholder = @"6桁以上の英数字";
        [_passwordInput.input setSecureTextEntry:YES];
        [_passwordInput.title sizeToFit];
        [self addSubview:_passwordInput];
        
        UIButton *postButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 194, frame.size.width-20, 50)];
        [postButton setBackgroundColor:[UIColor colorWithRed:226.0/255.0 green:138.0/255.0 blue:0 alpha:1]];
        [postButton setTitle:@"以上で登録" forState:UIControlStateNormal];
        postButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:18];
        [postButton addTarget:self action:@selector(postData) forControlEvents:UIControlEventTouchUpInside];
        postButton.layer.cornerRadius = 2.5;
        [self addSubview:postButton];
        
    }
    
    [self loginTest];
    return self;
}

-(void)postData {
    if([self.delegate respondsToSelector:@selector(postData:)]){
        [self.delegate postData:self];
    }
}

-(void) loginTest {
    _phoneInput.input.text = @"09028280392";
    _passwordInput.input.text = @"123456";
}

@end
