//
//  ListTableViewCell.h
//  WeatherApp
//
//  Created by Teodora on 7/29/16.
//  Copyright © 2016 Teodora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@interface ListTableViewCell : UITableViewCell
@property (strong, nonatomic) City *city;
@property (weak, nonatomic) IBOutlet UILabel *cityName;
@end
