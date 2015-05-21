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
#import "MDSelectRatingWell.h"
#import "MDUtil.h"

@implementation MDRequestDetailView{
    UIView *processViews;
    MDSelect *statusButton;
    MDSelect *requestButton;
    MDSelect *destinationButton;
    MDSelect *sizePicker;
    UIButton *sizeDescriptionButton;
    MDSelect *additionalServicePicker;
    MDSelect *costPicker;
    MDSelect *cusTodyTimePicker;
    MDSelect *destinateTimePicker;
    MDSelect *requestTerm;
    MDSelect *beCarefulPicker;
    UIButton *cameraButton;
    MDAddressButton *requestAddressView;
    MDAddressButton *destinationAddressView;
    UILabel *matchingProcessLabel;
    UILabel *distributionProcessLabel;
    UILabel *completeProcessLabel;
    
    UIImageView *matchingImageView;
    UIImageView *distributionImageView;
    UIImageView *completeImageView;
    
    UIImageView *uploadedImage;
    
    UIButton *cancelButton;
    
    MDSelectRatingWell *reviewWell;
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
        requestAddressView = [[MDAddressButton alloc]initWithFrame:CGRectMake(10, cameraButton.frame.origin.y + cameraButton.frame.size.height + 10, frame.size.width-20, 100)];
        requestAddressView.layer.cornerRadius = 2.5;
        requestAddressView.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        requestAddressView.layer.borderWidth = 0.5;
        requestAddressView.buttonTitleLabel.text = @"預かり先";
        [requestAddressView addTarget:self action:@selector(addressButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:requestAddressView];
        
        //list
        cusTodyTimePicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, requestAddressView.frame.origin.y + requestAddressView.frame.size.height - 1, frame.size.width-20, 50)];
        cusTodyTimePicker.buttonTitle.text = @"預かり時刻";
        cusTodyTimePicker.selectLabel.text = @"いつでも";
        [cusTodyTimePicker setReadOnly];
        [_scrollView addSubview:cusTodyTimePicker];
        
        
        //destination address
        destinationAddressView = [[MDAddressButton alloc]initWithFrame:CGRectMake(10, requestAddressView.frame.origin.y + requestAddressView.frame.size.height + 10, frame.size.width-20, 100)];
        [destinationAddressView setBackgroundColor:[UIColor whiteColor]];
        destinationAddressView.layer.cornerRadius = 2.5;
        destinationAddressView.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        destinationAddressView.layer.borderWidth = 0.5;
        destinationAddressView.buttonTitleLabel.text = @"お届け先";
        [destinationAddressView addTarget:self action:@selector(addressButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:destinationAddressView];
        
        //list
        destinateTimePicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, destinationAddressView.frame.origin.y + destinationAddressView.frame.size.height - 1, frame.size.width-20, 50)];
        destinateTimePicker.buttonTitle.text = @"お届け期限";
        [destinateTimePicker setReadOnly];
        [_scrollView addSubview:destinateTimePicker];
        
        
        //list
        sizePicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, destinateTimePicker.frame.origin.y + destinateTimePicker.frame.size.height + 10, frame.size.width-20, 50)];
        sizePicker.buttonTitle.text = @"サイズ";
        sizePicker.selectLabel.text = @"120";
        [sizePicker setReadOnly];
        [_scrollView addSubview:sizePicker];
        sizeDescriptionButton = [[UIButton alloc]initWithFrame:CGRectMake(10, sizePicker.frame.origin.y + sizePicker.frame.size.height + 5, sizePicker.frame.size.width, 10)];
        sizeDescriptionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [sizeDescriptionButton setTitle:@"荷物サイズの測り方 >" forState:UIControlStateNormal];
        [sizeDescriptionButton setTitleColor:[UIColor colorWithRed:30.0/255.0 green:132.0/255.0 blue:158.0/255.0 alpha:1] forState:UIControlStateNormal];
        [sizeDescriptionButton setTitleColor:[UIColor colorWithRed:110.0/255.0 green:212.0/255.0 blue:238.0/255.0 alpha:1] forState:UIControlStateHighlighted];
        [sizeDescriptionButton.titleLabel setFont:[UIFont fontWithName:@"HiraKakuProN-W3" size:10]];
        [sizeDescriptionButton addTarget:self action:@selector(sizeDescriptionButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:sizeDescriptionButton];
        
        //list
        beCarefulPicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, sizeDescriptionButton.frame.origin.y + sizeDescriptionButton.frame.size.height + 10, frame.size.width-20, 50)];
        beCarefulPicker.buttonTitle.text = @"取扱説明書";
        beCarefulPicker.selectLabel.text = @"特になし";
        [beCarefulPicker setReadOnly];
        [_scrollView addSubview:beCarefulPicker];
        
        //list
        costPicker = [[MDSelect alloc]initWithFrame:CGRectMake(10, beCarefulPicker.frame.origin.y + beCarefulPicker.frame.size.height + 10, frame.size.width-20, 50)];
        costPicker.buttonTitle.text = @"依頼金額";
        costPicker.selectLabel.text = @"1400";
        [costPicker setReadOnly];
        [_scrollView addSubview:costPicker];
        

        //list
        requestTerm = [[MDSelect alloc]initWithFrame:CGRectMake(10, costPicker.frame.origin.y + costPicker.frame.size.height + 10, frame.size.width-20, 50)];
        requestTerm.buttonTitle.text = @"掲載期限";
        [requestTerm setReadOnly];
        [_scrollView addSubview:requestTerm];
        
        
        cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(10, requestTerm.frame.origin.y + requestTerm.frame.size.height + 10, self.frame.size.width - 20, 50)];
        [cancelButton setBackgroundColor:[UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1]];
        cancelButton.layer.cornerRadius = 2.0;
        [cancelButton setTitle:@"掲載をキャンセルする" forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:14];
        [cancelButton addTarget:self action:@selector(cancelButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:cancelButton];
        
        //scroll view
        [_scrollView setContentSize:CGSizeMake(frame.size.width, cancelButton.frame.origin.y + cancelButton.frame.size.height + 10)];
        [self addSubview:_scrollView];
        
    }
    return self;
}

