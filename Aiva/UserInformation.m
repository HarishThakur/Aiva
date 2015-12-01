//
//  UserInformation.m
//  Aiva
//
//  Created by Harish Singh on 26/11/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import "UserInformation.h"

@implementation UserInformation
@synthesize emailAddress,password,retypePassword,promoCode;

/**
 *  Created singleton class for UserInformation
 *
 *  @return object of UserInformation class
 */
+ (UserInformation *)sharedDetails {
    static UserInformation *sharedMyDetails = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedMyDetails = [[UserInformation alloc] init];
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
    }
    return self;
}



@end
