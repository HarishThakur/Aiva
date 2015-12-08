//
//  ViewController.h
//  Aiva
//
//  Created by Harish Singh on 24/11/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityIndicatorView.h"

@interface AIVALoginScreenViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *aivaLogo;
- (IBAction)signInWithFacebook:(id)sender;


@end

