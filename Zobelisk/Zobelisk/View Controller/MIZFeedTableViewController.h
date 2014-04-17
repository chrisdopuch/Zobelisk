//
//  MIZFeedTableViewController.h
//  Zobelisk
//
//  Created by Clifford Green on 3/26/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIZAddPostViewController.h"

@interface MIZFeedTableViewController: UITableViewController <MIZAddPostViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *search;

@end
