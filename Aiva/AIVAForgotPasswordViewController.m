//
//  ForgotPasswordViewController.m
//  Aiva
//
//  Created by Harish Singh on 24/11/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import "AIVAForgotPasswordViewController.h"

@interface AIVAForgotPasswordViewController ()

@end

@implementation AIVAForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.enterEmailTextField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[AIVAEmailSignInViewController class]] ) {
            [self.navigationController popToViewController:viewController animated:YES];
        }
    }
}


@end
