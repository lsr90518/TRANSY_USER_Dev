//
//  MDTabButton.h
//  Distribution
//
//  Created by Lsr on 3/27/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger{
    TAB_REQUEST,
    TAB_DELIVERY,
    TAB_SETTING
}TAB_TYPE;

@interface MDTabButton : UIButton

// Button Type
@property (nonatomic) TAB_TYPE type;
@property (strong, nonatomic) UIImageView *iconImageView;

- (id)initWithFrame:(CGRect)frame withTabType:(TAB_TYPE)type;
- (void)setButtonImage:(BOOL)selected;

@end
