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
@property (weak, nonatomic) IBOutlet UILabel *firstName;
@property (weak, nonatomic) IBOutlet UILabel *lastName;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;


@property (nonatomic, strong) NSArray *users;

@end
