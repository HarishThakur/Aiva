//
//  EmailSignInViewController.m
//  Aiva
//
//  Created by Harish Singh on 24/11/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import "EmailSignInViewController.h"

@interface EmailSignInViewController() <UITextFieldDelegate>

@end

@implementation EmailSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userInformation = [UserInformation sharedDetails];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
    self.userInformation.emailAddress = self.enterEmailIDTextField.text;
    self.userInformation.password = self.enterPasswordTextField.text;
    
    if ([self.userInformation.emailAddress isEqualToString:@""] || [self.userInformation.password isEqualToString:@""]) {
        [self showValidationLabel];
        [self.enterPasswordTextField resignFirstResponder];
    } else if (![self validateEmail:self.userInformation.emailAddress])
    {
         self.validateLabel.text = @"Please enter valid email id...";
         [self showValidationLabel];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Logged In Successfully!!!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
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
