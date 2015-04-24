//
//  MDPreparePayViewController.h
//  Distribution
//
//  Created by Lsr on 3/31/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDPreparePayView.h"
#import "MDUtil.h"

@interface MDPreparePayViewController : UIViewController <PreparePayViewDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) MDPreparePayView *preparePayView;

@property (strong, nonatomic) UIImage *packageImage;


@end
