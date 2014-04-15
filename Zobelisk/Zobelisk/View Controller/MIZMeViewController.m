//
//  MIZMeViewController.m
//  Zobelisk
//
//  Created by Clifford Green on 4/1/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZMeViewController.h"

@interface MIZMeViewController ()

@end

@implementation MIZMeViewController

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
    
    UIBarButtonItem *addPost = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPostButtonTapped:)];
    self.navigationItem.rightBarButtonItem = addPost;
}

- (void)MIZAddPostViewControllerDidCancel:(MIZAddPostViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)addPostButtonTapped:(id)sender{
    [self performSegueWithIdentifier:@"addPost" sender:sender];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //[segue destinationViewController];
    if([segue.identifier isEqualToString:@"addPost"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        MIZAddPostViewController* AddPostViewController = [navigationController viewControllers][0];
        AddPostViewController.delegate = self;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
