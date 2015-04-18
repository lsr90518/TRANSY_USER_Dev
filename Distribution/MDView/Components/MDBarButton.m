//
//  MDBarButton.m
//  Distribution
//
//  Created by Lsr on 4/11/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDBarButton.h"

typedef NS_ENUM (NSInteger, BUTTON_TYPE){
    BACK_BUTTON,
    NEXT_BUTTON,
    POST_BUTTON
};

@implementation MDBarButton

-(id)initWithFrameAndStyle:(CGRect)frame:(BUTTON_TYPE)style {
    
    
    
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.titleLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:12];
    
    
    switch (style) {
        case BACK_BUTTON:
            [self setTitle:@"戻る" forState:UIControlStateNormal];
            self.frame = CGRectMake(0, 0, 60, 44);
            break;
        case NEXT_BUTTON:
            [self setTitle:@"次へ" forState:UIControlStateNormal];
            self.frame = CGRectMake(0, 0, 24, 44);
            break;
        case POST_BUTTON:
            [self setTitle:@"以下で投稿" forState:UIControlStateNormal];
            self.frame = CGRectMake(0, 0, 60, 44);
            break;
        default:
            break;
    }
    
    return self;
}

@end
