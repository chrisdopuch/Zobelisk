//
//  MIZMapViewController.m
//  Zobelisk
//
//  Created by Clifford Green on 4/8/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZMapViewController.h"

@interface MIZMapViewController ()

@end

@implementation MIZMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
<<<<<<< HEAD

- (void)viewDidLoad {
=======
- (void)MIZAddPostViewControllerDidCancel:(MIZAddPostViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad
{
>>>>>>> SignUp
    [super viewDidLoad];
    _mapView.showsUserLocation = YES;
    _mapView.mapType = MKMapTypeHybrid;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
}

- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = aUserLocation.coordinate.latitude;
    location.longitude = aUserLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [aMapView setRegion:region animated:YES];
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
