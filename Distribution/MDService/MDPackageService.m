//
//  MDPackageService.m
//  DistributionDriver
//
//  Created by Lsr on 5/2/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDPackageService.h"

@implementation MDPackageService

+(MDPackageService *)getInstance {
    
    static MDPackageService *sharedInstance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[MDPackageService alloc] init];
    });
    return sharedInstance;
}

-(void) initData{
    if(_packageList == nil){
        _packageList = [[NSMutableArray alloc]init];
        _completePackageList = [[NSMutableArray alloc]init];
        _reviewList = [[NSMutableArray alloc]init];
    }
}

-(void) initDataWithArray:(NSArray *)array{
    //重写 status
    //check 期限
    if(_packageList == nil){
        _packageList = [[NSMutableArray alloc]init];
        _completePackageList = [[NSMutableArray alloc]init];
        _reviewList  = [[NSMutableArray alloc]init];
    } else {
        [_packageList removeAllObjects];
        [_completePackageList removeAllObjects];
        [_reviewList removeAllObjects];
    }
    
    for (int i = 0;i < array.count;i++) {
        NSString *image = [array objectAtIndex:i][@"image"];
        if(![image isEqual:@""]){
            MDPackage *tmpPackage = [[MDPackage alloc]initWithData:[array objectAtIndex:i]];
            //check
            
            [_packageList addObject:tmpPackage];
            
            NSString *star = [NSString stringWithFormat:@"%@", tmpPackage.userReview.star];
            if(![star isEqualToString:@""]){
                [_reviewList addObject:tmpPackage.userReview];
                [_completePackageList addObject:tmpPackage];
            }
        }
    }
}

-(void) initDataWithArray:(NSArray *)array SortByDate:(BOOL)sort{
    [self initDataWithArray:array];
    if(sort){
        [_packageList sortedArrayUsingSelector:@selector(compareByDate:)];
    }
}


-(void) initDataWithArray:(NSArray *)array
             WithDistance:(CLLocation *)location{
    if(_packageList == nil){
        _packageList = [[NSMutableArray alloc]init];
    } else {
        [_packageList removeAllObjects];
    }
    
    NSMutableArray *tmpList = [[NSMutableArray alloc]init];
    
    for (int i = 0;i < array.count;i++) {
        NSString *image = [array objectAtIndex:i][@"image"];
        if(![image isEqual:[NSNull null]]){
            MDPackage *tmpPackage = [[MDPackage alloc]initWithData:[array objectAtIndex:i]];
            [tmpList addObject:tmpPackage];
        }
    }
    //sort
    MKMapPoint userLocation = MKMapPointForCoordinate(location.coordinate);
    
    [_packageList addObjectsFromArray:[tmpList sortedArrayUsingComparator:^NSComparisonResult(MDPackage* obj1, MDPackage* obj2) {
        //;
        CLLocationCoordinate2D location1 = CLLocationCoordinate2DMake([obj1.from_lat floatValue], [obj1.from_lng floatValue]);
        MKMapPoint mapPoint1 = MKMapPointForCoordinate(location1);
        CLLocationCoordinate2D location2 = CLLocationCoordinate2DMake([obj2.from_lat floatValue], [obj2.from_lng floatValue]);
        MKMapPoint mapPoint2 = MKMapPointForCoordinate(location2);
        CLLocationDistance distance1 = MKMetersBetweenMapPoints(mapPoint1, userLocation);
        obj1.distance = [NSString stringWithFormat:@"%d",(int)distance1];
        CLLocationDistance distance2 = MKMetersBetweenMapPoints(mapPoint2, userLocation);
        obj2.distance = [NSString stringWithFormat:@"%d", (int)distance2];
        
        if(distance1 > distance2){
            return (NSComparisonResult)NSOrderedDescending;
        } else {
            return (NSComparisonResult)NSOrderedAscending;
        }
        
    }]];
}

-(NSMutableArray *)getPackageListByPackage:(MDCurrentPackage *)package{
    NSMutableArray *tmpPackageList = [[NSMutableArray alloc]init];
    [_packageList enumerateObjectsUsingBlock:^(MDPackage *obj, NSUInteger idx, BOOL *stop) {
        //
        int flag = 0;
        if([obj.request_amount intValue] > [[MDCurrentPackage getInstance].request_amount intValue]){
            flag++;
        }
        if([obj.size intValue] < [[MDCurrentPackage getInstance].size intValue]){
            flag++;
        }
        if([obj.distance intValue] < [[MDCurrentPackage getInstance].distance intValue]){
            flag++;
        }
        NSDateFormatter *tmpFormatter = [[NSDateFormatter alloc]init];
        [tmpFormatter setLocale:[NSLocale systemLocale]];
        [tmpFormatter setDateFormat:@"YYYY-MM-dd HH:mm:00"];
        NSDate *currentPackageDate = [tmpFormatter dateFromString:[MDCurrentPackage getInstance].deliver_limit];
        NSDate *packageDate = [tmpFormatter dateFromString:obj.deliver_limit];
        
        NSTimeInterval time=[packageDate timeIntervalSinceDate:currentPackageDate];
        if(time > 0){
            flag++;
        }
        if(flag == 4){
            [tmpPackageList addObject:obj];
        }
    }];
    
    return tmpPackageList;
}

-(BOOL) checkDate:(NSString *)dateStr {
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:00"];//设定时间格式,这里可以设置成自己需要的格式
    NSDate *givenDate =[dateFormat dateFromString:dateStr];
    
    NSTimeInterval interval = [givenDate timeIntervalSinceNow];
    
    if(interval > 0){
        return YES;
    } else {
        return NO;
    }
}

-(int)getAverageStar{
    __block int allStar = 0;
    int average = 5;
    
    if([_reviewList count] > 0){
        [_reviewList enumerateObjectsUsingBlock:^(MDReview *obj, NSUInteger idx, BOOL *stop) {
            allStar = allStar + [obj.star intValue];
        }];
        
        average = (int)(allStar / [_reviewList count]);
        
        return average;
    } else {
        return 0;
    }
}

-(MDPackage *)getPackageByPackageId:(NSString *)packageId{
    __block MDPackage *returnPakcage;
    [_packageList enumerateObjectsUsingBlock:^(MDPackage *obj, NSUInteger idx, BOOL *stop) {
        //
        if([obj.package_id isEqualToString:packageId]){
            returnPakcage = obj;
        }
    }];
    
    return returnPakcage;
}

@end
