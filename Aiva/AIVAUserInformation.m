//
//  UserInformation.m
//  Aiva
//
//  Created by Harish Singh on 26/11/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import "AIVAUserInformation.h"

@implementation AIVAUserInformation
@synthesize emailAddress,password,retypePassword,promoCode,isLoginSuccess;

/**
 *  Created singleton class for UserInformation
 *
 *  @return object of UserInformation class
 */
+ (AIVAUserInformation *)sharedDetails {
    static AIVAUserInformation *sharedMyDetails = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedMyDetails = [[AIVAUserInformation alloc] init];
    });
    return sharedMyDetails;
}

/**
 *  Method to initialize the string
 *
 *  @return self
 */
- (id)init {
    if (self = [super init]) {
        emailAddress = [[NSString alloc]init];
        password     = [[NSString alloc]init];
        retypePassword = [[NSString alloc]init];
        promoCode  = [[NSString alloc]init];
        isLoginSuccess = [[NSString alloc]init];
    }
    return self;
}



@end
