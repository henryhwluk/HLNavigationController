//
//  UIButton+block.m
//  HLNavigationController
//
//  Created by henvy on 22/12/2016.
//  Copyright © 2016 henvy. All rights reserved.
//

#import "UIButton+block.h"
#import <objc/runtime.h>
static const char btnKey;

@implementation UIButton (block)
- (void)handelWithBlock:(btnBlock)block
{
    if (block)
    {
        objc_setAssociatedObject(self, &btnKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnAction
{
    btnBlock block = objc_getAssociatedObject(self, &btnKey);
    block();
}
@end
