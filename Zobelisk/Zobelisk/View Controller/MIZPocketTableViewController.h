//
//  MIZPocketTableViewController.h
//  Zobelisk
//
//  Created by Clifford Green on 4/8/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIZAddPostViewController.h"
#import"MIZPostFetch.h"
#import "MIZPocketTableViewCell.h"


@interface MIZPocketTableViewController : UITableViewController <MIZAddPostViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *search;

@property (nonatomic, strong) NSArray *post;

@end
