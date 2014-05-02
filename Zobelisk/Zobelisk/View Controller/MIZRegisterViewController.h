//
//  MIZRegisterViewController.h
//  Zobelisk
//
//  Created by Clifford Green on 4/29/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIZAuthentication.h"

@interface MIZRegisterViewController : UIViewController
@property (strong, nonatomic) NSMutableDictionary* registrationObject;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *twitterHandleTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

- (IBAction)signUp:(UIButton *)sender;

@end
