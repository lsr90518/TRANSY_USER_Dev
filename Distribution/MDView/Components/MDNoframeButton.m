//
//  MDNoframeButton.m
//  Distribution
//
//  Created by Lsr on 4/7/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDNoframeButton.h"

@implementation MDNoframeButton

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if( self ) {
        //init with frame
        
        self.buttonTittle = [[UILabel alloc]initWithFrame:frame];
        self.buttonTittle.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:14];
        
        self.buttonTittle.textColor = [UIColor colorWithRed:30/255.0 green:132/255.0 blue:158/255.0 alpha:1];
    }
    
    return self;
}

@end
