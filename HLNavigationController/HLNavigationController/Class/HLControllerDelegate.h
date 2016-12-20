//
//  HLControllerDelegate.h
//  HLNavigationController
//
//  Created by henvy on 20/12/2016.
//  Copyright © 2016 henvy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HLAnimationType) {
    HLAnimationTypeNone          = 0,                // 无动画
    HLAnimationTypeHorTranToLeft = 1,                // 从右向左移动
    HLAnimationTypeVerTranToUp   = 2,                // 从下向上移动
    HLAnimationTypeCrossDissolve = 3,                // 淡化
};

@protocol HLControllerDelegate <NSObject>

@optional
- (void)viewController:(UIViewController *)controller willGotoNextController:(UIViewController *)nextController withAnimation:(HLAnimationType)animation;

- (void)viewController:(UIViewController *)controller willGoBackWithStep:(NSInteger)stepNo;

- (void)viewControllerWillLogout:(UIViewController *)controller;

// 跳转到某个ViewController，同时原来的ViewController消失
- (void)viewController:(UIViewController *)controller willJumpToController:(UIViewController *)nextController withAnimation:(HLAnimationType)animation;

// 显示ViewController
- (void)viewController:(UIViewController *)controller presentViewController:(UIViewController *)nextController animated:(BOOL)isAnimated completion:(void (^)(void))completion;

@end
