//
//  MDAPI.h
//  Distribution
//
//  Created by Lsr on 4/8/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MKNetworkKit.h>
#import "MDUtil.h"
#import "MDUser.h"

#define API_USER_CREATE       @"users/create"
#define API_USER_CHECKNUMBER  @"users/check_number"
#define API_USER_NEWPROFILE   @"users/new_profile"
#define API_USER_UPDATEPROFILE @"users/update_profile"
#define API_USER_LOGIN        @"users/login"
#define API_USER_UPDATE_PHONE @"users/request_phone_number_change"
#define API_PACKAGE_RESIGER   @"packages/user/register"
#define API_PACKAGE_ORDER     @"packages/user/order"
#define API_GET_MY_PACKAGE    @"packages/user/get_my_packages"
#define API_EDIT_MY_PACKAGE   @"packages/user/edit_my_package"

#define USER_DEVICE           @"ios"


#define API_HOST_NAME @"modelordistribution-dev.elasticbeanstalk.com"

@interface MDAPI : NSObject

+(MDAPI *)sharedAPI;

-(void) createUserWithPhone:(NSString *)phone
                 onComplete:(void (^)(MKNetworkOperation *))complete
                    onError:(void (^)(MKNetworkOperation *, NSError *))error;

-(void) checkUserWithPhone:(NSString *)phone
                  withCode:(NSString *)code
                onComplete:(void (^)(MKNetworkOperation *))complete
                   onError:(void (^)(MKNetworkOperation *, NSError *))error;

-(void) newProfileByUser:(MDUser *)user
              onComplete:(void (^)(MKNetworkOperation *))complete
                 onError:(void (^)(MKNetworkOperation *, NSError *))error;

-(void) updateProfileByUser:(MDUser *)user
               sendPassword:(BOOL) sendPassword
                 onComplete:(void (^)(MKNetworkOperation *))complete
                    onError:(void (^)(MKNetworkOperation *, NSError *))error;


-(void) loginWithPhone:(NSString *)phoneNumber
              password:(NSString *)password
              onComplete:(void (^)(MKNetworkOperation *))complete
                 onError:(void (^)(MKNetworkOperation *, NSError *))error;

-(void) registerBaggageWithHash:(NSString *)hash
                     OnComplete:(void (^)(MKNetworkOperation *))complete
                          onError:(void (^)(MKNetworkOperation *, NSError *))error;

-(void) orderWithHash:(NSString *)hash
                  packageId:(NSString *)package_id
                  imageData:(NSData *)image_data
                 OnComplete:(void (^)(MKNetworkOperation *))complete
                    onError:(void (^)(MKNetworkOperation *, NSError *))error;
-(void) updatePhoneNumberWithOldPhoneNumber:(NSString *)oldPhoneNumber
                             newPhoneNumber:(NSString *)newPhoneNumber
                              OnComplete:(void (^)(MKNetworkOperation *))complete
                                 onError:(void (^)(MKNetworkOperation *, NSError *))error;

-(void) getMyPackageWithHash:(NSString *)hash
                  OnComplete:(void (^)(MKNetworkOperation *))complete
                     onError:(void (^)(MKNetworkOperation *, NSError *))error;

-(void) editMyPackageWithHash:(NSString *)hash
                      Package:(NSDictionary *)package
                   OnComplete:(void (^)(MKNetworkOperation *))complete
                      onError:(void (^)(MKNetworkOperation *, NSError *))error;


@end
