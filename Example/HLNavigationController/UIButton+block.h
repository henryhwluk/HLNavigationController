//
//  UIButton+block.h
//  HLNavigationController
//
//  Created by henvy on 22/12/2016.
//  Copyright © 2016 henvy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^btnBlock)();

@interface UIButton (block)

- (void)handelWithBlock:(btnBlock)block;

@end
