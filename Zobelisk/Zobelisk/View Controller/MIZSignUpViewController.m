//
//  MIZSignUpViewController.m
//  Zobelisk
//
//  Created by Clifford Green on 4/8/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZSignUpViewController.h"
#import "MIZAuthentication.h"
#import "UIView+FormScroll.h"

@interface MIZSignUpViewController ()
@property (weak, nonatomic) IBOutlet UIButton *passCheck;
@property (weak, nonatomic) NSObject* registerBlock;
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
    
       UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    self.passwordField.secureTextEntry = YES;
    self.confirmPassword.secureTextEntry = YES;
    self.passwordField.placeholder = @"8 character min";
    
    // prevents the scroll view from swallowing up the touch event of child buttons
    tapGesture.cancelsTouchesInView = NO;
    
    [self.scrollView addGestureRecognizer:tapGesture];
    
    //Set text field defaults
    self.firstName.text = @"";
    self.lastName.text = @"";
    self.email.text = @"";
    
    
  
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -35.0f;  //set the -35.0f to your required value
        self.view.frame = f;
    }];
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
    [self.firstName resignFirstResponder];
    [self.lastName resignFirstResponder];
    [self.email resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.confirmPassword resignFirstResponder];
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
    if(self.passwordField.text.length >= 8)
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
    //create mutable dictionary to store information from signup view controller
    NSMutableDictionary *registerObject = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.firstName.text, @"first name", self.lastName.text, @"last name", self.passwordField.text, @"password", self.email.text, @"email", nil];
    
    //Performs segue based on the identifier
    if([segue.identifier isEqualToString:@"signUpToRegister"])
    {
        //Segue to Register controller
        MIZRegisterViewController* controller = (MIZRegisterViewController*)segue.destinationViewController;
        //pass the registration object into Registration view controller.
        controller.registrationObject = registerObject;
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
