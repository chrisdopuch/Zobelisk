//
//  MIZFeedTableViewController.m
//  Zobelisk
//
//  Created by Clifford Green on 3/26/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZFeedTableViewController.h"
#import "MIZAuthentication.h"
#import "MIZPostViewController.h"


@interface MIZFeedTableViewController () <UISearchBarDelegate, CBPeripheralManagerDelegate>

@property (nonatomic, strong)UIGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) MIZPost *selectedPost;

@property (strong, nonatomic) CLBeaconRegion *beaconRegionOne;
@property (strong, nonatomic) CLBeaconRegion *beaconRegionTwo;
@property (strong, nonatomic) CLBeaconRegion *beaconRegionThree;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;

@end



@implementation MIZFeedTableViewController

static NSString *cellIdentifier = @"Cell";

- (void)refresh
{
    // Get data
    [self.refreshControl beginRefreshing];
    [self.tableView setContentOffset:CGPointMake(0.0f, -60.0f)];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.tableView reloadData];
    }];
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
        self.range = NO;
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
    
    MIZAuthentication *authenticator = [MIZAuthentication new];
    BOOL isLoggedIn = [authenticator verifyLogin];
    if (isLoggedIn == NO){
        [self performSegueWithIdentifier:@"SignUpSegue" sender:self];
    }
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self initRegion];
    
    UIBarButtonItem *addPost = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPostButtonTapped:)];
    UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self action:@selector(infoButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *infoBarButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    
    self.navigationItem.leftBarButtonItem = infoBarButton;
    self.navigationItem.rightBarButtonItem = addPost;
     self.search.delegate = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
    path = [path stringByAppendingPathComponent:@"post.miz"];
    self.post = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    [self.tableView reloadData];
    self.range = NO;
    [self initRegion];

    [self refresh];
}

    //iBeacon Set up
- (void)initRegion
{
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    self.beaconRegionOne =[[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"beacon"];
     self.beaconRegionTwo =[[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"beacon"];
     self.beaconRegionThree =[[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:@"beacon"];

    
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegionOne];
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegionTwo];
   [self.locationManager startRangingBeaconsInRegion:self.beaconRegionThree];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
        localNotification.alertBody = @"You are in range of a Zobelisk!";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    

}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    
    CLBeacon *beacon = [beacons lastObject];
    NSArray *beaconMinors = @[@(19829), @(47986), @(44032)];

    if (beacon.proximity == CLProximityImmediate && self.range == NO){
        if([beaconMinors containsObject:beacon.minor]) {
            [MIZPostFetch fetchPostforBeacon:beacon.minor];
            self.range = YES;
        }
    }
    else if (beacon.proximity == CLProximityImmediate && self.range == NO){
        if([beaconMinors containsObject:beacon.minor]) {
            [MIZPostFetch fetchPostforBeacon:beacon.minor];
            self.range = YES;
        }
    }
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


- (void)MIZAddPostViewControllerDidCancel:(MIZAddPostViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+ (UIFont *)customCellFont {
    return [UIFont systemFontOfSize:17];
}

#pragma mark - TableView Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    MIZPostFeedCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    MIZPost *post = self.post[self.post.count - indexPath.row-1];
    
    cell.email.text = post.email;
    cell.date.text = post.date;
    cell.postTitle.text = post.postTitle;
    cell.body.text = post.content;
    
    cell.body.numberOfLines = 0;

    return cell;
}


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
    MIZPostFeedCellTableViewCell *cell = (MIZPostFeedCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];

    CGSize labelSize = CGSizeZero;
    CGRect boundingRect = [post.content boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:[cell.body.attributedText attributesAtIndex:0 effectiveRange:NULL] context:nil];
    labelSize = boundingRect.size;
    
    return boundingRect.size.height+120.0f;
}

#pragma mark - Table view data source

- (void)addPostButtonTapped:(id)sender{
    [self performSegueWithIdentifier:@"addPost" sender:sender];
}
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
- (IBAction)pocket:(UIButton *)sender {
    
    UITableViewCell *buttonCell = (UITableViewCell *) [sender superview];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:buttonCell];
    MIZPost *favortiedPost = self.post[self.post.count - indexPath.row-1];
    [favortiedPost favoritePost:favortiedPost.postID];
}


#pragma mark - Navigation

 //In a storyboard-based application, you will often want to do a little preparation before navigation
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
    else if([segue.identifier isEqualToString:@"FeedToPost"])
    {
        MIZPostViewController *select = segue.destinationViewController;
        select.post = self.selectedPost;
    }

}

@end
