//
//  MIZSignUpViewController.h
//  Zobelisk
//
//  Created by Clifford Green on 4/8/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIZSignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboardAdjust;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
- (IBAction)passFieldDidChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)confPassFieldChange:(id)sender;
@end
