//
//  DataManager.h
//  WeatherApp
//
//  Created by Teodora on 7/30/16.
//  Copyright © 2016 Teodora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "City.h"

@interface DataManager : NSObject
@property (strong, nonatomic) NSMutableArray *itemsArray;
+ (DataManager *)sharedInstance;
@end
