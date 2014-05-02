//
//  MIZRegisterViewController.m
//  Zobelisk
//
//  Created by Clifford Green on 4/29/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZRegisterViewController.h"

@interface MIZRegisterViewController ()

@end

@implementation MIZRegisterViewController

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
    
     UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
        tapGesture.cancelsTouchesInView = NO;
    
        [self.scrollView addGestureRecognizer:tapGesture];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self deregisterFromKeyboardNotifications];
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -35.0f;  //set the -35.0f to your required value
        self.view.frame = f;
    }];
}


-(void)hideKeyboard
{
    [self.phoneTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
    [self.twitterHandleTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    CGPoint buttonOrigin = self.signUpButton.frame.origin;
    
    
    
    //frames size
    CGRect visibleRect = self.scrollView.frame;
    
    
    //visible views size minus keyboard size.
        
        visibleRect.size.height -= keyboardSize.height;
        
        
        if (!CGRectContainsPoint(visibleRect, buttonOrigin)){
            
            
            [self.scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, keyboardSize.height, 0.0f)];
            
        }
        
    
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  
    
   
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

//Sign up button pressed
- (IBAction)signUp:(UIButton *)sender {
    //adds new entries into registration object
    [self.registrationObject addEntriesFromDictionary:@{@"address":self.addressTextField.text,@"twitterHandle":self.twitterHandleTextField.text, @"phone":self.phoneTextField.text}];
    
    [self dismissViewControllerAnimated:YES completion:^
     {
         
     }];
}
@end
