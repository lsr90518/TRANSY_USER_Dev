//
//  MDAPI.m
//  Distribution
//
//  Created by Lsr on 4/8/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDAPI.h"
#import "MDUser.h"
#import "MDCurrentPackage.h"

@implementation MDAPI {
    MKNetworkEngine *_engine;
}

#pragma mark - Init
+ (MDAPI *)sharedAPI
{
    static MDAPI *sharedInstance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[MDAPI alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initApi];
    }
    return self;
}

- (void)initApi
{
    _engine = [[MKNetworkEngine alloc] initWithHostName:API_HOST_NAME];
}

#pragma mark - Self Methods
- (void)callApi:(NSDictionary *)params
        withUrl:(NSString *)url
     withImages:(NSArray *)images
 withHttpMethod:(NSString *)method
     onComplete:(void (^)(MKNetworkOperation *completeOperation))response
        onError:(void (^)(MKNetworkOperation *completeOperarion, NSError *error))error
{
    MKNetworkOperation *op     = [_engine operationWithPath:url
                                                     params:params
                                                 httpMethod:method];
    
    [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSData *imageData;
                if (UIImagePNGRepresentation(obj) == nil)
                {
                    imageData = UIImageJPEGRepresentation(obj, 0.3);
                }
                else
                {
                    imageData = UIImagePNGRepresentation(obj);
                }
        [op addData:imageData forKey:@"image"];
    }];
    
    [op addCompletionHandler:response errorHandler:error];
    [_engine enqueueOperation:op];
}



#pragma methods
-(void) createUserWithPhone:(NSString *)phone
                 onComplete:(void (^)(MKNetworkOperation *))complete
                    onError:(void (^)(MKNetworkOperation *, NSError *))error {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:phone forKey:@"phone"];
    
    [self callApi:dic
          withUrl:API_USER_CREATE
       withImages:@[]
   withHttpMethod:@"POST"
       onComplete:complete
          onError:error];
}

-(void) checkUserWithPhone:(NSString *)phone
                  withCode:(NSString *)code
                onComplete:(void (^)(MKNetworkOperation *))complete
                   onError:(void (^)(MKNetworkOperation *, NSError *))error{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:phone forKey:@"phone"];
    [dic setValue:code forKey:@"check_number"];
    
    
    [self callApi:dic
          withUrl:API_USER_CHECKNUMBER
       withImages:@[]
   withHttpMethod:@"GET"
       onComplete:complete
          onError:error];
}

-(void) newProfileByUser:(MDUser *)user
              onComplete:(void (^)(MKNetworkOperation *))complete
                 onError:(void (^)(MKNetworkOperation *, NSError *))error{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[MDUtil internationalPhoneNumber: user.phoneNumber] forKey:@"phone"];
    [dic setValue:user.checknumber forKey:@"check_number"];
    [dic setValue:[NSString stringWithFormat:@"%@ %@",user.lastname,user.firstname] forKey:@"name"];
    [dic setValue:user.password forKey:@"password"];
    [dic setValue:@"ios" forKey:@"client"];
    
    [self callApi:dic
          withUrl:API_USER_NEWPROFILE
       withImages:@[]
   withHttpMethod:@"POST"
       onComplete:complete
          onError:error];
}

-(void) updateProfileByUser:(MDUser *)user
               sendPassword:(BOOL) sendPassword
                 onComplete:(void (^)(MKNetworkOperation *))complete
                    onError:(void (^)(MKNetworkOperation *, NSError *))error{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:user.userHash forKey:@"hash"];
    [dic setValue:[NSString stringWithFormat:@"%@ %@",user.lastname,user.firstname] forKey:@"name"];
    if(sendPassword)[dic setValue:user.password forKey:@"password"];
    [dic setValue:@"ios" forKey:@"client"];
    
    [self callApi:dic
          withUrl:API_USER_UPDATEPROFILE
       withImages:@[]
   withHttpMethod:@"POST"
       onComplete:complete
          onError:error];
}

-(void) loginWithPhone:(NSString *)phoneNumber
              password:(NSString *)password
            onComplete:(void (^)(MKNetworkOperation *))complete
               onError:(void (^)(MKNetworkOperation *, NSError *))error {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:phoneNumber forKey:@"phone"];
    [dic setValue:password forKey:@"password"];
    [dic setValue:USER_DEVICE forKey:@"client"];
    
    [self callApi:dic
          withUrl:API_USER_LOGIN
       withImages:@[]
   withHttpMethod:@"POST"
       onComplete:complete
          onError:error];
}

