//
//  MDCreateProfileView.m
//  Distribution
//
//  Created by Lsr on 4/12/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDCreateProfileView.h"
#import "MDCheckBox.h"

@implementation MDCreateProfileView

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        _scrollView.delegate = self;
        [_scrollView setContentSize:CGSizeMake(frame.size.width, 780)];
        [_scrollView setBackgroundColor:[UIColor whiteColor]];
        [_scrollView setScrollEnabled:YES];
        [self addSubview:_scrollView];
        
        _lastnameInput = [[MDInput alloc]initWithFrame:CGRectMake(10, 10, frame.size.width-20, 50)];
        _lastnameInput.title.text = @"姓";
        [_lastnameInput.title sizeToFit];
        _lastnameInput.input.placeholder = @"山田";
        [_scrollView addSubview:_lastnameInput];
        
        _givennameInput = [[MDInput alloc]initWithFrame:CGRectMake(10, 59, frame.size.width-20, 50)];
        [_givennameInput setBackgroundColor:[UIColor whiteColor]];
        _givennameInput.title.text = @"名";
        [_givennameInput.title sizeToFit];
        _givennameInput.input.placeholder = @"太郎";
        [_scrollView addSubview:_givennameInput];
        
        _creditButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 125, frame.size.width-20, 50)];
        [_creditButton setBackgroundColor:[UIColor whiteColor]];
        _creditButton.buttonTitle.text = @"お支払い方法";
        [_creditButton.buttonTitle sizeToFit];
        _creditButton.selectLabel.text = @"1234567801234567";
        [_creditButton.selectLabel sizeToFit];
        [_creditButton setUnactive];
        [_scrollView addSubview:_creditButton];
        
        _passwordInput = [[MDInput alloc]initWithFrame:CGRectMake(10, 215, frame.size.width-20, 50)];
        [_passwordInput setBackgroundColor:[UIColor whiteColor]];
        _passwordInput.title.text = @"パスワード";
        [_passwordInput.title sizeToFit];
        [_passwordInput.input setSecureTextEntry:YES];
        _passwordInput.input.placeholder = @"6桁以上の英数字";
        [_scrollView addSubview:_passwordInput];
        
        _repeatInput = [[MDInput alloc]initWithFrame:CGRectMake(10, 275, frame.size.width-20, 50)];
        [_repeatInput setBackgroundColor:[UIColor whiteColor]];
        _repeatInput.title.text = @"パスワード(確認用)";
        [_repeatInput.title sizeToFit];
        _repeatInput.input.placeholder = @"6桁以上の英数字";
        [_repeatInput.input setSecureTextEntry:YES];
        [_scrollView addSubview:_repeatInput];
        
        //checkbox
        MDCheckBox *checkBox = [[MDCheckBox alloc]initWithFrame:CGRectMake(10, 340, 34, 34)];
        [_scrollView addSubview:checkBox];
        
        
        UIButton *userProtocol = [[UIButton alloc]initWithFrame:CGRectMake(checkBox.frame.origin.x + checkBox.frame.size.width+10, checkBox.frame.origin.y+10, 64, 14)];
        userProtocol.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:14];
        [userProtocol setTitleColor:[UIColor colorWithRed:30.0/255.0 green:132.0/255.0 blue:158.0/255.0 alpha:1] forState:UIControlStateNormal];
        [userProtocol setTitle:@"利用規約" forState:UIControlStateNormal];
        [_scrollView addSubview:userProtocol];
        
        UILabel *toLabel = [[UILabel alloc]initWithFrame:CGRectMake(userProtocol.frame.origin.x + userProtocol.frame.size.width, userProtocol.frame.origin.y, 14, 14)];
        toLabel.text = @"と";
        toLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:14];
        toLabel.textColor = [UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1];
        [_scrollView addSubview:toLabel];
        
        UIButton *driverProtocol = [[UIButton alloc]initWithFrame:CGRectMake(toLabel.frame.origin.x+14, toLabel.frame.origin.y, 126, 14)];
        driverProtocol.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:14];
        [driverProtocol setTitleColor:[UIColor colorWithRed:30.0/255.0 green:132.0/255.0 blue:158.0/255.0 alpha:1] forState:UIControlStateNormal];
        [driverProtocol setTitle:@"プライバシポリシー" forState:UIControlStateNormal];
        [_scrollView addSubview:driverProtocol];
        
        UILabel *niLabel = [[UILabel alloc]initWithFrame:CGRectMake(driverProtocol.frame.origin.x + driverProtocol.frame.size.width, driverProtocol.frame.origin.y, 42, 14)];
        niLabel.text = @"に同意";
        niLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:14];
        niLabel.textColor = [UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1];
        [_scrollView addSubview:niLabel];
        
        _postButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 392, frame.size.width-20, 50)];
        [_postButton setBackgroundColor:[UIColor colorWithRed:226.0/255.0 green:138.0/255.0 blue:0 alpha:1]];
        [_postButton setTitle:@"以上で登録" forState:UIControlStateNormal];
        _postButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:18];
        [_postButton addTarget:self action:@selector(postData) forControlEvents:UIControlEventTouchUpInside];
        _postButton.layer.cornerRadius = 2.5;
        [_scrollView addSubview:_postButton];
    }
    
    return self;
}

-(void) postData {
    if([self.delegate respondsToSelector:@selector(postData:)]){
        [self.delegate postData:self];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if([self.delegate respondsToSelector:@selector(scrollDidMove:)]) {
        [self.delegate scrollDidMove:self];
    }
}

@end
