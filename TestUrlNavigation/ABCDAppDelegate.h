//
//  ABCDAppDelegate.h
//  TestUrlNavigation
//
//  Created by jitu keshri on 3/6/14.
//  Copyright (c) 2014 NowFloats. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ABCDViewController;

@interface ABCDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ABCDViewController *viewController;

extern NSString *const UrlVariable;

extern NSString *const UrlVar;

@end
