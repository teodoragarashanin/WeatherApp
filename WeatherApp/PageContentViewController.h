//
//  PageContentViewController.h
//  WeatherApp
//
//  Created by Teodora on 7/30/16.
//  Copyright © 2016 Teodora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"
#import "City.h"

@interface PageContentViewController : UIViewController
@property (nonatomic) NSUInteger pageIndex;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, weak) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) City *city;
@end
