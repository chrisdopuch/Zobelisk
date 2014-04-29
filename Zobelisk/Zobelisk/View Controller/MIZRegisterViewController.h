//
//  MIZRegisterViewController.h
//  Zobelisk
//
//  Created by Clifford Green on 4/28/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIZRegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirth;
@property (weak, nonatomic) IBOutlet UITextField *addressText;
@property (weak, nonatomic) IBOutlet UITextField *twitterHandleText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)signUp:(UIButton *)sender;

@end
