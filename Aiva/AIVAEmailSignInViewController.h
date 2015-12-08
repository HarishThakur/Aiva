//
//  EmailSignInViewController.h
//  Aiva
//
//  Created by Harish Singh on 24/11/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AIVALoginScreenViewController.h"
#import "AIVAUserInformation.h"
#import "AIVAHomeScreenViewController.h"
#import "APIClient_SignIn.h"

@interface AIVAEmailSignInViewController : UIViewController {
    NSMutableData *mutableData;
#define URL            @"http://frontieredev.cloudapp.net/api/user/SignInByEmail"
#define NO_CONNECTION  @"No Connection"
#define NO_VALUES      @"Please enter parameter values"
    
}@property (weak, nonatomic) IBOutlet UIScrollView *emailSignInScrollView;
@property (weak, nonatomic) IBOutlet UITextField *enterEmailIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInThroughEmail;
@property AIVALoginScreenViewController *loginScreenViewController;
@property AIVAUserInformation *userInformation;
@property AIVAHomeScreenViewController *homeScreenViewController;
@property (weak, nonatomic) IBOutlet UILabel *validateLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeValidationButton;
- (IBAction)loginInWithEmail:(id)sender;
- (IBAction)forgotPasswordButton:(id)sender;
- (IBAction)signInWithFacebookButton:(id)sender;

@end
