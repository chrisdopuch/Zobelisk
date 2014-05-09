//
//  MIZPocketTableViewController.m
//  Zobelisk
//
//  Created by Clifford Green on 4/8/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZPocketTableViewController.h"
#import "MIZAuthentication.h"
#import "MIZPostViewController.h"

@interface MIZPocketTableViewController () <UISearchBarDelegate>

@property (nonatomic, strong)UIGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) MIZPost *selectedPost;
@end


@implementation MIZPocketTableViewController

static NSString *cellIdentifier = @"Cell";

- (void)refresh
{
    // Get data
    [self.refreshControl beginRefreshing];
    [self.tableView setContentOffset:CGPointMake(0.0f, -60.0f)];
    [MIZPostFetch fetchPost];
}

#pragma mark - Notification handling

- (void)respondToProcessingComplete:(NSNotification *)notification
{
    NSLog(@"PROCESSING COMPLETE");
    NSDictionary *userInfo = notification.userInfo;
    self.post = userInfo[@"post"];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }];
    
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
     
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addPost = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPostButtonTapped:)];
    
    self.navigationItem.rightBarButtonItem = addPost;
        self.search.delegate = self;
    
    // Register the view controller to listen for notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(respondToProcessingComplete:) name:@"MIZPostFinishedProcessing" object:nil];
    
    // Tell the refresh control to stop
    [[NSNotificationCenter defaultCenter] addObserverForName:@"MIZPostFetchingFailed" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [self.refreshControl endRefreshing];
    }];
    // Pull to refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    // Unarchive saved episodes
    NSString* path = [NSSearchPathForDirectoriesInDomains(
                                                          NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"favorite.miz"];
    self.post = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    [self.tableView reloadData];
    
    [self refresh];


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MIZPocketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    MIZPost *post = self.post[indexPath.row];
    
    cell.email.text = post.email;
    cell.date.text = post.date;
    cell.postTitle.text = post.postTitle;
    cell.body.text = post.content;
    
    cell.body.numberOfLines = 0;
    
    return cell;
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
}

//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
//{
//    [self dismissKeyboard:self];
//}

- (void)dismissKeyboard:(id)sender
{
    [self.search resignFirstResponder];
    [self.view removeGestureRecognizer:self.tapGestureRecognizer];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    // Do the search...
}

- (void)addPostButtonTapped:(id)sender{
    [self performSegueWithIdentifier:@"addPost" sender:sender];
}

- (void)MIZAddPostViewControllerDidCancel:(MIZAddPostViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.post.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Posts"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedPost = self.post[self.post.count - indexPath.row-1];
    [self performSegueWithIdentifier:@"FeedToPost" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MIZPost *post = self.post[self.post.count - indexPath.row-1];
    MIZPocketTableViewCell *cell = (MIZPocketTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    CGSize labelSize = CGSizeZero;
    CGRect boundingRect = [post.content boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[cell.body.attributedText attributesAtIndex:0 effectiveRange:NULL] context:nil];
    labelSize = boundingRect.size;
    
    return boundingRect.size.height+120.0f;
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
    if([segue.identifier isEqualToString:@"FeedToPost"])
    {
        MIZPostViewController *select = segue.destinationViewController;
        select.post = self.selectedPost;
    }
    
}


@end
