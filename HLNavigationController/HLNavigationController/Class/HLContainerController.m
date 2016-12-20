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
    
    HLTableViewController *ta = [[HLTableViewController alloc]init];
    ta.controllerDelegate = self;
    [self addChildViewController:ta];
    [self.view addSubview:ta.view];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


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

- (void)viewController:(UIViewController *)controller willGoBackWithStep:(NSInteger)stepNo {
    NSInteger preIndex = [self.controllerArray count] - 1 - stepNo;
    if (preIndex < 0) {
        NSLog(@"超出ViewController列表大小");
        return;
    }
    UIViewController *preController = [self.controllerArray objectAtIndex:preIndex];
    // 这里获取的动画类型是进入当前界面的动画类型，所以要加1，否则得到的是进入要返回的那个界面时所使用的动画类型
    HLAnimationType preAnimation = [[self.animationArray objectAtIndex:(preIndex + 1)] integerValue];
    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseIn;
    void (^animationBlock)(void) = nil;
    CGRect contentFrame = [UIScreen mainScreen].bounds;
    
    switch (preAnimation) {
        case HLAnimationTypeNone: {
            preController.view.frame = CGRectMake(0, 0, contentFrame.size.width, contentFrame.size.height);
            break;
        }
        case HLAnimationTypeHorTranToLeft: {
            preController.view.frame = CGRectMake(-contentFrame.size.width, 0, contentFrame.size.width, contentFrame.size.height);
            animationBlock = ^(void) {
                controller.view.frame = CGRectMake(contentFrame.size.width, 0, contentFrame.size.width, contentFrame.size.height);
                preController.view.frame = CGRectMake(0, 0, contentFrame.size.width, contentFrame.size.height);
            };
            break;
        }
        case HLAnimationTypeVerTranToUp: {
            //            animationBlock = ^(void) {
            //                controller.view.frame = CGRectMake(0, contentFrame.size.height, contentFrame.size.width, contentFrame.size.height);
            //            };
            options = UIViewAnimationOptionTransitionCrossDissolve;
            preController.view.frame = CGRectMake(0, 0, contentFrame.size.width, contentFrame.size.height);
            break;
        }
        case HLAnimationTypeCrossDissolve: {
            options = UIViewAnimationOptionTransitionCrossDissolve;
            preController.view.frame = CGRectMake(0, 0, contentFrame.size.width, contentFrame.size.height);
            break;
        }
        default:
            break;
    }
    
    [self transitionFromViewController:controller toViewController:preController duration:0.2 options:options animations:animationBlock completion:^(BOOL isFinished) {
        if (isFinished) {
            for (NSInteger i = [self.controllerArray count] - 1; i > preIndex; --i) {
                UIViewController *vc = [self.controllerArray objectAtIndex:i];
                [vc removeFromParentViewController];
                [self.controllerArray removeObjectAtIndex:i];
                [self.animationArray removeObjectAtIndex:i];
            }
        }
    }];
}

- (void)viewController:(UIViewController *)controller willJumpToController:(UIViewController *)nextController withAnimation:(HLAnimationType)animation {
    NSInteger index = [self.controllerArray count] - 1;
    for (; index >= 0; --index) {
        if ([self.controllerArray objectAtIndex:index] == controller) {
            break;
        }
    }
    
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
            animationBlock = ^(void){
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
            break;
        }
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
            // 跳转结束，先删除所有跳转后被隐藏的界面
            for (NSInteger i = [self.controllerArray count] - 1; i >= index; --i) {
                UIViewController *vc = [self.controllerArray objectAtIndex:i];
                [vc removeFromParentViewController];
                [self.controllerArray removeObjectAtIndex:i];
                [self.animationArray removeObjectAtIndex:i];
            }
            
            // 添加跳转后的新界面
            [self.controllerArray addObject:nextController];
            [self.animationArray addObject:[NSNumber numberWithInteger:animation]];
        }
    }];
}

- (void)viewControllerWillLogout:(UIViewController *)controller {
    UIViewController *preController = [self.controllerArray objectAtIndex:0];
    if (preController == controller) {
        NSLog(@"已经是第一个界面了");
        return;
    }
    [self transitionFromViewController:controller toViewController:preController duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL isFinished) {
        if (isFinished) {
            
            for (NSInteger i = [self.controllerArray count] - 1; i > 0; --i) {
                UIViewController *vc = [self.controllerArray objectAtIndex:i];
                [vc removeFromParentViewController];
                [self.controllerArray removeObjectAtIndex:i];
                [self.animationArray removeObjectAtIndex:i];
            }
        }
    }];
}

- (void)viewController:(UIViewController *)controller presentViewController:(UIViewController *)nextController animated:(BOOL)isAnimated completion:(void (^)(void))completion {
    [self presentViewController:nextController animated:isAnimated completion:completion];
}

@end
