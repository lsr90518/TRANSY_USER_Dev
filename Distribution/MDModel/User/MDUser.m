//
//  MDUser.m
//  Distribution
//
//  Created by Lsr on 4/12/15.
//  Copyright (c) 2015 Lsr. All rights reserved.
//

#import "MDUser.h"
#import "MDConsignor.h"

@implementation MDUser

+(MDUser *)getInstance {
    
    static MDUser *sharedInstance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[MDUser alloc] init];
    });
    return sharedInstance;
}

-(void) initDataClear {
    if(_phoneNumber.length < 1){
       _phoneNumber = @"";
    }
    if(_tmp_phoneNumber.length < 1){
        _tmp_phoneNumber = @"";
    }
    if([_mailAddress isEqual:[NSNull null]] || _mailAddress.length < 1){
        _mailAddress = @"";
    }
    if(_password.length < 1){
        _password = @"";
    }
    if(_checknumber.length < 1){
        _checknumber = @"";
    }
    if(_lastname.length < 1){
        _lastname = @"";
    }
    if(_firstname.length < 1){
        _firstname = @"";
    }
}

-(void) clearData{
    _user_id = 0;
    _password = @"";
    _phoneNumber = @"";
    _mailAddress = @"";
    _checknumber = @"";
    _lastname = @"";
    _firstname = @"";
    _loginStatus = @"";
    _credit = 0;
    _userHash = @"";
}

-(void) initDataWithConsignor:(MDConsignor *)consignor{
    _user_id = [consignor.userid integerValue];
    _password = consignor.password;
    _phoneNumber = consignor.phonenumber;
    
}

-(void) setLogin {
    self.loginStatus = @"YES";
}

-(void) setLogout {
    self.loginStatus = @"NO";
}

-(BOOL) isLogin {
    return ([self.loginStatus isEqualToString:@"YES"]) ? YES : NO;
}

-(void) copyDataFromUser:(MDUser *)newUser{
    _phoneNumber = newUser.phoneNumber;
    _mailAddress = newUser.mailAddress;
    _password = newUser.password;
    _lastname = newUser.lastname;
    _firstname = newUser.firstname;
    _checknumber = newUser.checknumber;
    _userHash = newUser.userHash;
    _loginStatus = newUser.loginStatus;
}

@end
