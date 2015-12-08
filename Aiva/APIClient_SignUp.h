//
//  APIClient_SignUp.h
//  Aiva
//
//  Created by Harish Singh on 08/12/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIVAUserInformation.h"
#import "NSMutableURLRequest+DefaultHeader.h"

@interface APIClient_SignUp : NSObject {
    NSMutableData *mutableData;
#define URL            @"http://frontieredev.cloudapp.net/api/user/GetAccessTokenByEmail"
#define NO_CONNECTION  @"No Connection"
#define NO_VALUES      @"Please enter parameter values"
}

@property (retain,nonatomic) AIVAUserInformation *userInformation;
-(void) sendSignUpDataToServer : (NSString *) method;

@end
