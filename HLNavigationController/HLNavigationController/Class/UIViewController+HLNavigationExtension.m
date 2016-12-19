//
//  UIViewController+HLNavigationExtension.m
//  HLNavigationController
//
//  Created by henvy on 19/12/2016.
//  Copyright © 2016 henvy. All rights reserved.
//

#import "UIViewController+HLNavigationExtension.h"
#import <objc/runtime.h>

@implementation UIViewController (HLNavigationExtension)

- (void)setHl_navigationController:(HLNavigationController *)hl_navigationController
{
    objc_setAssociatedObject(self, @selector(hl_navigationController), hl_navigationController, OBJC_ASSOCIATION_ASSIGN);

}
- (void)setHl_fullScreenPopGestureEnabled:(BOOL)hl_fullScreenPopGestureEnabled
{
    objc_setAssociatedObject(self, @selector(hl_fullScreenPopGestureEnabled), @(hl_fullScreenPopGestureEnabled), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)hl_fullScreenPopGestureEnabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (HLNavigationController *)hl_navigationController {
    return objc_getAssociatedObject(self, _cmd);
}

@end
