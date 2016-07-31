//
//  ListViewController.h
//  WeatherApp
//
//  Created by Teodora on 7/29/16.
//  Copyright © 2016 Teodora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "ListTableViewCell.h"

@interface ListViewController : UIViewController
@property (strong, nonatomic) DataManager *dataManager;
@end