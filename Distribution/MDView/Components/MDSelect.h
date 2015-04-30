//
//  MDSelect.h
//  Distribution
//
//  Created by Lsr on 3/30/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MDSelectDelegate;

@interface MDSelect : UIButton

@property (strong, nonatomic) UILabel       *buttonTitle;
@property (strong, nonatomic) UILabel       *selectLabel;
@property (strong, nonatomic) UIImageView   *rightArrow;
@property (strong, nonatomic) NSMutableArray       *options;
@property (strong, nonatomic) NSMutableArray       *showOptions;
@property (nonatomic, assign) id<MDSelectDelegate> delegate;

-(void) setUnactive;
-(void) setActive;
-(void) setReadOnly;
-(void) setOptions:(NSMutableArray *)options :(NSString *)startStr:(NSString *)lastStr;

@end


@protocol MDSelectDelegate <NSObject>

@optional

-(void) buttonPushed:(MDSelect *)view;

@end