-(void) resizeSubviews{
    //address
    [requestAddressView setFrame:CGRectMake(10, cameraButton.frame.origin.y + cameraButton.frame.size.height + 10, self.frame.size.width-20, requestAddressView.frame.size.height)];
    [cusTodyTimePicker setFrame:CGRectMake(10, requestAddressView.frame.origin.y + requestAddressView.frame.size.height - 1, self.frame.size.width-20, 50)];
    
    [destinationAddressView setFrame:CGRectMake(10, cusTodyTimePicker.frame.origin.y + cusTodyTimePicker.frame.size.height + 10, self.frame.size.width-20, destinationAddressView.frame.size.height)];
    [destinateTimePicker setFrame:CGRectMake(10, destinationAddressView.frame.origin.y + destinationAddressView.frame.size.height - 1, self.frame.size.width-20, 50)];
    
    [sizePicker setFrame:CGRectMake(10, destinateTimePicker.frame.origin.y + destinateTimePicker.frame.size.height + 10, self.frame.size.width-20, 50)];
    [sizeDescriptionButton setFrame:CGRectMake(10, sizePicker.frame.origin.y + sizePicker.frame.size.height + 5, sizePicker.frame.size.width, 10)];
    
    [beCarefulPicker setFrame:CGRectMake(10, sizeDescriptionButton.frame.origin.y + sizeDescriptionButton.frame.size.height + 10, self.frame.size.width-20, 50)];
    
    [costPicker setFrame:CGRectMake(10, beCarefulPicker.frame.origin.y + beCarefulPicker.frame.size.height + 10, self.frame.size.width-20, 50)];
    
    
    [requestTerm setFrame:CGRectMake(10, costPicker.frame.origin.y + costPicker.frame.size.height + 10, self.frame.size.width-20, 50)];
    
    [cancelButton setFrame:CGRectMake(10, requestTerm.frame.origin.y + requestTerm.frame.size.height + 10, self.frame.size.width - 20, 50)];
    
    [_scrollView setContentSize:CGSizeMake(self.frame.size.width, requestTerm.frame.origin.y + requestTerm.frame.size.height + 70)];
}

