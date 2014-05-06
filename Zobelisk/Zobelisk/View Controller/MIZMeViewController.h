//
//  MIZMeViewController.h
//  Zobelisk
//
//  Created by Clifford Green on 4/1/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIZAddPostViewController.h"
#import"MIZPostFetch.h"

@interface MIZMeViewController : UIViewController <MIZAddPostViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *firstName;
@property (nonatomic, weak) IBOutlet UILabel *lastName;
@property (nonatomic, weak) IBOutlet UILabel *email;
@property (nonatomic, weak) IBOutlet UILabel *phone;
@property (nonatomic, weak) IBOutlet UILabel *twitter;

@property (nonatomic, strong) NSArray *users;

@end
