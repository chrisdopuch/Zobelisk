//
//  MIZMapViewController.h
//  Zobelisk
//
//  Created by Clifford Green on 4/8/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

<<<<<<< HEAD
#import <MapKit/MapKit.h>

@interface MIZMapViewController : UIViewController
<MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocation* initialLocation;

=======
#import <UIKit/UIKit.h>
#import "MIZAddPostViewController.h"

@interface MIZMapViewController : UIViewController <MIZAddPostViewControllerDelegate>
>>>>>>> SignUp

@end
