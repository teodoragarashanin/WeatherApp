//
//  ListViewController.m
//  WeatherApp
//
//  Created by Teodora on 7/29/16.
//  Copyright © 2016 Teodora. All rights reserved.
//

#import "ListViewController.h"
#import "AddViewController.h"
#import "Constants.h"
#import "PageContentViewController.h"
#import "City.h"
#import "Constants.h"
#import <CoreLocation/CoreLocation.h>


@interface ListViewController () <UITableViewDelegate, UITableViewDataSource, UIPageViewControllerDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *array;
@end

@implementation ListViewController

#pragma mark - Properties

- (NSMutableArray *)loadCustomObjectWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    NSMutableArray *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

- (void)saveCustomObject:(NSMutableArray *)object key:(NSString *)key {
    
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
    
}

#pragma mark - Actions

- (IBAction)addCityButtonTapped:(UIButton *)sender {
    
    AddViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"AddViewController"];
   [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - View Lifecycle

-(void) viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *array= [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:LIST_OF_CITIES]];
    NSLog(@"%lu", (unsigned long)array.count);
    return [array count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *array= [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:LIST_OF_CITIES]];
        City *city = [array objectAtIndex: indexPath.row];
        cell.cityName.text = city.name;
        return cell;
}

#pragma mark - UITableViewDelegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self createPageViewController:indexPath.row];
    [self setupPageControl];
     NSLog(@"%lu", indexPath.row);
    [self viewControllerAtIndex:indexPath.row];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *array= [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:LIST_OF_CITIES]];
        NSMutableArray *newArray = [NSMutableArray arrayWithArray:array];
        [newArray removeObjectAtIndex:indexPath.row];
        [self saveCustomObject:newArray key:LIST_OF_CITIES];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - UIPageViewController

- (void)createPageViewController: (NSInteger) index {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.array= [NSKeyedUnarchiver unarchiveObjectWithData:[defaults objectForKey:LIST_OF_CITIES]];
    UIPageViewController *pageController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    pageController.dataSource = self;
  
    if([self.array count]) {
        
        NSArray *startingViewControllers = @[[self viewControllerAtIndex:index]];
        [pageController setViewControllers:startingViewControllers
                                 direction:UIPageViewControllerNavigationDirectionForward
                                  animated:NO
                                completion:nil];
    }
    
    self.pageViewController = pageController;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)pageIndex {
   
    if (pageIndex < [self.array count]) {
        
        PageContentViewController *pageContentController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
        pageContentController.pageIndex = pageIndex;
        pageContentController.city = self.array[pageIndex];
        return pageContentController;
    }
    return nil;
}

- (void)setupPageControl {
    [[UIPageControl appearance] setPageIndicatorTintColor:[UIColor grayColor]];
    [[UIPageControl appearance] setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
    [[UIPageControl appearance] setBackgroundColor:[UIColor darkGrayColor]];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
      index++;
    
    if (index == [self.array count]) {
    return nil;
}
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {

    return [self.array count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
  
    return 0;
}

@end