//
//  APIClient_SignIn.h
//  Aiva
//
//  Created by Harish Singh on 08/12/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIVAUserInformation.h"
#import "NSMutableURLRequest+DefaultHeader.h"
#import "AIVAHomeScreenViewController.h"
#import "AIVAEmailSignInViewController.h"

@interface APIClient_SignIn : NSObject {
    NSMutableData *mutableData;
    #define URL            @"http://frontieredev.cloudapp.net/api/user/SignInByEmail"
    #define NO_CONNECTION  @"No Connection"
    #define NO_VALUES      @"Please enter parameter values"

}

@property (retain,nonatomic) AIVAUserInformation *userInformation;
-(void) sendSignInDataToServer : (NSString *) method;

@end