-(void) resizeByReviews{
    
    //cameraButton
    [cameraButton setFrame:CGRectMake(10, reviewWell.frame.origin.y + reviewWell.frame.size.height + 10, self.frame.size.width-20, (self.frame.size.width-20)*0.6)];
    
    [self resizeSubviews];
    
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
            [statusButton addTarget:self action:@selector(matchButtonTouched) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 1:
            matchingProcessLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
            distributionProcessLabel.textColor = [UIColor colorWithRed:226.0/255.0 green:138.0/255.0 blue:0/255.0 alpha:1];
            completeProcessLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
            [matchingImageView setHidden:YES];
            [distributionImageView setHidden:NO];
            [completeImageView setHidden:YES];
            statusButton.buttonTitle.text = @"配送員";
            [cancelButton setHidden:YES];
            [statusButton addTarget:self action:@selector(seeDriverProfile) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 2:
            matchingProcessLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
            distributionProcessLabel.textColor = [UIColor colorWithRed:226.0/255.0 green:138.0/255.0 blue:0/255.0 alpha:1];
            completeProcessLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
            [matchingImageView setHidden:YES];
            [distributionImageView setHidden:NO];
            [completeImageView setHidden:YES];
            statusButton.buttonTitle.text = @"配送員";
            [cancelButton setHidden:YES];
            [statusButton addTarget:self action:@selector(seeDriverProfile) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 3:
            matchingProcessLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
            distributionProcessLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
            completeProcessLabel.textColor = [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1];
            [matchingImageView setHidden:YES];
            [distributionImageView setHidden:YES];
            [completeImageView setHidden:NO];
            statusButton.buttonTitle.text = @"依頼者評価";
            statusButton.selectLabel.text = @"";
            [cancelButton setHidden:YES];
            [statusButton addTarget:self action:@selector(reviewButtonTouched) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 4:
            [statusButton setHidden:YES];
            [cancelButton setHidden:YES];
            //状態のボタン
            [cameraButton setFrame:CGRectMake(statusButton.frame.origin.x, statusButton.frame.origin.y, cameraButton.frame.size.width, cameraButton.frame.size.height)];
            [self resizeSubviews];
            break;
        case -1:
            [statusButton setHidden:YES];
            [cancelButton setHidden:YES];
            //状態のボタン
            [cameraButton setFrame:CGRectMake(statusButton.frame.origin.x, statusButton.frame.origin.y, cameraButton.frame.size.width, cameraButton.frame.size.height)];
            [self resizeSubviews];
            break;
        default:
            break;
    }
}

-(void) makeupByData:(MDPackage *)package{
    //upload image
    uploadedImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 136, 136)];
    [uploadedImage sd_setImageWithURL:[NSURL URLWithString:package.image] placeholderImage:[UIImage imageNamed:@"cargo"] options:SDWebImageRetryFailed];
    
    cameraButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [cameraButton sd_setImageWithURL:[NSURL URLWithString:package.image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"cargo"] options:SDWebImageRetryFailed];
    
    //address
    requestAddressView.zipField.text = [NSString stringWithFormat:@"〒%@", package.from_zip];
    [requestAddressView setAddressContent:[NSString stringWithFormat:@"%@ %@" ,package.from_pref, package.from_addr]];
    destinationAddressView.zipField.text = [NSString stringWithFormat:@"〒%@", package.to_zip];
    [destinationAddressView setAddressContent:[NSString stringWithFormat:@"%@ %@" ,package.to_pref, package.to_addr]];
    
    //size
    sizePicker.selectLabel.text = [NSString stringWithFormat:@"合計 %@cm 以内", package.size];
    
    //at_home_time
    //cusTodyTimePicker
    if([package.at_home_time[0][0] isEqualToString:@"-1"]){
        NSLog(@"at_home_time null");
    } else {
        NSString *at_home_hour = [NSString stringWithFormat:@"%@", package.at_home_time[0][1]];
        NSString *at_home_time_str = @"";
        if([at_home_hour isEqualToString:@"-1"]){
            at_home_time_str = [NSString stringWithFormat:@"%@ いつでも", package.at_home_time[0][0]];
        } else {
            at_home_time_str = [NSString stringWithFormat:@"%@ %@時〜%@時", package.at_home_time[0][0], package.at_home_time[0][1], package.at_home_time[0][2]];
        }
        cusTodyTimePicker.selectLabel.text = at_home_time_str;
    }
    
    //取扱説明書
    beCarefulPicker.selectLabel.text = (package.note == nil) ? @"特になし" : package.note;
    //price
    costPicker.selectLabel.text = [NSString stringWithFormat:@"%@円",package.request_amount];
    //at home time;
    
    NSString *deliver_limit = [NSString stringWithFormat:@"%@",package.deliver_limit];
    destinateTimePicker.selectLabel.text = [NSString stringWithFormat:@"%@時", [deliver_limit substringToIndex:13]];
    
    //expire
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSLocale systemLocale]];
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:00"];
    NSDate *expireDate =[dateFormat dateFromString:package.expire];
    
    NSTimeInterval timeBetween = [expireDate timeIntervalSinceNow];
    int hour = timeBetween/60/60;
    if (timeBetween < 0) {
        requestTerm.selectLabel.text = [NSString stringWithFormat:@"期限で取消された"];
    } else {
        requestTerm.selectLabel.text = [NSString stringWithFormat:@"%d時間以内",hour+1];
    }
    
    //resize
    [self resizeSubviews];
    
}

