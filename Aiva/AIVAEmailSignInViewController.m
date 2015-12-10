//
//  EmailSignInViewController.m
//  Aiva
//
//  Created by Harish Singh on 24/11/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import "AIVAEmailSignInViewController.h"
#import "NSMutableURLRequest+DefaultHeader.h"

@interface AIVAEmailSignInViewController() <UITextFieldDelegate>

@end

@implementation AIVAEmailSignInViewController

/**
 *  Initializing modal class, controller and setting delegate for text fields
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userInformation = [AIVAUserInformation sharedDetails];
    _homeScreenViewController = [[AIVAHomeScreenViewController alloc]init];
    [_emailSignInScrollView setScrollEnabled:YES];
    [_emailSignInScrollView setContentSize:CGSizeMake(375, 1000)];
    
    [self hideValidationLabel];
    
    self.enterEmailIDTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.enterEmailIDTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.enterEmailIDTextField.delegate = self;
    self.enterPasswordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.enterPasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.enterPasswordTextField.delegate = self;

    [self.enterEmailIDTextField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.enterPasswordTextField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Move Next UITextField
-(BOOL)textFieldShouldReturn:(UITextField *)textField    {
    if (textField == self.enterEmailIDTextField) {
        [self.enterPasswordTextField becomeFirstResponder];
    }
    else if (textField == self.enterPasswordTextField) {
        [self.enterPasswordTextField becomeFirstResponder];
        
        self.userInformation.emailAddress = self.enterEmailIDTextField.text;
        self.userInformation.password = self.enterPasswordTextField.text;
        
        if ([self.userInformation.emailAddress isEqualToString:@""] || [self.userInformation.password isEqualToString:@""]) {
            [self showValidationLabel];
            [self.enterPasswordTextField resignFirstResponder];
        }
    }
    return YES;
}

-(void)hideValidationLabel {
    [self.validateLabel setHidden:YES];
    [self.closeValidationButton setHidden:YES];
}

-(void)showValidationLabel {
    [self.validateLabel setHidden:NO];
    [self.closeValidationButton setHidden:NO];
}

- (BOOL)validateEmail:(NSString *)emailStr
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

- (IBAction)loginInWithEmail:(id)sender {
    self.validateLabel.text = @"Please enter the required fields";
    self.validateLabel.textAlignment = NSTextAlignmentCenter;
    self.userInformation.emailAddress = self.enterEmailIDTextField.text;
    self.userInformation.password = self.enterPasswordTextField.text;
    
    NSMutableDictionary *signInParameters = [[NSMutableDictionary alloc]init];
    [signInParameters setObject:self.userInformation.emailAddress forKey:@"Email"];
    [signInParameters setObject:self.userInformation.password forKey:@"Password"];

    
    if ([self.userInformation.emailAddress isEqualToString:@""] || [self.userInformation.password isEqualToString:@""]) {
        [self showValidationLabel];
        [self.enterPasswordTextField resignFirstResponder];
    }
    else if (![self validateEmail:self.userInformation.emailAddress]) {
         self.validateLabel.text = @"Please enter valid email id";
         self.validateLabel.textAlignment = NSTextAlignmentCenter;
         [self showValidationLabel];
    }
    else {
        [self getSigninResponseFromServer: @"POST" withParameters:signInParameters];
    }
}


-(void) getSigninResponseFromServer:(NSString *)method withParameters:(NSMutableDictionary *)parameters
{
    
    ActivityIndicatorView *activityView = [[NSBundle mainBundle] loadNibNamed:@"ActivityIndicatorView" owner:self options:nil][0];
    [self.view addSubview:activityView];
    activityView.center = self.view.center;
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [[APIClient sharedAPIClient] loginWithUserDetails:parameters WithCompletionHandler:^(NSDictionary *responseData, NSURLResponse *response, NSError *error) {
        if ( [responseData[@"User"][@"Email"] isEqualToString: self.userInformation.emailAddress] ) {
            AIVAHomeScreenViewController *homeScreenVC = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"HomeScreenViewController"];
            [self.navigationController pushViewController:homeScreenVC animated:YES];
            self.enterEmailIDTextField.text = @"";
            self.enterPasswordTextField.text = @"";
        }
        else if ([responseData[@"Status"] isEqualToString: @"InvalidEmailOrPassowrd"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:responseData[@"Message"]
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }

        NSLog(@"response data %@", responseData);
        [activityView setHidden:YES];
        [[UIApplication sharedApplication]endIgnoringInteractionEvents];
    }];
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



- (IBAction)forgotPasswordButton:(id)sender {
}

- (IBAction)signInWithFacebookButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"To be shown on next demo..."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
- (IBAction)closeValidationButton:(id)sender {
    [self hideValidationLabel];
}

@end
