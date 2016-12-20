//
//  HLContainerController.m
//  HLNavigationController
//
//  Created by henvy on 20/12/2016.
//  Copyright © 2016 henvy. All rights reserved.
//

#import "HLContainerController.h"
#import "HLTableViewController.h"
#import "UIViewController+HLNavigationExtension.h"

#pragma mark - HLContainerController
@interface HLContainerController ()
@property (nonatomic, strong) NSMutableArray *controllerArray;
@property (nonatomic, strong) NSMutableArray *animationArray;
@end

@implementation HLContainerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.controllerArray = [[NSMutableArray alloc] init];
    self.animationArray = [[NSMutableArray alloc] init];

//    self.controllerDelegate = self;
    
    _vc = [[UIViewController alloc]init];
    //_vc.controllerDelegate = self;
    [self addChildViewController:_vc];
    [self.view addSubview:_vc.view];
}
//    HLContainerController *co = [[HLContainerController alloc]initWithViewController:self withDelegate:self.controllerDelegate];


- (void)viewController:(UIViewController *)controller willGotoNextController:(UIViewController *)nextController withAnimation:(HLAnimationType)animation
{
    [self addChildViewController:nextController];
    
    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseIn;
    void (^animationBlock)(void) = nil;
    CGRect contentFrame = [UIScreen mainScreen].bounds;
    switch (animation) {
        case HLAnimationTypeNone: {
            nextController.view.frame = CGRectMake(0, 0, contentFrame.size.width, contentFrame.size.height);
            break;
        }
        case HLAnimationTypeHorTranToLeft: {
            nextController.view.frame = CGRectMake(contentFrame.size.width, 0, contentFrame.size.width, contentFrame.size.height);
            animationBlock = ^(void) {
                controller.view.frame = CGRectMake(-contentFrame.size.width, 0, contentFrame.size.width, contentFrame.size.height);
                nextController.view.frame = CGRectMake(0, 0, contentFrame.size.width, contentFrame.size.height);
            };
            break;
        }
        case HLAnimationTypeVerTranToUp: {
            nextController.view.frame = CGRectMake(0, contentFrame.size.height, contentFrame.size.width, contentFrame.size.height);
            animationBlock = ^(void) {
                nextController.view.frame = CGRectMake(0, 0, contentFrame.size.width, contentFrame.size.height);
            };
        }
            break;
        case HLAnimationTypeCrossDissolve: {
            options = UIViewAnimationOptionTransitionCrossDissolve;
            nextController.view.frame = CGRectMake(0, 0, contentFrame.size.width, contentFrame.size.height);
            break;
        }
        default:
            break;
    }
    [self transitionFromViewController:controller toViewController:nextController duration:0.2 options:options animations:animationBlock completion:^(BOOL isFinished) {
        if (isFinished) {
            [self.controllerArray addObject:nextController];
            [self.animationArray addObject:[NSNumber numberWithInteger:animation]];
        }
    }];
}

@end
