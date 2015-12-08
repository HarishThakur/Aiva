//
//  HomeScreenViewController.m
//  Aiva
//
//  Created by Harish Singh on 03/12/15.
//  Copyright (c) 2015 Sourcebits Technologies. All rights reserved.
//

#import "AIVAHomeScreenViewController.h"
#define METERS_PER_MILE 1609.344

@interface AIVAHomeScreenViewController ()<UISearchBarDelegate, UISearchDisplayDelegate>
{
    NSMutableArray *matchingSearchResults;
    CLPlacemark *locationPlacemark;
    CLGeocoder *geoCoder;
    MKLocalSearch *localSearch;
    MKLocalSearchResponse *searchResponse;
    MKMapItem *item;
    __weak IBOutlet MKMapView *myMapView;
}

@end

@implementation AIVAHomeScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    myMapView.showsUserLocation = YES;
//    myMapView.showsBuildings = YES;
//    
//    _locationManager = [CLLocationManager new];
//    if([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        [_locationManager requestAlwaysAuthorization];
//    }
//    [_locationManager startUpdatingLocation];
    
    self.searchBar.delegate = self;
    geoCoder = [[CLGeocoder alloc]init];
    if (_locationManager == nil)
    {
        _locationManager = [[CLLocationManager alloc]init];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        [[self locationManager] setDelegate:self];
        
    }
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startUpdatingLocation];
    [[self mapView] setShowsUserLocation:YES];
    
    
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    if( authorizationStatus == kCLAuthorizationStatusAuthorizedAlways )
    {
        [_locationManager startUpdatingLocation];
        [[self mapView] setShowsUserLocation:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void) mapView: (MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:userLocation.coordinate fromEyeCoordinate:CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.latitude) eyeAltitude:10000];
    [mapView setCamera:camera animated:YES];
}

#pragma mark - CLLocationManager Delegate methods
-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(error == nil && [placemarks count] > 0)
         {
             locationPlacemark = [placemarks lastObject];
         }
         else
         {
             NSLog(@"%@", error.debugDescription);
         }
     }];
    CLLocationCoordinate2D zoomLocation;
    zoomLocation=location.coordinate;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    [self.mapView setRegion:viewRegion animated:YES];
    [manager stopUpdatingLocation];
    
}
#pragma CLLocationManager didFailWithError delegate method

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Unable to find the location");
    NSLog(@"error %@",error.description);
}

#pragma Searchbar delegate methods
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [localSearch cancel];
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc]init];
    searchRequest.naturalLanguageQuery = self.searchBar.text;
    searchRequest.region = self.mapView.region;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    localSearch = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
     {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
         if (response.mapItems.count == 0 )
         {
             NSLog(@"No Matches Found");
         }
         else
             for (item in response.mapItems)
             {
                 NSLog(@"name == %@", item.name);
                 NSLog(@"Phone == %@", item.phoneNumber);
                 NSLog(@"Address == %@", item.placemark);
                 MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
                 annotation.coordinate = item.placemark.coordinate;
                 annotation.title = item.name;
                 annotation.subtitle = item.placemark.title;
                 [self.mapView addAnnotation:annotation];
             }
         searchResponse = response;
         locationPlacemark = item.placemark;
     }];
}



@end
