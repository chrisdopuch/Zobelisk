//
//  MIZRegisterViewController.m
//  Zobelisk
//
//  Created by Clifford Green on 4/28/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZRegisterViewController.h"

@interface MIZRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

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
    
    //Origin of button
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signUp:(UIButton *)sender {
}
@end