-(void) setDriverData:(MDDriver *)driver{
    _driver = driver;
    statusButton.selectLabel.text = driver.name;
    statusButton.buttonTitle.text = @"配送員";
    [statusButton setActive];
    
}

-(void) setReviewContent:(MDReview *)review{
    reviewWell = [[MDSelectRatingWell alloc]initWithFrame:CGRectMake(10, statusButton.frame.origin.y + statusButton.frame.size.height + 10, self.frame.size.width - 20, 100)];
    [reviewWell.selectRating.starLabel setRating:[review.star intValue]];
    [reviewWell setContentText:review.text];
    [_scrollView addSubview:reviewWell];
    
    [self resizeByReviews];
}

-(void) cameraButtonTouched {
        if([self.delegate respondsToSelector:@selector(cameraButtonTouched)]){
            [self.delegate cameraButtonTouched];
        }
}

-(UIImageView*) getUploadedImage{
    return uploadedImage;
}

-(void) reviewButtonTouched{
    if([self.delegate respondsToSelector:@selector(reviewButtonPushed)]){
        [self.delegate reviewButtonPushed];
    }
}

-(void) seeDriverProfile{
    if([self.delegate respondsToSelector:@selector(profileButtonPushed)]){
        [self.delegate profileButtonPushed];
    }
}

-(void) sizeDescriptionButtonTouched{
    if([self.delegate respondsToSelector:@selector(sizeDescriptionButtonPushed)]){
        [self.delegate sizeDescriptionButtonPushed];
    }
}

-(void) matchButtonTouched{
    if([self.delegate respondsToSelector:@selector(matchButtonPushed)]){
        [self.delegate matchButtonPushed];
    }
}

-(void) cancelButtonTouched{
    if([self.delegate respondsToSelector:@selector(cancelButtonPushed)]){
        [self.delegate cancelButtonPushed];
    }
}

-(void)addressButtonTouched:(MDAddressButton *)button{
    if([self.delegate respondsToSelector:@selector(addressButtonPushed:)]){
        [self.delegate addressButtonPushed:button];
    }
}

@end