//
//  NSObject+CategoryProperty.m
//  HLNavigationController
//
//  Created by henvy on 22/12/2016.
//  Copyright © 2016 henvy. All rights reserved.
//

#import "NSObject+CategoryProperty.h"
#import <objc/runtime.h>

@implementation NSObject (CategoryProperty)

- (NSObject *)property {
    return objc_getAssociatedObject(self, @selector(property));
}

- (void)setProperty:(NSObject *)value {
    objc_setAssociatedObject(self, @selector(property), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
