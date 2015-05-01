//
//  MDPicker.m
//  Distribution
//
//  Created by 劉 松然 on 2015/04/28.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import "MDPicker.h"

@implementation MDPicker {
    NSMutableArray *options;
    NSMutableArray* time;
    NSMutableArray* realDate;
    NSMutableArray* date;
    NSMutableArray* minute;
    
    NSMutableArray *resultList;
    int componentCount;
    
}

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self setAlpha:0];
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
                        
        //add pickerview
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.size.height + 30, frame.size.width, 216)];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.tag = 0;
        [self addSubview:_pickerView];
        
        //add buttons
        _buttonView = [[UIView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.size.height, frame.size.width, 30)];
        [_buttonView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_buttonView];
        
        
        //line
        UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(frame.origin.x, 0 , frame.size.width, 2)];
        [topLine setBackgroundColor:[UIColor colorWithRed:238.0/255.0 green:160.0/255.0 blue:24.0/255.0 alpha:1]];
        [_buttonView addSubview:topLine];
        
        
        _doneButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width - 50, 0, 40, 30)];
        [_doneButton setTitle:@"完了" forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(sendData) forControlEvents:UIControlEventTouchUpInside];
        _doneButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
        [_doneButton setTitleColor:[UIColor colorWithRed:238.0/255.0 green:160.0/255.0 blue:24.0/255.0 alpha:1] forState:UIControlStateNormal];
        [_buttonView addSubview:_doneButton];
        
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 30)];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
        [_cancelButton setTitleColor:[UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1] forState:UIControlStateNormal];
        [_buttonView addSubview:_cancelButton];
        
        
    }
    return self;
}

#pragma UIPicker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return componentCount;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [options[component] count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component {
    NSString *returnStr;
    switch (pickerView.tag) {
        case 3:
            returnStr = options[component][row];
            break;
        case 2:
            returnStr = options[component][row];
            break;
        case 1:
            returnStr = options[component][row];
            break;
        case 0:
            returnStr = options[component][row];
            break;
        default:
            break;
    }
//    returnStr = [NSString stringWithFormat:@"合計%@以内", options[row]];
    return returnStr;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //input to mdcurrent
    
    
    resultList[component][0] = [NSString stringWithFormat:@"%lu",row];
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component {
    return self.frame.size.width/componentCount;
}

-(void) setOptions:(NSArray *)dataArray :(int)col :(int)tag{
    
    resultList = [[NSMutableArray alloc]init];
    for(int i = 0;i<col;i++){
        resultList[i] = [[NSMutableArray alloc]init];
        [resultList[i] addObject:@"0"];
    }
    
    componentCount = col;
    _pickerView.tag = tag;
    if(options == nil){
        options = [[NSMutableArray alloc]initWithArray:dataArray];
    }
    [_pickerView reloadAllComponents];
}


-(void) sendData{
    if([self.delegate respondsToSelector:@selector(didSelectedRow::)]){
        [self.delegate didSelectedRow:resultList:(int)_pickerView.tag];
    }
    [self closeView];
}


-(void) showView {
    [UIView animateWithDuration:0.3 animations:^{
        [_pickerView setFrame:CGRectMake(self.frame.origin.x, self.frame.size.height - 216, self.frame.size.width, 216)];
        [_buttonView setFrame:CGRectMake(self.frame.origin.x, _pickerView.frame.origin.y - 30, self.frame.size.width, 30)];
        [self setAlpha:1];
    } completion:^(BOOL finished) {
    }];
}


-(void) closeView {
    [UIView animateWithDuration:0.3 animations:^{
        [_buttonView setFrame:CGRectMake(self.frame.origin.x, self.frame.size.height, self.frame.size.width, 30)];
        [_pickerView setFrame:CGRectMake(self.frame.origin.x, self.frame.size.height + 30, self.frame.size.width, 216)];
        [self setAlpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    if([self.delegate respondsToSelector:@selector(didClosed)]){
        [self.delegate didClosed];
    }
}

@end
