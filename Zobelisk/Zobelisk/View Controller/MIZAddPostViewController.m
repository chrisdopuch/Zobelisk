//
//  MIZAddPostViewController.m
//  Zobelisk
//
//  Created by Clifford Green on 4/8/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZAddPostViewController.h"

@interface MIZAddPostViewController () <UITextViewDelegate>
@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (strong, nonatomic) CLBeaconRegion *beaconRegionOne;
@property (strong, nonatomic) CLBeaconRegion *beaconRegionTwo;
@property (strong, nonatomic) CLBeaconRegion *beaconRegionThree;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSDictionary *beaconPeripheralData;
@property (strong, nonatomic) CBPeripheralManager *peripheralManager;



@end


NSDateFormatter *dateFormatter;

NSDate *selectedDate;

@implementation MIZAddPostViewController

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
    self.description.layer.borderColor = [[UIColor grayColor] CGColor];
    self.description.layer.borderWidth = 1.0;
    self.description.layer.cornerRadius = 8;
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.datePicker setDate:[NSDate dateWithTimeIntervalSinceNow:0] animated:true ];

    [self.expDate setInputView:self.datePicker];
    
    [self.datePicker addTarget:self action:@selector(updateLabelFromPicker) forControlEvents:UIControlEventValueChanged];

    self.description.delegate = self;
    self.description.text = @"Breifly describe your post...";
    self.description.textColor = [UIColor lightGrayColor];
    
    
    dateFormatter = [[NSDateFormatter alloc] init];
    
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker setHidden:NO];
    [self.datePicker setDate:[NSDate date]];
    [self.datePicker setMinimumDate: [NSDate date]]; //no.4
   // [self.datePicker addTarget:self action:@selector(selectedDate) forControlEvents:UIControlEventValueChanged]; //no.2
    //scale image
    self.selectedImageView.contentMode = UIViewContentModeScaleAspectFit;
    
     [self initRegion];
}

- (IBAction)createPost:(UIButton *)sender {
    //Request beacon ID and email from user defaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //NSNumber* userID = [userDefaults objectForKey:@"userID"];
    NSString* email = [userDefaults objectForKey:@"email"];
    NSNumber* beaconID = [userDefaults objectForKey:@"beaconID"];
    
    //Create post dictionary object
    NSDictionary* postInfo = [[NSDictionary alloc] initWithObjectsAndKeys:self.postTitle.text, @"title",self.description.text, @"description", self.expDate.text, @"expiration_date", self.selectedImageView, @"image", email, @"email", [userDefaults objectForKey:@"userID"], @"user_id", nil];
    [MIZPost createPost:postInfo onBeacon:beaconID];
    [userDefaults removeObjectForKey:@"beaconID"];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
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
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString* email = [[NSString alloc] init];
            
            email = [userDefaults objectForKey:@"email"];
            
            NSDictionary* postInfo = [[NSDictionary alloc] initWithObjectsAndKeys:self.postTitle.text, @"title",self.description.text, @"description", self.expDate.text, @"expiration_date", self.selectedImageView, @"image", email, @"email", nil];
            [MIZPost createPost:postInfo onBeacon:beacon.minor];
            self.range = YES;
        }
    }
    else if (beacon.proximity == CLProximityNear && self.range == NO){
        if([beaconMinors containsObject:beacon.minor]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString* email = [[NSString alloc] init];
            
            email = [userDefaults objectForKey:@"email"];
            
            NSDictionary* postInfo = [[NSDictionary alloc] initWithObjectsAndKeys:self.postTitle.text, @"title",self.description.text, @"description", self.expDate.text, @"expiration_date", self.selectedImageView, @"image", email, @"email", nil];
            [MIZPost createPost:postInfo onBeacon:beacon.minor];
            self.range = YES;

        }
    }
    else if (beacon.proximity == CLProximityFar&& self.range == NO){
        if([beaconMinors containsObject:beacon.minor]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString* email = [[NSString alloc] init];
            
            email = [userDefaults objectForKey:@"email"];
            
            NSDictionary* postInfo = [[NSDictionary alloc] initWithObjectsAndKeys:self.postTitle.text, @"title",self.description.text, @"description", self.expDate.text, @"expiration_date", self.selectedImageView, @"image", email, @"email", nil];
            [MIZPost createPost:postInfo onBeacon:beacon.minor];
            self.range = YES;

        }
    }
    else if (beacon.proximity == CLProximityUnknown && self.range == NO){
        if([beaconMinors containsObject:beacon.minor]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString* email = [[NSString alloc] init];
            
            email = [userDefaults objectForKey:@"email"];
            
            NSDictionary* postInfo = [[NSDictionary alloc] initWithObjectsAndKeys:self.postTitle.text, @"title",self.description.text, @"description", self.expDate.text, @"expiration_date", self.selectedImageView, @"image", email, @"email", nil];
            [MIZPost createPost:postInfo onBeacon:beacon.minor];
            self.range = YES;

        }
    }
}



-(void)updateLabelFromPicker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"EEEE MMMM dd, yyyy"];
    NSString *expirationDate = [formatter stringFromDate:self.datePicker.date];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.expDate.text = expirationDate;
    }];
}
    
- (void)textViewDidBeginEditing:(UITextView *)textView
{

    if ([textView.text isEqualToString:@"Breifly describe your post..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Breifly describe your post...";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.description isFirstResponder] && [touch view] != self.description) {
        [self.description resignFirstResponder];
    }
    else if  ([self.expDate isFirstResponder] && [touch view] != self.expDate) {
        [self.expDate resignFirstResponder];
    }
    else if  ([self.postTitle isFirstResponder] && [touch view] != self.postTitle) {
        [self.postTitle resignFirstResponder];
    }
    else if ([self.datePicker isSelected] && [touch view]!= self.datePicker)
    {
        [self.datePicker resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}



-  (IBAction) choosePhotoBtn:(id)sender {
    UIActionSheet *media = [[UIActionSheet alloc] initWithTitle:@"Choose photo from:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Gallery", nil];
    
    [media showInView:self.view];

    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            self.picker = [[UIImagePickerController alloc] init];
            self.picker.delegate = self;
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.picker animated:YES completion:nil];
            
            break;
        case 1:
            self.picker = [[UIImagePickerController alloc] init];
            self.picker.delegate = self;
            self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.picker animated:YES completion:nil];
            
            break;
    } 
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.selectedImageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender
{
    //Cancel button delegate method
    [self.delegate MIZAddPostViewControllerDidCancel:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //navigates back to last view controller
    [self.navigationController popToRootViewControllerAnimated:true];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
