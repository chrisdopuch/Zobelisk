//
//  MIZSignUpViewController.m
//  Zobelisk
//
//  Created by Clifford Green on 4/8/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZSignUpViewController.h"
#import "MIZAuthentication.h"

@interface MIZSignUpViewController ()

@end

@implementation MIZSignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.passwordField isFirstResponder] && [touch view] != self.passwordField) {
        [self.passwordField resignFirstResponder];
    }
    else if  ([self.firstName isFirstResponder] && [touch view] != self.firstName) {
        [self.firstName resignFirstResponder];
    }
    else if  ([self.lastName isFirstResponder] && [touch view] != self.lastName) {
        [self.lastName resignFirstResponder];
    }
    else if ([self.email isFirstResponder] && [touch view]!= self.email)
    {
        [self.email resignFirstResponder];
    }
    else if  ([self.confirmPassword isFirstResponder] && [touch view] != self.confirmPassword) {
        [self.confirmPassword resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)nextButton:(id)sender {
}

- (IBAction)passFieldDidChange:(id)sender {
    
    if(_passwordField.text.length > 8)
    {
        self.signUpButton.enabled = true;
    }
    
    
}

- (IBAction)signUpButtonClick:(id)sender{
    [MIZAuthentication registerEmail:@"email" withPassword:@"passwordField" andConfirmationPassword:@"confirmPassword"];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
