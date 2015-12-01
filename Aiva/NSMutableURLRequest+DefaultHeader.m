//
//  NSMutableURLRequest+DefaultHeader.m
//  Aiva
//
//  Created by Harish Singh on 27/11/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import "NSMutableURLRequest+DefaultHeader.h"

@implementation NSMutableURLRequest (DefaultHeader)

/**
 *  Category to extend the property of NSMutableURLRequest to add headers
 */
-(void)setDefaultHeader
{
    NSString *deviceID = [[[UIDevice currentDevice]identifierForVendor] UUIDString];
    [self addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self addValue:deviceID forHTTPHeaderField:@"DeviceID"];
    [self addValue:@"1" forHTTPHeaderField:@"DeviceType"];
    
}


@end
