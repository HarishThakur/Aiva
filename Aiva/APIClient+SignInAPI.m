//
//  APIClient+SignInAPI.m
//  Stipend
//
//  Created by Naveen Katari on 04/12/15.
//  Copyright (c) 2015 Sourcebits. All rights reserved.
//

#import "APIClient+SignInAPI.h"
//#import "EmailAddressCell.h"


@implementation APIClient (SignInAPI)

- (void)loginWithUserDetails:(NSDictionary *)parameters WithCompletionHandler:(void (^)(NSDictionary *, NSURLResponse *, NSError *))completionHandler {
    
    [self POST:@"SignInByEmail" withParameters:parameters withCompletionHandler:completionHandler];
}
@end
