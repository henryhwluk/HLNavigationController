//
//  HLNavigationController.m
//  HLNavigationController
//
//  Created by henvy on 19/12/2016.
//  Copyright © 2016 henvy. All rights reserved.
//

#import "HLNavigationController.h"
#import "UIViewController+HLNavigationExtension.h"
#define kDefaultBackImageName @"backImage"

#pragma mark - HLWrapNavigationController

@interface HLWrapNavigationController : UINavigationController

@end

@implementation HLWrapNavigationController

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    return [self.navigationController popToRootViewControllerAnimated:animated];
}
- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    HLNavigationController *hl_navigationController = viewController.hl_navigationController;
    NSInteger index = [hl_navigationController.hl_viewControllers indexOfObject:viewController];
    return [self.navigationController popToViewController:hl_navigationController.viewControllers[index] animated:animated];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hl_navigationController = (HLNavigationController *)self.navigationController;
    viewController.hl_fullScreenPopGestureEnabled = viewController.hl_navigationController.fullScreenPopGestureEnabled;
    
    UIImage *backButtonImage = viewController.hl_navigationController.backButtonImage;
    
    if (!backButtonImage) {
        backButtonImage = [UIImage imageNamed:kDefaultBackImageName];
    }
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton)];
    
    [self.navigationController pushViewController:[HLWrapViewController wrapViewControllerWithViewController:viewController] animated:animated];
}
- (void)didTapBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.hl_navigationController = nil;
}
@end

static NSValue *hl_tabBarRectValue;

#pragma mark - HLWrapViewController
@implementation HLWrapViewController
+ (HLWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController
{
    
    HLWrapNavigationController *wrapNavController = [[HLWrapNavigationController alloc] init];
    wrapNavController.viewControllers = @[viewController];
    
    HLWrapViewController *wrapViewController = [[HLWrapViewController alloc] init];
    [wrapViewController.view addSubview:wrapNavController.view];
    [wrapViewController addChildViewController:wrapNavController];
    
    return wrapViewController;
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (self.tabBarController && !hl_tabBarRectValue) {
        hl_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
    }
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = YES;
    if (self.tabBarController && !self.tabBarController.tabBar.hidden && hl_tabBarRectValue) {
        self.tabBarController.tabBar.frame = hl_tabBarRectValue.CGRectValue;
    }
}
- (BOOL)jt_fullScreenPopGestureEnabled
{
    return [self rootViewController].hl_fullScreenPopGestureEnabled;
}

- (BOOL)hidesBottomBarWhenPushed
{
    return [self rootViewController].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem
{
    
    return [self rootViewController].tabBarItem;
}

- (NSString *)title
{
    return [self rootViewController].title;
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return [self rootViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden
{
    return [self rootViewController];
}

- (UIViewController *)rootViewController
{
    HLWrapNavigationController *wrapNavController = self.childViewControllers.firstObject;
    return wrapNavController.viewControllers.firstObject;
}
@end

#pragma mark - HLNavigationController

@interface HLNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer *popPanGesture;

@property (nonatomic, strong) id popGestureDelegate;
@end

@implementation HLNavigationController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super init]) {
        rootViewController.hl_navigationController = self;
        self.viewControllers = @[[HLWrapViewController wrapViewControllerWithViewController:rootViewController]];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.viewControllers.firstObject.hl_navigationController = self;
        self.viewControllers = @[[HLWrapViewController wrapViewControllerWithViewController:self.viewControllers.firstObject]];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBarHidden:YES];
    self.delegate = self;
    
    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    self.popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.popGestureDelegate action:action];
    self.popPanGesture.maximumNumberOfTouches = 1;
}
#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    
    if (viewController.hl_fullScreenPopGestureEnabled) {
        if (isRootVC) {
            [self.view removeGestureRecognizer:self.popPanGesture];
        } else {
            [self.view addGestureRecognizer:self.popPanGesture];
        }
        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = !isRootVC;
    }
    
}
//修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}
- (NSArray *)hl_viewControllers
{
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (HLWrapViewController *wrapViewController in self.viewControllers) {
        [viewControllers addObject:wrapViewController.rootViewController];
    }
    return viewControllers.copy;
}
@end
