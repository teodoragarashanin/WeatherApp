//
//  City.h
//  WeatherApp
//
//  Created by Teodora on 7/29/16.
//  Copyright © 2016 Teodora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface City : NSObject 
@property (strong, nonatomic) NSString *name;
@property (nonatomic) double longitude;
@property (nonatomic) double latitude;
- (instancetype)initWithName:(NSString *)name andLongitude: (double) longitude andLatitude: (double) latitude;
@end