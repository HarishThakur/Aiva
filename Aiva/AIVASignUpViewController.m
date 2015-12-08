//
//  SignUpViewController.m
//  Aiva
//
//  Created by Harish Singh on 24/11/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import "AIVASignUpViewController.h"
#import "NSMutableURLRequest+DefaultHeader.h"

@interface AIVASignUpViewController ()<UITextFieldDelegate> {
    
NSMutableData *mutableData;
#define URL            @"http://frontieredev.cloudapp.net/api/user/GetAccessTokenByEmail"
#define NO_CONNECTION  @"No Connection"
#define NO_VALUES      @"Please enter parameter values"
}
@property (nonatomic,retain) NSString *deviceId;
@end

@implementation AIVASignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _userInformation = [AIVAUserInformation sharedDetails];
    
    [self hideValidationLabel];
    
    // set delegate for moving next UITextField from Keyboard Next button
    [_signUpScrollView setScrollEnabled:YES];
    [_signUpScrollView setContentSize:CGSizeMake(375, 1000)];
    self.emailAddressTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.emailAddressTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.emailAddressTextField.delegate = self;
    self.passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.passwordTextField.delegate = self;
    self.retypePasswordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.retypePasswordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.retypePasswordTextField.delegate = self;
    self.promoCodeTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.promoCodeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.promoCodeTextField.delegate = self;
    
    // setting placeHolder color
    [self.emailAddressTextField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.retypePasswordTextField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.promoCodeTextField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    
}

#pragma mark - Hide validation Label
-(void)hideValidationLabel {
    [self.validateLabel setHidden:YES];
    [self.closeValidationButton setHidden:YES];
}

#pragma mark - Show validation Label
-(void)showValidationLabel {
    [self.validateLabel setHidden:NO];
    [self.closeValidationButton setHidden:NO];
}

#pragma mark - Validate Email
- (BOOL)validateEmail:(NSString *)emailStr
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Sign up Button Click
- (IBAction)signUpButtonClicked:(id)sender {
    self.validateLabel.text = @"Please enter the required fields";
    
    self.userInformation.emailAddress = self.emailAddressTextField.text;
    self.userInformation.password = self.passwordTextField.text;
    self.userInformation.retypePassword = self.retypePasswordTextField.text;
    
    if ([self.userInformation.emailAddress isEqualToString:@""] || [self.userInformation.password isEqualToString:@""] || [self.userInformation.retypePassword isEqualToString:@""]) {
        [self showValidationLabel];
        [self.promoCodeTextField resignFirstResponder];
    }
    else {
        if (![self validateEmail:self.userInformation.emailAddress])
        {
            self.validateLabel.text = @"Please enter valid email id";
            [self showValidationLabel];
        }
        else if (![self.userInformation.password isEqualToString:self.userInformation.retypePassword]) {
            self.validateLabel.text = @"Password didn't matched";
            [self showValidationLabel];
        }
        else {
            [self hideValidationLabel];
            [[[APIClient_SignUp alloc] init] sendSignUpDataToServer:@"POST"];
        }
    }
}

#pragma mark - Move Next UITextField
-(BOOL)textFieldShouldReturn:(UITextField *)textField    {
    if (textField == self.emailAddressTextField) {
        [self.passwordTextField becomeFirstResponder];
    }
    else if (textField == self.passwordTextField) {
        [self.retypePasswordTextField becomeFirstResponder];
    }
    else if (textField == self.retypePasswordTextField) {
        [self.promoCodeTextField becomeFirstResponder];
    }
    else if (textField == self.promoCodeTextField) {
        [self.promoCodeTextField becomeFirstResponder];
        
        self.userInformation.emailAddress = self.emailAddressTextField.text;
        self.userInformation.password = self.passwordTextField.text;
        self.userInformation.retypePassword = self.retypePasswordTextField.text;

        if ([self.userInformation.emailAddress isEqualToString:@""] || [self.userInformation.password isEqualToString:@""] || [self.userInformation.retypePassword isEqualToString:@""]) {

            [self showValidationLabel];
            [self.promoCodeTextField resignFirstResponder];
        }
        
    }
    return YES;
}

#pragma mark - close validation Label from button click
- (IBAction)closeValidationButton:(id)sender {
    [self hideValidationLabel];
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)signUpWithFacebook:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"Pending..."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
