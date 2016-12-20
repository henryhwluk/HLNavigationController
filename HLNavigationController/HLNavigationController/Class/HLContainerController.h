//
//  HLContainerController.h
//  HLNavigationController
//
//  Created by henvy on 20/12/2016.
//  Copyright © 2016 henvy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLControllerDelegate.h"

@interface HLContainerController : UIViewController<HLControllerDelegate>
@property (nonatomic, assign) id<HLControllerDelegate> controllerDelegate;
@property (nonatomic, strong) UIViewController *vc;

@end
