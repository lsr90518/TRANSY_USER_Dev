//
//  MDReviewView.m
//  DistributionDriver
//
//  Created by 劉 松然 on 2015/05/08.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import "MDReviewView.h"
#import "MDWell.h"
#import "MDStarRatingBar.h"
#import "MDSelect.h"
#import "MDInput.h"
#import <UIImageView+WebCache.h>
#import "MDUtil.h"

@implementation MDReviewView{
    UIScrollView    *scrollView;
    //    UIView          *reviewView;
    MDStarRatingBar *reviewView;
    UIView          *commentView;
    UITextView      *commentTextView;
    UIButton        *postButton;
    UIImageView *profileImageView;
    MDInput     *nameInput;
    MDSelect    *phoneNumberButton;
    
    BOOL isNotTyping;
}

-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //add code
        [self setBackgroundColor:[UIColor whiteColor]];
        scrollView = [[UIScrollView alloc]initWithFrame:frame];
        
        [scrollView setContentSize:CGSizeMake(frame.size.width, frame.size.height-44)];
        scrollView.delegate = self;
        [self addSubview:scrollView];
        
        //well
        MDWell *descriptionWell = [[MDWell alloc]initWithFrame:CGRectMake(10, 10, frame.size.width - 20, 82)];
        [descriptionWell setContentText:@"配送員から、荷物を届け通知がありました。配送先へご確認の上、ドライバーの評価を行ってください。問題ある場合は、配送員にご連絡ください。"];
        [scrollView addSubview:descriptionWell];
        
        //profileview
        UIView *profileView = [[UIView alloc]initWithFrame:CGRectMake(descriptionWell.frame.origin.x, descriptionWell.frame.origin.y + descriptionWell.frame.size.height + 10, frame.size.width - 20, 110)];
        //profile Image
        profileImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 110)];
//        [profileImageView sd_setImageWithURL:[NSURL URLWithString:_driver placeholderImage:[UIImage imageNamed:@"cargo"] options:SDWebImageRetryFailed];
        [profileImageView setImage:[UIImage imageNamed:@"cargo"]];
        [profileView addSubview:profileImageView];
        
        //name
        nameInput = [[MDInput alloc]initWithFrame:CGRectMake(profileImageView.frame.origin.x + profileImageView.frame.size.width + 10,
                                                             profileImageView.frame.origin.y,
                                                             frame.size.width - 30 - profileImageView.frame.origin.x - profileImageView.frame.size.width,
                                                             50)];
        [nameInput.input setHidden:YES];
        [nameInput.title setFrame:CGRectMake(19, 16, nameInput.frame.size.width - 38, 18)];
        [profileView addSubview:nameInput];
        
        
        //連絡先
        phoneNumberButton = [[MDSelect alloc]initWithFrame:CGRectMake(nameInput.frame.origin.x, nameInput.frame.origin.y + nameInput.frame.size.height + 10, nameInput.frame.size.width, 50)];
        phoneNumberButton.buttonTitle.text = @"09028280392";
        [phoneNumberButton.buttonTitle sizeToFit];
        [phoneNumberButton.rightArrow setHidden:YES];
        [phoneNumberButton addTarget:self action:@selector(phoneButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [profileView addSubview:phoneNumberButton];
        
        [scrollView addSubview:profileView];
        
        
        
        
        //review view
        reviewView = [[MDStarRatingBar alloc]initWithFrame:CGRectMake(profileView.frame.origin.x, profileView.frame.origin.y + profileView.frame.size.height + 10, profileView.frame.size.width, 74)];
        reviewView.layer.cornerRadius = 1;
        reviewView.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        reviewView.layer.borderWidth = 0.5;
        [scrollView addSubview:reviewView];
        
        
        commentView = [[UIView alloc]initWithFrame:CGRectMake(reviewView.frame.origin.x, reviewView.frame.origin.y + reviewView.frame.size.height + 10, reviewView.frame.size.width, 100)];
        commentView.layer.cornerRadius = 1;
        commentView.layer.borderWidth = 0.5;
        commentView.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        [scrollView addSubview:commentView];
        
        commentTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, commentView.frame.size.width-20, commentView.frame.size.height - 20)];
        commentTextView.text = @"フリーコメント";
        commentTextView.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        commentTextView.delegate = self;
        [commentView addSubview:commentTextView];
        
        //button
        postButton = [[UIButton alloc]initWithFrame:CGRectMake(10, commentView.frame.origin.y + commentView.frame.size.height + 10, commentView.frame.size.width, 50)];
        [postButton setTitle:@"ドライバーを評価して依頼完了" forState:UIControlStateNormal];
        postButton.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
        [postButton setBackgroundColor:[UIColor colorWithRed:226.0/255.0 green:138.0/255.0 blue:0 alpha:1]];
        postButton.layer.cornerRadius = 2.5;
        [postButton addTarget:self action:@selector(postButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:postButton];
        
    }
    
    return self;
}

