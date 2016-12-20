//
//  UIViewController+HLNavigationExtension.h
//  HLNavigationController
//
//  Created by henvy on 19/12/2016.
//  Copyright © 2016 henvy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLNavigationController.h"
#import "HLControllerDelegate.h"

@interface UIViewController (HLNavigationExtension)

@property (nonatomic, assign) BOOL hl_fullScreenPopGestureEnabled;

@property (nonatomic, weak) HLNavigationController *hl_navigationController;

//@property (nonatomic, assign) id<HLControllerDelegate> controllerDelegate;

@end
