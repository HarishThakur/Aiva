//
//  Rest_API.m
//  Aiva
//
//  Created by Harish Singh on 30/11/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import "Rest_API_SignUp.h"
#import "ActivityIndicatorView.h"

@implementation Rest_API_SignUp

-(id) init {
    self = [super init];
    if (self) {
       self.userInformation = [AIVAUserInformation sharedDetails];
    }
    return self;
}

/**
 *  Method to post data to server
 *
 *  @param method will be either GET or POST as required
 */
-(void) sendSignUpDataToServer : (NSString *) method  {
    NSMutableDictionary *signUpParameters = [[NSMutableDictionary alloc]init];
    [signUpParameters setObject:self.userInformation.emailAddress forKey:@"Email"];
    [signUpParameters setObject:self.userInformation.password forKey:@"Password"];
    //[signUpParameters setObject:@"956874" forKey:@"ReferralCode"];
    
    if(self.userInformation.emailAddress.length > 0 && self.userInformation.password.length > 0) {
        
        [self showAlertMessage:@"" :@"Getting response from server..."];
        
        NSURL *url = nil;
        NSMutableURLRequest *request = nil;
        
        if([method isEqualToString:@"GET"]) {
            
        } else {  // POST
            url = [NSURL URLWithString: URL];
            request = [NSMutableURLRequest requestWithURL:url];
            [request setDefaultHeader];
            NSData *parameterData = [NSJSONSerialization dataWithJSONObject:signUpParameters options:0 error:nil];
            [request setHTTPBody:parameterData];
        }
        [request setHTTPMethod:method];
        
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        if( connection ) {
            mutableData = [NSMutableData new];
        } else {
            [self showAlertMessage:@"" :NO_CONNECTION];
        }
        
    } else {
        [self showAlertMessage:@"" :NO_VALUES];
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
            [self showAlertMessage:@"Signed Up Successfully" :@"Request accepted, and queued for execution"];
        }
        else if (statusCode == 403)
        {
            [self showAlertMessage:@"Forbidden Status" :@"This email-id is already registered. Please try with some other valid email-id"];
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
    NSString *responseStringWithEncoded = [[NSString alloc] initWithData: mutableData encoding:NSUTF8StringEncoding];
    //NSLog(@"Response from Server : %@", responseStringWithEncoded);
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[responseStringWithEncoded dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    NSLog(@"Response from Server : %@", attrStr);

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



//+(id) sharedAPIClient {
//    static Rest_API *sharedMyInstance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedMyInstance = [[self alloc] init];
//        sharedMyInstance = [sharedMyInstance initWithBaseUrl:[self baseUrl]];
//    });
//    return sharedMyInstance;
//}
//
//-(id)initWithBaseUrl: (NSURL *) baseUrl {
//    self = [super init];
//    return self;
//}
//
//+(NSURL *) baseUrl {
//    return [NSURL URLWithString:[NSString stringWithFormat:@"http://frontieredev.cloudapp.net/api/user"]];
//}
//
//
//#pragma mark API method to hit the server
//
//- (void)POST:(NSString *)apiName withParameters:(NSDictionary *)parameters withCompletionHandler:(void (^)(NSDictionary *, NSURLResponse *, NSError *))completionHandler {
//    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
//    NSString *urlString = [NSString stringWithFormat:@"%@/%@", BASEURL, apiName];
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL: url];
//
//    NSData *parametersData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
//    [urlRequest setHTTPBody:parametersData];
//    [urlRequest setHTTPMethod:@"POST"];
//    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    
//    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest :urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSDictionary *responseData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        completionHandler(responseData, response, error);
//    }];
//    
//    [dataTask resume];
//    
//}





@end
