//
//  MDRequestDetailView.m
//  Distribution
//
//  Created by Lsr on 4/19/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDRequestDetailView.h"
#import "MDSelect.h"
#import "MDAddressTable.h"
#import "MDBigRed.h"
#import <UIButton+WebCache.h>
#import <UIImageView+WebCache.h>

@implementation MDRequestDetailView{
    UIView *processViews;
    MDSelect *statusButton;
    MDSelect *requestButton;
    MDSelect *destinationButton;
    MDSelect *sizePicker;
    MDSelect *additionalServicePicker;
    MDSelect *costPicker;
    MDSelect *cusTodyTimePicker;
    MDSelect *destinateTimePicker;
    MDSelect *requestTerm;
    MDSelect *beCarefulPicker;
    UIButton *cameraButton;
    MDAddressTable *requestAddressView;
    MDAddressTable *destinationAddressView;
    UILabel *matchingProcessLabel;
    UILabel *distributionProcessLabel;
    UILabel *completeProcessLabel;
    
    UIImageView *matchingImageView;
    UIImageView *distributionImageView;
    UIImageView *completeImageView;
    
    UIImageView *uploadedImage;
}

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //add code
        [self setBackgroundColor:[UIColor whiteColor]];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        
        //process bar
        UIImageView *process1 = [[UIImageView alloc]initWithFrame:CGRectMake(40, 27, 16, 16)];
        [process1 setImage:[UIImage imageNamed:@"taskRound"]];
        UIImageView *process2 = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-8, 27, 16, 16)];
        [process2 setImage:[UIImage imageNamed:@"taskRound"]];
        UIImageView *process3 = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-56, 27, 16, 16)];
        [process3 setImage:[UIImage imageNamed:@"taskRound"]];
        [_scrollView addSubview:process1];
        [_scrollView addSubview:process2];
        [_scrollView addSubview:process3];
        
        
        UIView *processBar1 = [[UIView alloc]initWithFrame:CGRectMake(process1.frame.origin.x + process1.frame.size.width + 5,
                                                                      34,
                                                                      process2.frame.origin.x - process1.frame.origin.x - 10 - 16,
                                                                      2)];
        [processBar1 setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1]];
        [_scrollView addSubview:processBar1];
        
        
        UIView *processBar2 = [[UIView alloc]initWithFrame:CGRectMake(process2.frame.origin.x + process2.frame.size.width + 5,
                                                                      34,
                                                                      process3.frame.origin.x - process2.frame.origin.x - 10 - 16,
                                                                      2)];
        [processBar2 setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1]];
        [_scrollView addSubview:processBar2];
        
        matchingImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [matchingImageView setImage:[UIImage imageNamed:@"matchingProcess"]];
        matchingImageView.center = process1.center;
        [_scrollView addSubview:matchingImageView];
        
        distributionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [distributionImageView setImage:[UIImage imageNamed:@"distributionProcess"]];
        distributionImageView.center = process2.center;
        [_scrollView addSubview:distributionImageView];
        
        completeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [completeImageView setImage:[UIImage imageNamed:@"completeProcess"]];
        completeImageView.center = process3.center;
        [_scrollView addSubview:completeImageView];
        
        [matchingImageView setHidden:YES];
        [completeImageView setHidden:YES];
        [distributionImageView setHidden:YES];
        
        //process word
        matchingProcessLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 63, 75, 12)];
        matchingProcessLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
        matchingProcessLabel.text = @"マッチング中";
        [matchingProcessLabel sizeToFit];
        matchingProcessLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        
        matchingProcessLabel.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:matchingProcessLabel];
        
        //process word
        distributionProcessLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/2 - 17, 63, 34, 12)];
        distributionProcessLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
        distributionProcessLabel.text = @"預かり";
        [distributionProcessLabel sizeToFit];
        distributionProcessLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        distributionProcessLabel.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:distributionProcessLabel];
        
        //process word
        completeProcessLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width - 73, 63, 48, 12)];
        completeProcessLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
        completeProcessLabel.text = @"配達完了";
        [completeProcessLabel sizeToFit];
        completeProcessLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        completeProcessLabel.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:completeProcessLabel];
        
        
        //状態
        statusButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, 95, frame.size.width-20, 50)];
        statusButton.buttonTitle.text = @"配送員";
        statusButton.selectLabel.text = @"マッチング中";
        [statusButton setUnactive];
        [_scrollView addSubview:statusButton];
        
        //cameraButton
        cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 155,  frame.size.width-20, (frame.size.width-20)*0.6)];
        [cameraButton setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
        [cameraButton addTarget:self action:@selector(cameraButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:cameraButton];
        
        
        
        //address
        requestAddressView = [[MDAddressTable alloc]initWithFrame:CGRectMake(10, cameraButton.frame.origin.y + cameraButton.frame.size.height + 10, frame.size.width-20, 100)];
        requestAddressView.layer.cornerRadius = 2.5;
        requestAddressView.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        requestAddressView.layer.borderWidth = 0.5;
        requestAddressView.addressField.text = @"";
        requestAddressView.zipField.text = @"";
        [requestAddressView setUnAvailable];
        [_scrollView addSubview:requestAddressView];
        
        //destination address
        
        destinationAddressView = [[MDAddressTable alloc]initWithFrame:CGRectMake(10, requestAddressView.frame.origin.y + requestAddressView.frame.size.height + 10, frame.size.width-20, 100)];
        [destinationAddressView setBackgroundColor:[UIColor whiteColor]];
        destinationAddressView.layer.cornerRadius = 2.5;
        destinationAddressView.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        destinationAddressView.layer.borderWidth = 0.5;
        destinationAddressView.addressField.text = @"";
        destinationAddressView.zipField.text = @"";
        [destinationAddressView setUnAvailable];
        [_scrollView addSubview:destinationAddressView];
        
        //list
        sizePicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, destinationAddressView.frame.origin.y + destinationAddressView.frame.size.height + 10, frame.size.width-20, 50)];
        sizePicker.buttonTitle.text = @"サイズ";
        sizePicker.selectLabel.text = @"120";
