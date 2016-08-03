//
//  City.m
//  WeatherApp
//
//  Created by Teodora on 7/29/16.
//  Copyright © 2016 Teodora. All rights reserved.
//

#import "City.h"


@implementation City

#pragma mark - Designated Initializer

- (instancetype)initWithName:(NSString *)name andLongitude: (double) longitude andLatitude: (double) latitude {
    if (self = [super init]) {
        self.name = name;
        self.latitude = latitude;
        self.longitude = longitude;
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeDouble:self.longitude forKey:@"longitude"];
    [encoder encodeDouble:self.latitude forKey:@"latitude"];
}

-(id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if ( self != nil ) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.latitude = [decoder decodeDoubleForKey:@"longitude"];
        self.latitude = [decoder decodeDoubleForKey:@"latitude"];
    }
    return self;
}

@end