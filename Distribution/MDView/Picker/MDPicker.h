//
//  MDPicker.h
//  Distribution
//
//  Created by 劉 松然 on 2015/04/28.
//  Copyright (c) 2015年 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MDPickerDelegate;

@interface MDPicker : UIView<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) UIPickerView  *pickerView;
@property (strong, nonatomic) UIButton      *doneButton;
@property (strong, nonatomic) UIButton      *cancelButton;

@property (strong, nonatomic) id<MDPickerDelegate> delegate;

-(void) setOptions:(NSMutableArray *)dataArray:(int)col;

@end

@protocol MDPickerDelegate <NSObject>

@optional
-(NSString *)didSelectedRow;

@end
