//
//  Rest_API.h
//  Aiva
//
//  Created by Harish Singh on 30/11/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInformation.h"
#import "NSMutableURLRequest+DefaultHeader.h"

@interface Rest_API : NSObject {
NSMutableData *mutableData;
    
#define URL            @"http://frontieredev.cloudapp.net/api/user/GetAccessTokenByEmail"
#define NO_CONNECTION  @"No Connection"
#define NO_VALUES      @"Please enter parameter values"
}

@property (retain,nonatomic) UserInformation *userInformation;
-(void) sendDataToServer : (NSString *) method;

@end
