//
//  MDSelect.m
//  Distribution
//
//  Created by Lsr on 3/30/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDSelect.h"

@implementation MDSelect

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addTarget:self action:@selector(buttonTouched) forControlEvents:UIControlEventTouchUpInside];
        
        //add frame
        self.layer.cornerRadius = 2.5;
        self.layer.borderColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1].CGColor;
        self.layer.borderWidth = 0.5;
        
        
        //add title
        self.buttonTitle = [[UILabel alloc]initWithFrame:CGRectMake(19, 18, 90, 14)];
        self.buttonTitle.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:14];
        [self addSubview:self.buttonTitle];
        
        //add select
        self.selectLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width-180, 19, 149, 13)];
        self.selectLabel.textAlignment = NSTextAlignmentRight;
        self.selectLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14];
        [self addSubview:self.selectLabel];
        
        //add right arrow
        self.rightArrow = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-22, 20, 7, 11)];
        [self.rightArrow setImage:[UIImage imageNamed:@"rightArrow"]];
        [self addSubview:self.rightArrow];
        //add options
    }
    
    return self;
}

-(void) setUnactive {
    self.selectLabel.textColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
}

-(void) setActive {
    self.selectLabel.textColor = [UIColor blackColor];
}

-(void) setReadOnly {
    [self.rightArrow setHidden:YES];
    [self setUserInteractionEnabled:NO];
    
}

-(void) buttonTouched {
    if ([self.delegate respondsToSelector:@selector(buttonPushed:)]){
        [self.delegate buttonPushed:self];
    }
}

-(void) setOptions:(NSMutableArray *)options :(NSString *)startStr :(NSString *)lastStr{
    if(_options == nil){
        _options = [[NSMutableArray alloc]init];
    }
    if(_showOptions == nil){
        _showOptions = [[NSMutableArray alloc]init];
    }
    
    [_options removeAllObjects];
    [_showOptions removeAllObjects];
    
    for (int i = 0; i<[options count]; i++) {
        _options[i] = [[NSMutableArray alloc]init];
        _showOptions[i] = [[NSMutableArray alloc]init];
        for(int j = 0;j<[options[i] count];j++) {
            [_options[i] addObject:options[i][j]];
            [_showOptions[i] addObject:[NSString stringWithFormat:@"%@%@%@",startStr,options[i][j],lastStr]];
        }
    }
}


@end
