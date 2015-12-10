//
//  APIClient+SignUpAPI.m
//  Stipend
//
//  Created by Naveen Katari on 03/12/15.
//  Copyright (c) 2015 Sourcebits. All rights reserved.
//

#import "APIClient+SignUpAPI.h"

@implementation APIClient (SignUpAPI)

-(void) signUpWithUserDetails:(NSDictionary *)parameters WithCompletionHandler:(void (^)(NSDictionary *, NSURLResponse *, NSError *))completionHandler
{
    [self POST:@"GetAccessTokenByEmail" withParameters:parameters withCompletionHandler:completionHandler];
}
@end
