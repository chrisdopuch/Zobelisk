//
//  MIZMapViewController.h
//  Zobelisk
//
//  Created by Clifford Green on 4/8/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "MIZAddPostViewController.h"

@interface MIZMapViewController : UIViewController <MKMapViewDelegate> //<MIZAddPostViewControllerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocation *initialLocation;


@end
