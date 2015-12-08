//
//  APIClient_SignIn.m
//  Aiva
//
//  Created by Harish Singh on 08/12/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import "APIClient_SignIn.h"

@implementation APIClient_SignIn



-(id) init {
    self = [super init];
    if (self) {
        self.userInformation = [AIVAUserInformation sharedDetails];
    }
    return self;
}

-(void) sendSignInDataToServer : (NSString *) method{
    @try {
        NSMutableDictionary *signInParameters = [[NSMutableDictionary alloc]init];
        [signInParameters setObject:self.userInformation.emailAddress forKey:@"Email"];
        [signInParameters setObject:self.userInformation.password forKey:@"Password"];
        
        NSURL *url=[NSURL URLWithString:URL];
        NSData *postData = [NSJSONSerialization dataWithJSONObject:signInParameters options:0 error:nil];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setDefaultHeader];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setHTTPBody:postData];
        
        
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        if( connection ) {
            mutableData = [NSMutableData new];
        } else {
            [self showAlertMessage:@"" :NO_CONNECTION];
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        NSLog(@"Login Failed!");
    }
}

/**
 *  Delegate method to check whether NSURLConnection recieve response
 */
-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response
{
    [mutableData setLength:0];
    
    if ([response respondsToSelector:@selector(statusCode)])
    {
        long statusCode = [((NSHTTPURLResponse *)response) statusCode];
        if (statusCode == 202)
        {
            [self showAlertMessage:@"Signed In Successfully" :@""];
        }
        else if (statusCode == 401){
            [self showAlertMessage:@"Authentication failure!!!" :@"Please pass valid Authentication details."];
        }
        else if (statusCode == 403)
        {
            [self showAlertMessage:@"Forbidden Status" :@"Incorrect Email ID or Password"];
        }
        else if (statusCode == 500)
        {
            [self showAlertMessage:@"Error 500" :@"Internal Server Error"];
        }
    }
}

/**
 *  Delegate method to check whether NSURLConnection recieve data
 */
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mutableData appendData:data];
}

/**
 *  Delegate method to check whether NSURLConnection fail to recieve data
 */
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"error description %@",error.description);
    [self showAlertMessage:@"" :NO_CONNECTION];
    return;
}

/**
 *  Delegate method to check NSURLConnection finish loading
 */
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSDictionary *loginDetails = [NSJSONSerialization JSONObjectWithData:mutableData options:0 error:nil];
    NSLog(@"Response from Server : %@", loginDetails);
}

/**
 *  Method to show alert message
 *
 *  @param alertTitle   is Title for alert view
 *  @param alertMessage is message for alert view
 */
-(void)showAlertMessage : (NSString *)alertTitle : (NSString *)alertMessage {
    UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert1 show];
    [self performSelector:@selector(dismiss:) withObject:alert1 afterDelay:3.0];
}

/**
 *  Method to dismiss Alert view
 */
-(void)dismiss:(UIAlertView*)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}


@end
