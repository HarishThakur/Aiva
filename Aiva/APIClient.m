//
//  ServerAPI.m
//  Stipend
//
//  Created by Naveen Katari on 03/12/15.
//  Copyright (c) 2015 Sourcebits. All rights reserved.
//

#import "APIClient.h"


@implementation APIClient

#pragma mark Singleton Methods

#define kBaseUrl @"http://frontieredev.cloudapp.net/api/user"

+(id) sharedAPIClient
{
    static APIClient *sharedMyInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyInstance = [[self alloc] init];
    });
    return sharedMyInstance;
}

-(id)init
{
    self = [super init];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    return self;
}


#pragma mark - API POST method to send/recieve data to/from the server

- (void)POST:(NSString *)apiName withParameters:(NSDictionary *)parameters withCompletionHandler:(void (^)(NSDictionary *, NSURLResponse *, NSError *))completionHandler {
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", kBaseUrl, apiName];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL: url];
    [urlRequest setDefaultHeader];
    NSData *parametersData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    [urlRequest setHTTPBody:parametersData];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask * dataTask =[self.defaultSession dataTaskWithRequest :urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        completionHandler(responseData, response, error);
        
    }];
    [dataTask resume];
}

@end
