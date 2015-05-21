//
//  MDAddressInputTable.m
//  Distribution
//
//  Created by Lsr on 3/30/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDAddressInputTable.h"

@implementation MDAddressInputTable

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        //郵便番号
        _zipField = [[MDButtonInput alloc]initWithFrame:CGRectMake(10, 10, frame.size.width-20, 50)];
        _zipField.input.placeholder = @"例) 〒1540002";
        _zipField.title.text = @"郵便番号";
        [_zipField.input setKeyboardType:UIKeyboardTypeNumberPad];
        [_zipField.title sizeToFit];
        _zipField.input.delegate = self;
        [_zipField.button addTarget:self action:@selector(autoInputAddress) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_zipField];
        
        //都府
        _metropolitanField = [[MDInput alloc]initWithFrame:CGRectMake(10, _zipField.frame.origin.y + _zipField.frame.size.height - 2, frame.size.width-20, 50)];
        _metropolitanField.input.placeholder = @"例) 東京都";
        _metropolitanField.title.text = @"都道府県";
        [_metropolitanField.title sizeToFit];
        _metropolitanField.delegate = self;
        [_scrollView addSubview:_metropolitanField];
        
        //市
        _cityField = [[MDInput alloc]initWithFrame:CGRectMake(10, _metropolitanField.frame.origin.y + _metropolitanField.frame.size.height - 2, frame.size.width-20, 50)];
        _cityField.input.placeholder = @"例) 都区";
        _cityField.title.text = @"市区";
        [_cityField.title sizeToFit];
        _cityField.delegate = self;
        [_scrollView addSubview:_cityField];
        
        //区
        _townField = [[MDInput alloc]initWithFrame:CGRectMake(10, _cityField.frame.origin.y + _cityField.frame.size.height - 2, frame.size.width-20, 50)];
        _townField.input.placeholder = @"例) 三田";
        _townField.title.text = @"町村";
        [_townField.title sizeToFit];
        _townField.delegate = self;
        [_scrollView addSubview:_townField];
        
        //番地
        _houseField = [[MDInput alloc]initWithFrame:CGRectMake(10, _townField.frame.origin.y + _townField.frame.size.height - 2, frame.size.width-20, 50)];
        _houseField.input.placeholder = @"例) 3-8-12";
        _houseField.title.text = @"番地";
        [_houseField.title sizeToFit];
        _houseField.delegate = self;
        [_scrollView addSubview:_houseField];
        
        //ビル
        _buildingNameField = [[MDInput alloc]initWithFrame:CGRectMake(10, _houseField.frame.origin.y + _houseField.frame.size.height - 2, frame.size.width-20, 50)];
        _buildingNameField.title.text = @"建物名(任意)";
        [_buildingNameField.title sizeToFit];
        _buildingNameField.input.placeholder = @"例) シティ201";
        _buildingNameField.delegate = self;
        [_scrollView addSubview:_buildingNameField];

        [_scrollView setContentSize:CGSizeMake(frame.size.width, frame.size.height + 100)];
        
    }
    return self;
}

-(void) setFrameColor:(UIColor *)color {
    
}

-(void)autoInputAddress {
    
    if([self.delegate respondsToSelector:@selector(autoButtonPushed:)]){
        [self.delegate autoButtonPushed:self];
    }
    
}

-(void) setUnAvailable{
    NSArray *subviews = [_scrollView subviews];
    for(UIView *view in subviews) {
        if([view.class isSubclassOfClass:[MDButtonInput class]]){
            MDButtonInput *tmpView = (MDButtonInput *)view;
            [tmpView.button setHidden:YES];
        } else if([view.class isSubclassOfClass:[MDInput class]]){
            MDInput *tmpView = (MDInput *)view;
            [tmpView.input setUserInteractionEnabled:NO];
        }
    }
}

-(void) closeKeyboard{
    NSArray *subviews = [_scrollView subviews];
    for(UIView *view in subviews) {
        if([view.class isSubclassOfClass:[MDInput class]]){
            MDInput *tmpView = (MDInput*)view;
            [tmpView.input resignFirstResponder];
        }
    }
}

-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self closeKeyboard];
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(![textField.text hasPrefix:@"〒"]){
        textField.text = [NSString stringWithFormat:@"〒%@", textField.text];
    }
    if(textField.text.length > 8){
        textField.text = [textField.text substringToIndex:8];
    }
    return YES;
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
    if([self.delegate respondsToSelector:@selector(inputDidEnd:)]){
        [self.delegate inputDidEnd:self];
    }
}

-(void)clearData {
    _zipField.input.text = @"";
    _metropolitanField.input.text = @"";
    _cityField.input.text = @"";
    _townField.input.text = @"";
    _houseField.input.text = @"";
    _buildingNameField.input.text = @"";
}

#pragma MDInput delegate
-(void) inputPushed:(MDInput *)input{
    int offset = input.frame.origin.y + input.frame.size.height + 100 - (_scrollView.frame.size.height - 216.0);//键盘高度216
    CGPoint point = CGPointMake(0, offset);
    [_scrollView setContentOffset:point animated:YES];
}

-(void) endInput:(MDInput *)input{
    [self resizeScrollView];
}

-(void) resizeScrollView {
    // 下に空白ができたらスクロールで調整
    int scrollOffset = [_scrollView contentOffset].y;
    int contentBottomOffset = _scrollView.contentSize.height - _scrollView.frame.size.height;
    
    if(contentBottomOffset > 0){
        if(scrollOffset > contentBottomOffset){
            CGPoint point = CGPointMake(0, contentBottomOffset);
            [_scrollView setContentOffset:point animated:YES];
        } else {
            CGPoint point = CGPointMake(0, -64);
            [_scrollView setContentOffset:point animated:YES];
        }
    } else {
        
        CGPoint point = CGPointMake(0, -64);
        [_scrollView setContentOffset:point animated:YES];
    }
}

@end
