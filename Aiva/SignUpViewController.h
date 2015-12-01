//
//  SignUpViewController.h
//  Aiva
//
//  Created by Harish Singh on 24/11/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookSignInViewController.h"
#import "UserInformation.h"
#import "Rest_API.h"

@interface SignUpViewController : UIViewController <NSURLConnectionDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *signUpScrollView;
@property (weak, nonatomic) IBOutlet UITextField *emailAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *retypePasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *promoCodeTextField;
@property (weak, nonatomic) IBOutlet UILabel *validateLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeValidationButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButtonClicked;

@property UserInformation *userInformation;

- (IBAction)signUpButtonClicked:(id)sender;
- (IBAction)signUpWithFacebook:(id)sender;

@end
