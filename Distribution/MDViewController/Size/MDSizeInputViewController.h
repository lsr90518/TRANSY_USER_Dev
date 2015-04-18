//
//  MDSizeInputViewController.h
//  Distribution
//
//  Created by Lsr on 4/14/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDCurrentPackage.h"

@interface MDSizeInputViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIScrollView *scrollView;

-(void) initWithData:(NSArray *)datas;

@end
