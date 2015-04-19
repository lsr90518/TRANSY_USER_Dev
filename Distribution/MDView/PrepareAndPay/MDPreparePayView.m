//
//  MDPreparePayView.m
//  Distribution
//
//  Created by Lsr on 3/31/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDPreparePayView.h"
#import "MDSelect.h"
#import "MDCheckBox.h"
#import "MDNoframeButton.h"
#import "MDUser.h"

@implementation MDPreparePayView {
    UILabel *numberLeft;
    UILabel *numberRight;
    UIButton *cameraButton;
    UIImageView *uploadedImage;
    MDSelect *phoneNumber;
    MDSelect *requestPerson;
}

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        MDUser *user = [MDUser getInstance];
        [user initDataClear];
        //init view
        [self setBackgroundColor:[UIColor whiteColor]];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        _scrollView.delegate = self;
        [_scrollView setContentSize:CGSizeMake(frame.size.width, 780)];
        [_scrollView setBackgroundColor:[UIColor whiteColor]];
        [_scrollView setScrollEnabled:YES];
        [self addSubview:_scrollView];
        
        //back button
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setTitle:@"戻る" forState:UIControlStateNormal];
        _backButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
        _backButton.frame = CGRectMake(0, 0, 25, 44);
        [_backButton addTarget:self action:@selector(backButtonPushed) forControlEvents:UIControlEventTouchUpInside];
        
        //code view
        UIView * codeView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, frame.size.width-20, 78)];
        codeView.layer.cornerRadius = 2.5;
        codeView.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        codeView.layer.borderWidth = 0.5;
        [_scrollView addSubview:codeView];

        //说明文
        NSString *labelText = @"左図を荷物の外側の目立つ部分に記入し、荷物の全体を撮影してください。";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineHeightMultiple:2.0];//调整行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        UILabel *discriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(codeView.frame.size.width/2+20, 0, codeView.frame.size.width/2-40, 70)];
        discriptionLabel.attributedText = attributedString;
        discriptionLabel.numberOfLines = 3;
        discriptionLabel.textColor = [UIColor colorWithRed:119.0/255.0 green:119.0/255.0 blue:119.0/255.0 alpha:1];
        discriptionLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:11];
        [codeView addSubview:discriptionLabel];
        
        //线和数字
        UIImageView *boardLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 118, 21)];
        [boardLine setImage:[UIImage imageNamed:@"boardLine"]];
        [boardLine setCenter:CGPointMake(codeView.frame.size.width/4, codeView.frame.size.height/2)];
        [codeView addSubview:boardLine];
        
        //numberLeft
        numberLeft = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, 59, 12)];
        numberLeft.text = @"32232";
        numberLeft.textColor = [UIColor blackColor];
        numberLeft.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:13.6];
        [boardLine addSubview:numberLeft];
        //numberRight
        numberRight = [[UILabel alloc]initWithFrame:CGRectMake(59, 8, 59, 12)];
        numberRight.text = @"32232";
        numberRight.textAlignment = NSTextAlignmentRight;
        numberRight.textColor = [UIColor blackColor];
        numberRight.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:13.6];
        [boardLine addSubview:numberRight];
        
        //cameraButton
        cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 88, frame.size.width-20, 106)];
        [cameraButton setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
        UIImageView *cameraIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 42)];
        [cameraIcon setImage:[UIImage imageNamed:@"whiteCamera"]];
        [cameraIcon setCenter:CGPointMake(cameraButton.frame.size.width/2, cameraButton.frame.size.height/2)];
        [cameraButton addTarget:self action:@selector(cameraButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [cameraButton addSubview:cameraIcon];
        [_scrollView addSubview:cameraButton];
        
        requestPerson = [[MDSelect alloc]initWithFrame:CGRectMake(10, 204, frame.size.width-20, 50)];
        requestPerson.buttonTitle.text = @"依頼主名";
        requestPerson.selectLabel.text = [NSString stringWithFormat:@"%@ %@",user.lastname,user.firstname];
        [requestPerson addTarget:self action:@selector(requestPersonTouched) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:requestPerson];
        
        phoneNumber = [[MDSelect alloc]initWithFrame:CGRectMake(10, 264, frame.size.width-20, 50)];
        phoneNumber.buttonTitle.text = @"電話番号";
        phoneNumber.selectLabel.text = [NSString stringWithFormat:@"%@",user.phoneNumber];
        [phoneNumber addTarget:self action:@selector(phoneNumberTouched) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:phoneNumber];
        
        MDSelect *pay = [[MDSelect alloc]initWithFrame:CGRectMake(10, 324, frame.size.width-20, 50)];
        pay.buttonTitle.text = @"お支払い方法";
        pay.selectLabel.text = [NSString stringWithFormat:@"%@",user.creditNumber];
        [_scrollView addSubview:pay];
        
        //checkbox
        MDCheckBox *checkBox = [[MDCheckBox alloc]initWithFrame:CGRectMake(10, 392, 34, 34)];
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
        
        //button
        self.postButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.origin.x+10, 449, frame.size.width-20, 60)];
        [self.postButton setBackgroundColor:[UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1]];
        [self.postButton setTitle:@"以上で発注する" forState:UIControlStateNormal];
        self.postButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:18];
        [_postButton addTarget:self action:@selector(postButtonPushed) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:self.postButton];
        
        
    }
    return self;
}

-(void) updateData{
    requestPerson.selectLabel.text = [NSString stringWithFormat:@"%@ %@",[MDUser getInstance].lastname,[MDUser getInstance].firstname];
    
    phoneNumber.selectLabel.text = [NSString stringWithFormat:@"%@",[MDUser getInstance].phoneNumber];
}

-(void) backButtonPushed {
    if([self.delegate respondsToSelector:@selector(backButtonPushed)]) {
        [self.delegate backButtonPushed];
    }
}

-(void) initPackageNumber:(NSString *)packageNumber {
    NSString *tmpStr = [NSString stringWithFormat:@"%@",packageNumber];
    numberLeft.text = [NSString stringWithFormat:@"%@", [tmpStr substringToIndex:5]];
    numberRight.text = [NSString stringWithFormat:@"%@", [tmpStr substringFromIndex:5]];
}

-(void) cameraButtonTouched {
    if([self.delegate respondsToSelector:@selector(cameraButtonTouched)]){
        [self.delegate cameraButtonTouched];
    }
}

-(void) setBoxImage:(UIImage *)image {
    if (uploadedImage == nil) {
        uploadedImage = [[UIImageView alloc]initWithImage:image];
    }
    float x = image.size.height/cameraButton.frame.size.height;
    uploadedImage.frame = CGRectMake(cameraButton.frame.size.width/2-uploadedImage.frame.size.width/x/2,
                                     0,
                                     uploadedImage.frame.size.width/x,
                                     uploadedImage.frame.size.height/x);
    [cameraButton addSubview:uploadedImage];
}

-(void) postButtonPushed {
    if([self.delegate respondsToSelector:@selector(postData)]){
        [self.delegate postData];
    }
}

-(void) requestPersonTouched {
    if([self.delegate respondsToSelector:@selector(requestPersonPushed)]){
        [self.delegate requestPersonPushed];
    }
}

-(void) phoneNumberTouched{
    if([self.delegate respondsToSelector:@selector(phoneNumberPushed)]){
        [self.delegate phoneNumberPushed];
    }
}

@end
