//
//  MDInput.m
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDInput.h"

@implementation MDInput

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        //border
        self.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = 2.5;
        
        //title
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(19, 18, 20, 14)];
        self.title.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:14];
        self.title.text = @"お題";
        [self addSubview:self.title];
        
        
        //input
        self.input = [[UITextField alloc]initWithFrame:CGRectMake(frame.size.width-150, 17, 130, 17)];
        self.input.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
        self.input.textAlignment = NSTextAlignmentRight;
        self.input.delegate = self;
        [self addSubview:self.input];
        
        //default toolbar
        [self setKeyboardToolbar];
        
    }
    
    return self;
}

-(void) setKeyboardToolbar {
    // ツールバーの作成
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleDefault; // スタイルを設定
    [toolBar sizeToFit];
    
    // フレキシブルスペースの作成（Doneボタンを右端に配置したいため）
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    // Doneボタンの作成
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"完了" style:UIBarButtonItemStyleDone target:self action:@selector(closeKeyboard:)];
    
    // ボタンをToolbarに設定
    NSArray *items = [NSArray arrayWithObjects:spacer, done, nil];
    [toolBar setItems:items animated:YES];
    
    // ToolbarをUITextFieldのinputAccessoryViewに設定
    _input.inputAccessoryView = toolBar;
}
-(void)closeKeyboard:(id)sender {
    [_input resignFirstResponder];
}
-(void) disableKeyboardToolbar {
    _input.inputAccessoryView = nil;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(inputPushed:)]){
        [self.delegate inputPushed:self];
    }
}
-(void) textFieldDidEndEditing:(UITextField *)textField{
    if ([self.delegate respondsToSelector:@selector(endInput:)]){
        [self.delegate endInput:self];
    }
}


@end
