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
#import "UIColor+RandomColor.h"
@interface HLViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTabView;

@end

@implementation HLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Title";
    self.navigationController.navigationBar.barTintColor = [UIColor randomColor];
    self.view.backgroundColor = [UIColor randomColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(didTapNextButton)];
    
}

- (void)didTapNextButton
{
    HLViewController *viewController = [[HLViewController alloc] init];
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapPopButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didTapPopToButton:(id)sender {
    [self.navigationController popToViewController:self.hl_navigationController.hl_viewControllers[0] animated:YES];
}

- (IBAction)didTapPopToRootButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
