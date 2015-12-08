//
//  ViewController.m
//  Aiva
//
//  Created by Harish Singh on 24/11/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import "AIVALoginScreenViewController.h"

@interface AIVALoginScreenViewController ()

@end

@implementation AIVALoginScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signInWithFacebook:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"Pending..."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}



@end
