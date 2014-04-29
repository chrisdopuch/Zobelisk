//
//  MIZPostTableViewController.m
//  Zobelisk
//
//  Created by Clifford Green on 4/8/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZPostTableViewController.h"

@interface MIZPostTableViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MIZPostTableViewController

#pragma mark - Actions

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addPost = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPostButtonTapped:)];
    
    self.navigationItem.rightBarButtonItem = addPost;
    
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Controls what view to segue based on identifier
    if([segue.identifier isEqualToString:@"addPost"])
    {
        //Sets navigation controller as destination
        UINavigationController *navigationController = segue.destinationViewController;
        //Goes to first view controller in navigation stack
        MIZAddPostViewController* AddPostViewController = [navigationController viewControllers][0];
        AddPostViewController.delegate = self;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
