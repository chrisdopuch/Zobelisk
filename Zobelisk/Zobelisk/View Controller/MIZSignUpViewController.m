//
//  MIZSignUpViewController.m
//  Zobelisk
//
//  Created by Clifford Green on 4/8/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZSignUpViewController.h"
//#import "MIZAuthentication.h"

@interface MIZSignUpViewController ()
@property (weak, nonatomic) IBOutlet UIButton *passCheck;

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
    self.passwordField.secureTextEntry = YES;
    self.confirmPassword.secureTextEntry = YES;
    self.passwordField.placeholder = @"8 character min";
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self deregisterFromKeyboardNotifications];
    
    [super viewWillDisappear:animated];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    
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


- (void)registerForKeyboardNotifications{
    
    //Register notifications to identify when keyboard appears
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    //Adds observer to notify when keyboard will hide notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}


- (void)deregisterFromKeyboardNotifications {
    
    //Notifies when keyboard is dismissed from view removing the observer
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)keyboardWasShown:(NSNotification *)notification {
    
    
    NSDictionary* info = [notification userInfo];
    
    //Finds keyboard size based on phone
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    //Origin of text box
    CGPoint buttonOrigin = self.passCheck.frame.origin;
    
    
    
    //frames size
    CGRect visibleRect = self.scrollView.frame;
    
    
    //visible views size minus keyboard size.
    if([self.confirmPassword isEditing] || [self.passwordField isEditing]){
        
        visibleRect.size.height -= keyboardSize.height;
    
    
    if (!CGRectContainsPoint(visibleRect, buttonOrigin)){
        
        
        [self.scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, keyboardSize.height, 0.0f)];
        
    }
    
        
    }
    
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






- (IBAction)passFieldDidChange:(id)sender {
    
    //Checks length of initial password
    if(self.passwordField.text.length > 8)
    {
        self.confirmPassword.enabled = true;
    }
    
}

- (IBAction)confPassFieldChange:(id)sender {
    //Compares the two passwords if true enables the next button
    if([self.passwordField.text isEqualToString:self.confirmPassword.text])
    {
        self.passCheck.enabled = true;
    }
}
 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue destinationViewController];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
