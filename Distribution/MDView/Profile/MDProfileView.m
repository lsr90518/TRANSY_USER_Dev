//
//  MDProfileView.m
//  DistributionDriver
//
//  Created by Lsr on 4/26/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDProfileView.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import "MDTitleWell.h"
#import "MDUser.h"
#import "MDUtil.h"
#import "MDReview.h"
#import "MDStarRatingBar.h"
#import "MDReviewWell.h"

@implementation MDProfileView{
    UIImageView *profileImageView;
    MDInput     *nameInput;
    MDSelect    *phoneNumberButton;
    MDWell      *descriptionWell;
    MDTitleWell      *introWell;
    MDInput     *countNumber;
    MDReviewWell      *previewWell;
    UIButton *blockButton;
    UIButton *policeButton;
    MDStarRatingBar *reviewView;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        //scrollview
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        [self addSubview:_scrollView];
        
        //profile Image
        profileImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 110, 110)];
//        [profileImageView sd_setImageWithURL:[NSURL URLWithString:[MDUser getInstance].image] placeholderImage:[UIImage imageNamed:@"cargo"] options:SDWebImageRetryFailed];
        [profileImageView setImage:[UIImage imageNamed:@"cargo"]];
        [_scrollView addSubview:profileImageView];
        
        //name
        nameInput = [[MDInput alloc]initWithFrame:CGRectMake(profileImageView.frame.origin.x + profileImageView.frame.size.width + 10,
                                                             profileImageView.frame.origin.y,
                                                             frame.size.width - 10 - profileImageView.frame.origin.x - profileImageView.frame.size.width - 10,
                                                             50)];
        
        [nameInput.input setHidden:YES];
        [nameInput.title setFrame:CGRectMake(19, 16, nameInput.frame.size.width - 38, 18)];
        [_scrollView addSubview:nameInput];
        
        //review
        reviewView = [[MDStarRatingBar alloc]initWithFrame:CGRectMake(nameInput.frame.origin.x,
                                                                      nameInput.frame.size.height + nameInput.frame.origin.y + 10,
                                                                      nameInput.frame.size.width,
                                                                      nameInput.frame.size.height)];
        reviewView.layer.cornerRadius = 2.5;
        reviewView.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        reviewView.layer.borderWidth = 0.5;
        [reviewView setUserInteractionEnabled:NO];
        [_scrollView addSubview:reviewView];
        
        //連絡先
        phoneNumberButton = [[MDSelect alloc]initWithFrame:CGRectMake(10, profileImageView.frame.origin.y + profileImageView.frame.size.height + 10, frame.size.width - 20, 50)];
        phoneNumberButton.buttonTitle.text = @"連絡先";
        [phoneNumberButton.buttonTitle sizeToFit];
        phoneNumberButton.selectLabel.text = @"";
        [phoneNumberButton addTarget:self action:@selector(phoneButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:phoneNumberButton];
        
        //説明文
        descriptionWell = [[MDWell alloc]initWithFrame:CGRectMake(10, phoneNumberButton.frame.origin.y + phoneNumberButton.frame.size.height, frame.size.width-20, 100)];
        descriptionWell.contentText = @"荷物について、ご不明点や連絡が必要な際は、上記連絡先よりドライバーに直接ご問い合わせたください。当サービスでは、サービス向上のためドライバーの方の免許証、保険証の確認しております。";
        [_scrollView addSubview:descriptionWell];
        
        //自己紹介
        introWell = [[MDTitleWell alloc]initWithFrame:CGRectMake(10, descriptionWell.frame.origin.y + descriptionWell.frame.size.height + 10, frame.size.width-20, 104)];
        introWell.layer.cornerRadius = 2.5;
        
        [_scrollView addSubview:introWell];
        
        
        
        //荷物回数
        countNumber = [[MDInput alloc]initWithFrame:CGRectMake(10, introWell.frame.origin.y + introWell.frame.size.height + 10, frame.size.width -20, 50)];
        countNumber.title.text = @"今まで運んだ荷物";
        [countNumber.title sizeToFit];
//        countNumber.input.text = [NSString stringWithFormat:@"%@回",[MDUser getInstance].deposit];
        [countNumber.input setUserInteractionEnabled:NO];
        [_scrollView addSubview:countNumber];
        
        //評価
        previewWell = [[MDReviewWell alloc]initWithFrame:CGRectMake(10, countNumber.frame.origin.y + countNumber.frame.size.height - 2, frame.size.width - 20, 100)];
        [previewWell setBackgroundColor:[UIColor whiteColor]];
        [_scrollView addSubview:previewWell];
        
        //ブロック
        blockButton = [[UIButton alloc]initWithFrame:CGRectMake(10, previewWell.frame.origin.y + previewWell.frame.size.height+10, frame.size.width - 20, 50)];
        [blockButton setTitle:@"このドライバーをブロックする" forState:UIControlStateNormal];
        [blockButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        blockButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
        blockButton.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        blockButton.layer.borderWidth = 0.5;
        blockButton.layer.cornerRadius = 1;
        [_scrollView addSubview:blockButton];

        //通報
        policeButton = [[UIButton alloc]initWithFrame:CGRectMake(10, blockButton.frame.origin.y + blockButton.frame.size.height+10, frame.size.width - 20, 50)];
        [policeButton setTitle:@"このドライバーを通報する" forState:UIControlStateNormal];
        [policeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        policeButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
        policeButton.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        policeButton.layer.borderWidth = 0.5;
        policeButton.layer.cornerRadius = 1;
        [policeButton addTarget:self action:@selector(reportButtonPushed) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:policeButton];
        
        [_scrollView setContentSize:CGSizeMake(frame.size.width, policeButton.frame.origin.y + policeButton.frame.size.height + 50)];
    }
    return self;
}

-(void) setDriverData:(MDDriver *)driver{
    
    //photo
    [profileImageView sd_setImageWithURL:[NSURL URLWithString:driver.image] placeholderImage:[UIImage imageNamed:@"cargo"] options:SDWebImageRetryFailed];
    
    //name
    nameInput.title.text = driver.name;
    [nameInput.title setFrame:CGRectMake(19, 16, nameInput.frame.size.width - 38, 18)];
    
    //phone number
    phoneNumberButton.selectLabel.text = driver.phoneNumber;
    
    //star
    float averageStar = [driver.average_star floatValue];
    [reviewView setRating:(int)averageStar];
    
    //intro
    [introWell setDataWithTitle:@"ドライバー自己紹介" Text:driver.intro];
    
    //回数
    countNumber.input.text = [NSString stringWithFormat:@"%@回",driver.delivered_package];
    
    //内容
    if([driver.reviews count] > 0){
        MDReview *lastReview = [driver.reviews firstObject];
        [previewWell setDataWithTitle:lastReview.user_name star:[lastReview.star integerValue] text:lastReview.text];
    } else {
        [previewWell removeFromSuperview];
    }
}

-(void) phoneButtonTouched:(MDSelect *)button{
    if([self.delegate respondsToSelector:@selector(phoneButtonPushed:)]){
        [self.delegate phoneButtonPushed:button];
    }
}

-(void) blockButtonTouched{
    if([self.delegate respondsToSelector:@selector(blockButtonPushed)]){
        [self.delegate blockButtonPushed];
    }
}

@end
