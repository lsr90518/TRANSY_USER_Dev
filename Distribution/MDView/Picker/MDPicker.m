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
    
    int componentCount;
}

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
        
        //add pickerview
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.size.height - 216, frame.size.width, 216)];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.tag = 0;
        [self addSubview:_pickerView];
        
        //add buttons
        UIView *buttonViews = [[UIView alloc]initWithFrame:CGRectMake(frame.origin.x, _pickerView.frame.origin.y - 30, frame.size.width, 30)];
        [buttonViews setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:buttonViews];
        
        
        //line
        UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(frame.origin.x, 0 , frame.size.width, 2)];
        [topLine setBackgroundColor:[UIColor colorWithRed:238.0/255.0 green:160.0/255.0 blue:24.0/255.0 alpha:1]];
        [buttonViews addSubview:topLine];
        
        
        _doneButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width - 50, 0, 40, 30)];
        [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
        _doneButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
        [_doneButton setTitleColor:[UIColor colorWithRed:238.0/255.0 green:160.0/255.0 blue:24.0/255.0 alpha:1] forState:UIControlStateNormal];
        [buttonViews addSubview:_doneButton];
        
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 30)];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
        [_cancelButton setTitleColor:[UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1] forState:UIControlStateNormal];
        [buttonViews addSubview:_cancelButton];
        
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
    return [options count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component {
    NSString *returnStr;
    switch (pickerView.tag) {
        case 3:
            returnStr = [NSString stringWithFormat:@"%@時間以内",options[row]];
            break;
        case 2:
            if (component == 0) {
                return [date objectAtIndex:row];
            } else if(component == 1) {
                return [NSString stringWithFormat:@"%@時",[time objectAtIndex:row]];
            } else {
                return [NSString stringWithFormat:@"%@分",[minute objectAtIndex:row]];
            }
            break;
        case 1:
            if (component == 0) {
                return [date objectAtIndex:row];
            }
            return [time objectAtIndex:row];
            break;
        default:
            break;
    }
    return returnStr;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //input to mdcurrent
    
//    if (pickerView.tag == 3) {
//        requestTerm.selectLabel.text = [NSString stringWithFormat:@"%@時間以内",options[row]];
//        [MDCurrentPackage getInstance].expire = [[MDUtil getInstance] getAnHourAfterDate:[options objectAtIndex:row]];
//    } else if(pickerView.tag == 2){
//        //input to mdcurrent
//        //お届け期限
//        if(component == 0){
//            
//            NSString *oldTime = [[MDCurrentPackage getInstance].deliver_limit componentsSeparatedByString:@" "][1];
//            NSString *newDeliveryStr = [NSString stringWithFormat:@"%@ %@",[realDate objectAtIndex:row], oldTime];
//            [MDCurrentPackage getInstance].deliver_limit = newDeliveryStr;
//            
//        } else if(component == 1) {
//            
//            //make string
//            NSString *oldDate = [[MDCurrentPackage getInstance].deliver_limit componentsSeparatedByString:@" "][0];
//            NSString *oldTime = [[MDCurrentPackage getInstance].deliver_limit componentsSeparatedByString:@" "][1];
//            NSString *oldMinute = [oldTime componentsSeparatedByString:@":"][1];
//            NSString *newDeliveryStr = [NSString stringWithFormat:@"%@ %@:%@:00",oldDate, [time objectAtIndex:row], oldMinute];
//            [MDCurrentPackage getInstance].deliver_limit = newDeliveryStr;
//        } else {
//            NSString *oldDate = [[MDCurrentPackage getInstance].deliver_limit componentsSeparatedByString:@":"][0];
//            NSString *newDeliveryStr = [NSString stringWithFormat:@"%@:%@:00",oldDate, [minute objectAtIndex:row]];
//            [MDCurrentPackage getInstance].deliver_limit = newDeliveryStr;
//        }
//        destinateTimePicker.selectLabel.text = [self getInitStr];
//    } else {
//        if(component == 0){
//            //        NSArray* tmp = date;
//            //        NSString *title = @"日付";
//            //            dateInput.input.text = [date objectAtIndex:row];
//            
//            [realDate objectAtIndex:row];
//            
//            [MDCurrentPackage getInstance].at_home_time[0][0] = [realDate objectAtIndex:row];
//            
//        } else {
//            NSArray *tmp = time;
//            //            timeInput.input.text = [tmp objectAtIndex:row];
//            NSArray *tmpArray;
//            if([[tmp objectAtIndex:row] isEqualToString:@"いつでも"]){
//                tmpArray = [NSArray arrayWithObjects:@"0", @"24", nil];
//                
//                [MDCurrentPackage getInstance].at_home_time[0][1] = tmpArray[0]; //時間 から
//                [MDCurrentPackage getInstance].at_home_time[0][2] = tmpArray[1]; //時間 まで
//            } else {
//                
//                tmpArray = [[tmp objectAtIndex:row] componentsSeparatedByString:@"時"];
//                [MDCurrentPackage getInstance].at_home_time[0][1] = tmpArray[0]; //時間 から
//                [MDCurrentPackage getInstance].at_home_time[0][2] = [tmpArray[1] substringFromIndex:1]; //時間 まで
//            }
//        }
//        NSLog(@"%@", [MDCurrentPackage getInstance].at_home_time);
//        cusTodyTimePicker.selectLabel.text = [self getReciveTimeStr];
//    }
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component {
    if(pickerView.tag == 3){
        return self.frame.size.width;
    } else if(pickerView.tag == 2){
        if (component == 0) {
            return self.frame.size.width/3;
        } else if(component == 1) {
            return self.frame.size.width/3;
        } else {
            return self.frame.size.width/3;
        }
    } else {
        return self.frame.size.width/2;
    }
}

-(void) setOptions:(NSMutableArray *)dataArray :(int)col{
    componentCount = col;
    if(options == nil){
        options = [[NSMutableArray alloc]initWithArray:dataArray];
    }
}

@end
