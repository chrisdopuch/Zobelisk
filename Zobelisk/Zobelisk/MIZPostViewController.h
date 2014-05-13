//
//  MIZPostViewController.h
//  Zobelisk
//
//  Created by Victor Tran on 4/30/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MIZAddPostViewController.h"
#import "MIZCommentsViewController.h"
#import "MIZPostFetch.h"
#import "MIZPost.h"


@interface MIZPostViewController : UIViewController <MIZAddPostViewControllerDelegate>

@property (nonatomic, strong) MIZPost *post;

@property (nonatomic, weak) IBOutlet UILabel *email;
@property (nonatomic, weak) IBOutlet UILabel *date;
@property (nonatomic, weak) IBOutlet UILabel *postTitle;
@property (nonatomic, weak) IBOutlet UILabel *body;
@property (nonatomic, strong) NSDictionary* postObj;
- (IBAction)pocket:(UIButton *)sender;
- (IBAction)commentOnPost:(id)sender;


@end