-(void) closeKeyBoard{
    [commentTextView resignFirstResponder];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    if(isNotTyping){
        textView.text = @"";
        isNotTyping = NO;
    }
    
    textView.textColor = [UIColor blackColor];
    CGPoint textViewPoint = CGPointMake(0, postButton.frame.size.height+100);
    [scrollView setContentOffset:textViewPoint animated:YES];
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if(textView.text.length < 1){
        textView.text = @"フリーコメント";
        textView.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        isNotTyping = YES;
    }
    
    int scrollOffset = [scrollView contentOffset].y;
    int contentBottomOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    if(scrollOffset > contentBottomOffset){
        CGPoint point = CGPointMake(0, contentBottomOffset);
        [scrollView setContentOffset:point animated:YES];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self closeKeyBoard];
}

-(void) postButtonTouched{
    [self closeKeyBoard];
    _review.star = [NSString stringWithFormat:@"%lu",reviewView.rating];
    _review.text = ([commentTextView.text isEqualToString:@"フリーコメント"]) ? @"" : commentTextView.text;
    if([self.delegate respondsToSelector:@selector(postButtonPushed)]){
        [self.delegate postButtonPushed];
    }
}

-(void) phoneButtonTouched:(MDSelect *)button{
    if([self.delegate respondsToSelector:@selector(phoneButtonPushed:)]){
        [self.delegate phoneButtonPushed:button];
    }
}

-(void) initWithPackage:(MDPackage *)package
                 driver:(MDDriver *)driver{
    _package = package;
    _driver = driver;
    _review = [[MDReview alloc]init];
    
    //profile image
    [profileImageView sd_setImageWithURL:[NSURL URLWithString:driver.image] placeholderImage:[UIImage imageNamed:@"cargo"] options:SDWebImageRetryFailed];
     
     
    //text
    NSString *reviewText = [NSString stringWithFormat:@"%@", _package.review[@"from_user"][@"text"]];
    NSString *reviewStar = [NSString stringWithFormat:@"%@", _package.review[@"from_user"][@"star"]];
    
    
    if(![reviewText isEqualToString:@"<null>"]){
        _review.text = reviewText;
        commentTextView.text = _review.text;
        commentTextView.textColor = [UIColor blackColor];
        isNotTyping = NO;
    } else {
        _review.text = @"";
        isNotTyping = YES;
    }
    
    if(![reviewStar isEqualToString:@"<null>"]){
        _review.star = reviewStar;
        [reviewView setRating: [_review.star integerValue]];
    } else {
        
        _review.star = @"5";
        [reviewView setRating: [_review.star integerValue]];
    }
    
    
    //driver
    nameInput.title.text = [NSString stringWithFormat:@"%@",_driver.name];;
    
    //phone number
    phoneNumberButton.buttonTitle.text = driver.phoneNumber;
    [phoneNumberButton.buttonTitle sizeToFit];
    
    
    [reviewView setRating:[_review.star integerValue]];
    
    
}

@end
