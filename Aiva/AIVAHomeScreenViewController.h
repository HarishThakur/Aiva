//
//  HomeScreenViewController.h
//  Aiva
//
//  Created by Harish Singh on 03/12/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKAnnotation.h>

@interface AIVAHomeScreenViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