//        [sizePicker addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:sizePicker];
        
        
        //list
        beCarefulPicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, sizePicker.frame.origin.y + sizePicker.frame.size.height + 10, frame.size.width-20, 50)];
        beCarefulPicker.buttonTitle.text = @"取扱説明書";
        beCarefulPicker.selectLabel.text = @"特になし";
        [beCarefulPicker setUnactive];
//        [beCarefulPicker addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [beCarefulPicker setReadOnly];
        [_scrollView addSubview:beCarefulPicker];
        
        //list
        costPicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, beCarefulPicker.frame.origin.y + beCarefulPicker.frame.size.height + 10, frame.size.width-20, 50)];
        costPicker.buttonTitle.text = @"依頼金額";
        costPicker.selectLabel.text = @"1400";
//        [costPicker addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [costPicker setReadOnly];
        [_scrollView addSubview:costPicker];
        
        //list
        cusTodyTimePicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, costPicker.frame.origin.y + costPicker.frame.size.height + 10, frame.size.width-20, 50)];
        cusTodyTimePicker.buttonTitle.text = @"預かり時刻";
        cusTodyTimePicker.selectLabel.text = @"いつでも";
//        [cusTodyTimePicker addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [cusTodyTimePicker setReadOnly];
        [_scrollView addSubview:cusTodyTimePicker];
        
        //list
        destinateTimePicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, cusTodyTimePicker.frame.origin.y + cusTodyTimePicker.frame.size.height + 10, frame.size.width-20, 50)];
        destinateTimePicker.buttonTitle.text = @"お届け期限";
//        [destinateTimePicker addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [destinateTimePicker setReadOnly];
        [_scrollView addSubview:destinateTimePicker];
        
        
        //list
        requestTerm = [[MDSelect alloc]initWithFrame:CGRectMake(10, destinateTimePicker.frame.origin.y + destinateTimePicker.frame.size.height + 10, frame.size.width-20, 50)];
        requestTerm.buttonTitle.text = @"依頼期限";
