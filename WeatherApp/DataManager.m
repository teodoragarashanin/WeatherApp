//
//  DataManager.m
//  WeatherApp
//
//  Created by Teodora on 7/30/16.
//  Copyright © 2016 Teodora. All rights reserved.
//

#import "DataManager.h"
#import "Constants.h"

@implementation DataManager

#pragma mark - Properties


- (NSMutableArray *)itemsArray {
    
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
    }
    return _itemsArray;
}

#pragma mark - Public API

+ (DataManager *)sharedInstance {
    
    static DataManager *sharedManager;
    
    @synchronized(self)	{
        if (sharedManager == nil) {
            sharedManager = [[DataManager alloc] init];
        }
    }
    
    return sharedManager;
}

@end
