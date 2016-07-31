//
//  AddViewController.h
//  WeatherApp
//
//  Created by Teodora on 7/29/16.
//  Copyright © 2016 Teodora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "City.h"

@interface AddViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *cityNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (strong, nonatomic) City *city;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@end