//
//  MDDevice.h
//  Distribution
//
//  Created by Lsr on 4/20/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDDevice : NSObject

@property (strong, nonatomic) NSString *iosVersion;

+(MDDevice *)getInstance;

@end
