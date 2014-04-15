//
//  MIZCommentsViewController.h
//  Zobelisk
//
//  Created by Victor Tran on 4/15/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIZCommentsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *comment;

-(IBAction)postComment:(id)sender;

@end
