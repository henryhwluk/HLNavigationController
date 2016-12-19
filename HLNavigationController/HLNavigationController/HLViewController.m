//
//  HLViewController.m
//  HLNavigationController
//
//  Created by henvy on 19/12/2016.
//  Copyright © 2016 henvy. All rights reserved.
//

#import "HLViewController.h"
#import "HLNavigationController.h"
#import "UIViewController+HLNavigationExtension.h"
@interface HLViewController ()

@end

@implementation HLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Title";
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor blueColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(didTapNextButton)];
    
    self.hl_fullScreenPopGestureEnabled = NO; //关闭当前控制器的全屏返回手势
   
}
- (void)didTapNextButton
{
    HLViewController *viewController = [[HLViewController alloc] init];
//    testViewController *viewController = [[testViewController alloc] init];
    
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
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