-(void) registerBaggageWithHash:(NSString *)hash
                     OnComplete:(void (^)(MKNetworkOperation *))complete
                          onError:(void (^)(MKNetworkOperation *, NSError *))error {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:hash         forKey:@"hash"];
    [dic setObject:USER_DEVICE  forKey:@"client"];
    [dic setObject:[MDCurrentPackage getInstance].requestType       forKey:@"type"];
    [dic setObject:[MDCurrentPackage getInstance].from_pref         forKey:@"from_pref"];
    [dic setObject:[MDCurrentPackage getInstance].from_addr         forKey:@"from_addr"];
    [dic setObject:[MDCurrentPackage getInstance].from_zip          forKey:@"from_zip"];
    [dic setObject:[MDCurrentPackage getInstance].from_lat          forKey:@"from_lat"];
    [dic setObject:[MDCurrentPackage getInstance].from_lng          forKey:@"from_lng"];
    [dic setObject:[MDCurrentPackage getInstance].to_zip            forKey:@"to_zip"];
    [dic setObject:[MDCurrentPackage getInstance].to_pref           forKey:@"to_pref"];
    [dic setObject:[MDCurrentPackage getInstance].to_addr           forKey:@"to_addr"];
    [dic setObject:[MDCurrentPackage getInstance].to_lat            forKey:@"to_lat"];
    [dic setObject:[MDCurrentPackage getInstance].to_lng            forKey:@"to_lng"];
    [dic setObject:[MDCurrentPackage getInstance].request_amount    forKey:@"request_amount"];
    [dic setObject:[MDCurrentPackage getInstance].note              forKey:@"note"];
    [dic setObject:[MDCurrentPackage getInstance].size              forKey:@"size"];
    NSString *at_home_time = [NSString stringWithFormat:@"[%@,%@,%@]",[MDCurrentPackage getInstance].at_home_time[0][0], [MDCurrentPackage getInstance].at_home_time[0][1],[MDCurrentPackage getInstance].at_home_time[0][2]];
    NSLog(@"at home time %@", at_home_time);
    [dic setObject:at_home_time      forKey:@"at_home_time"];
    [dic setObject:[MDCurrentPackage getInstance].deliver_limit     forKey:@"deliver_limit"];
    [dic setObject:[MDCurrentPackage getInstance].expire            forKey:@"expire"];
    
    [self callApi:dic
          withUrl:API_PACKAGE_RESIGER
       withImages:@[]
   withHttpMethod:@"POST"
       onComplete:complete
          onError:error];
}

-(void) orderWithHash:(NSString *)hash
                  packageId:(NSString *)package_id
                      imageData:(NSData *)image_data
                 OnComplete:(void (^)(MKNetworkOperation *))complete
                    onError:(void (^)(MKNetworkOperation *, NSError *))error{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:hash forKey:@"hash"];
    [dic setObject:USER_DEVICE forKey:@"client"];
    [dic setObject:package_id forKey:@"package_id"];
    
    MKNetworkOperation *op     = [_engine operationWithPath:API_PACKAGE_ORDER
                                                     params:dic
                                                 httpMethod:@"POST"];
    
    [op addData:image_data forKey:@"image"];
    
    [op addCompletionHandler:complete errorHandler:error];
    [_engine enqueueOperation:op];
}

-(void) updatePhoneNumberWithOldPhoneNumber:(NSString *)oldPhoneNumber
                             newPhoneNumber:(NSString *)newPhoneNumber
                                 OnComplete:(void (^)(MKNetworkOperation *))complete
                                    onError:(void (^)(MKNetworkOperation *, NSError *))error {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:oldPhoneNumber   forKey:@"phone"];
    [dic setObject:newPhoneNumber   forKey:@"new_phone"];
    
    [self callApi:dic
          withUrl:API_USER_UPDATE_PHONE
       withImages:@[]
   withHttpMethod:@"POST"
       onComplete:complete
          onError:error];
}

-(void)getMyPackageWithHash:(NSString *)hash
                 OnComplete:(void (^)(MKNetworkOperation *))complete
                    onError:(void (^)(MKNetworkOperation *, NSError *))error{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:hash forKey:@"hash"];
    [dic setObject:USER_DEVICE forKey:@"client"];
    
    [self callApi:dic
          withUrl:API_GET_MY_PACKAGE
       withImages:@[]
   withHttpMethod:@"GET"
       onComplete:complete
          onError:error];
}

-(void) editMyPackageWithHash:(NSString *)hash
                      Package:(NSDictionary *)package
                   OnComplete:(void (^)(MKNetworkOperation *))complete
                      onError:(void (^)(MKNetworkOperation *, NSError *))error{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:hash forKey:@"hash"];
    [dic setObject:USER_DEVICE forKey:@"client"];
    [dic setObject:package[@"id"] forKey:@"package_id"];
    [dic setObject:package[@"expire"] forKey:@"expire"];
    [dic setObject:package[@"note"] forKey:@"note"];
    
    [self callApi:dic
          withUrl:API_EDIT_MY_PACKAGE
       withImages:@[]
   withHttpMethod:@"POST"
       onComplete:complete
          onError:error];
}

@end
