//
//  UserInformation.h
//  Aiva
//
//  Created by Harish Singh on 26/11/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIVAUserInformation : NSObject {
//    NSString *emailAddress;
//    NSString *password;
//    NSString *retypePassword;
//    NSString *promoCode;
}

@property (retain,nonatomic) NSString *emailAddress,*password,*retypePassword,*promoCode;

+ (AIVAUserInformation *)sharedDetails;

@end