//        [requestTerm addTarget:self action:@selector(pickerButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [requestTerm setReadOnly];
        [_scrollView addSubview:requestTerm];
        
        [_scrollView setContentSize:CGSizeMake(frame.size.width, requestTerm.frame.origin.y + requestTerm.frame.size.height + 10)];
        [self addSubview:_scrollView];
        
        
    }
    return self;
}

-(void) setStatus:(int)status {
    switch (status) {
        case 0:
            matchingProcessLabel.textColor = [UIColor colorWithRed:226.0/255.0 green:0 blue:0 alpha:1];
            distributionProcessLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
            completeProcessLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
            [matchingImageView setHidden:NO];
            [distributionImageView setHidden:YES];
            [completeImageView setHidden:YES];
            break;
        case 2:
            matchingProcessLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
            distributionProcessLabel.textColor = [UIColor colorWithRed:226.0/255.0 green:138.0/255.0 blue:0/255.0 alpha:1];
            completeProcessLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
            [matchingImageView setHidden:YES];
            [distributionImageView setHidden:NO];
            [completeImageView setHidden:YES];
            break;
        case 3:
            matchingProcessLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
            distributionProcessLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
            completeProcessLabel.textColor = [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1];
            [matchingImageView setHidden:YES];
            [distributionImageView setHidden:YES];
            [completeImageView setHidden:NO];
            break;
        default:
            break;
    }
}

-(void) makeupByData:(NSDictionary *)data{
    //upload image
    uploadedImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 136, 136)];
    [uploadedImage sd_setImageWithURL:[NSURL URLWithString:data[@"image"]] placeholderImage:[UIImage imageNamed:@"cargo"] options:SDWebImageRetryFailed];

    [cameraButton sd_setImageWithURL:[NSURL URLWithString:data[@"image"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"cargo"] options:SDWebImageRetryFailed];
    
    
    //address
    requestAddressView.zipField.text = data[@"from_zip"];
    requestAddressView.addressField.text = data[@"from_addr"];
    destinationAddressView.zipField.text = data[@"to_zip"];
    destinationAddressView.addressField.text = data[@"to_addr"];
    
    //size
    sizePicker.selectLabel.text = [NSString stringWithFormat:@"合計%@以内", data[@"size"]];
    
    //at_home_time
    //
    
    //note
    //    additionalServicePicker.selectLabel.text = [MDCurrentPackage getInstance].note;
    //取扱説明書
    beCarefulPicker.selectLabel.text = (data[@"note"] == nil) ? @"特になし" : data[@"note"];
    //price
    costPicker.selectLabel.text = [NSString stringWithFormat:@"%@円",data[@"request_amount"]];
    //at home time;
    
    NSString *deliver_limit = [NSString stringWithFormat:@"%@",data[@"deliver_limit"]];
    destinateTimePicker.selectLabel.text = [NSString stringWithFormat:@"%@時", [deliver_limit substringToIndex:13]];
    
    //expire
    NSLog(@"%@", data[@"expire"]);
    NSDate * now = [NSDate date];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSLocale systemLocale]];
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:00"];
    NSDate *expireDate =[dateFormat dateFromString:data[@"expire"]];
    NSTimeInterval timeBetween = [expireDate timeIntervalSinceDate:now];
    int hour = timeBetween/60/60;
    if (hour < 1) {
        requestTerm.selectLabel.text = [NSString stringWithFormat:@"期限で取消された"];
    } else {
        requestTerm.selectLabel.text = [NSString stringWithFormat:@"%d時間以内",hour+1];
    }
}

-(void) cameraButtonTouched {
        if([self.delegate respondsToSelector:@selector(cameraButtonTouched)]){
            [self.delegate cameraButtonTouched];
        }
}

-(UIImageView*) getUploadedImage{
    return uploadedImage;
}


@end