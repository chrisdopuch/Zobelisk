//
//  MIZSignUpViewController.h
//  Zobelisk
//
//  Created by Clifford Green on 4/8/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIZSignUpViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)nextButton:(id)sender;

- (IBAction)passFieldDidChange:(id)sender;


@end
