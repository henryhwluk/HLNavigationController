//
//  UIViewController+VCCategory.m
//  HLNavigationController
//
//  Created by henvy on 22/12/2016.
//  Copyright © 2016 henvy. All rights reserved.
//

#import "UIViewController+VCCategory.h"
#import <objc/runtime.h>

@implementation UIViewController (VCCategory)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL systemSel = @selector(viewWillAppear:);
        SEL henvySel = @selector(hl_viewWillAppear:);
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method henvyMethod = class_getInstanceMethod([self class], henvySel);
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(henvyMethod), method_getTypeEncoding(henvyMethod));
        if (isAdd) {
            class_replaceMethod(self, henvySel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        }else{
            //交换两个方法的实现
            method_exchangeImplementations(systemMethod, henvyMethod);
        }
    });
}
- (void)hl_viewWillAppear:(BOOL)animated{
    //这里自己调用自己，表面上循环引用其实已经被viewWillAppear替换掉了
    [self hl_viewWillAppear:animated];
    NSLog(@"henvy");
}
@end
