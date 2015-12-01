//
//  ForgotPasswordViewController.h
//  Aiva
//
//  Created by Harish Singh on 24/11/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmailSignInViewController.h";

@interface ForgotPasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *facebookLoginWebView;
@property EmailSignInViewController *emailSignInViewController;
@property (weak, nonatomic) IBOutlet UITextField *enterEmailTextField;

@end
