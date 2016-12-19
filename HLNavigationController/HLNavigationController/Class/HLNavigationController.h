//
//  HLNavigationController.h
//  HLNavigationController
//
//  Created by henvy on 19/12/2016.
//  Copyright © 2016 henvy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (HLWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end

@interface HLNavigationController : UINavigationController

@property (nonatomic, strong) UIImage *backButtonImage;

@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;

@property (nonatomic, copy, readonly) NSArray *hl_viewControllers;

@end
