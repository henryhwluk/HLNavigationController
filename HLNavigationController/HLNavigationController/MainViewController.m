//
//  MainViewController.m
//  HLNavigationController
//
//  Created by henvy on 19/12/2016.
//  Copyright © 2016 henvy. All rights reserved.
//

#import "MainViewController.h"
#import "HLNavigationController.h"
#import "UIViewController+HLNavigationExtension.h"
#import "HLViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HLViewController *firstVC = [[HLViewController alloc] init];
    UITabBarItem *firstItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
    firstVC.title = @"First";
    firstVC.tabBarItem = firstItem;
    HLNavigationController *firstNav = [[HLNavigationController alloc] initWithRootViewController:firstVC];
    firstNav.navigationBar.barTintColor = [UIColor blueColor];
    firstNav.fullScreenPopGestureEnabled = YES;
    
    HLViewController *secondVC = [[HLViewController alloc] init];
    UITabBarItem *secondItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:2];
    secondVC.title = @"Second";
    secondVC.tabBarItem = secondItem;
    HLNavigationController *secondNav = [[HLNavigationController alloc] initWithRootViewController:secondVC];
    secondNav.fullScreenPopGestureEnabled = NO;
    
    //    testViewController *te = [[testViewController alloc]init];
    
    self.viewControllers = @[firstNav,secondNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
