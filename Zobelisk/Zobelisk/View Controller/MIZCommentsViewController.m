//
//  MIZCommentsViewController.m
//  Zobelisk
//
//  Created by Victor Tran on 4/15/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZCommentsViewController.h"

@interface MIZCommentsViewController ()

@end

@implementation MIZCommentsViewController

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
    self.comment.layer.borderColor = [[UIColor grayColor] CGColor];
    self.comment.layer.borderWidth = 1.0;
    self.comment.layer.cornerRadius = 8;
    
    _comment.delegate = self;
    _comment.text = @"Post comment here...";
    _comment.textColor = [UIColor lightGrayColor];
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([_comment isFirstResponder] && [touch view] != _comment) {
        [_comment resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Post comment here..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Post comment here...";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

- (void) postComment:(id)sender {
  //INSERT COMMENT POSTING CODE HERE!!!
    
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

@end
