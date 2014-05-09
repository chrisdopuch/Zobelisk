//
//  MIZFeedTableViewController.h
//  Zobelisk
//
//  Created by Clifford Green on 3/26/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIZAddPostViewController.h"
#import "MIZPostFetch.h"
#import "MIZInfoViewController.h"
#import "MIZPostFeedCellTableViewCell.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>


@interface MIZFeedTableViewController: UITableViewController <MIZAddPostViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *search;

@property (nonatomic, strong) NSArray *post;


@end
