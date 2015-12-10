//
//  APIClient+SignUpAPI.h
//  Stipend
//
//  Created by Naveen Katari on 03/12/15.
//  Copyright (c) 2015 Sourcebits. All rights reserved.
//

#import "APIClient.h"

@interface APIClient (SignUpAPI)

-(void)signUpWithUserDetails:(NSDictionary *)parameters WithCompletionHandler:(void(^)(NSDictionary *responseData, NSURLResponse *response, NSError *error))completionHandler;

@end
