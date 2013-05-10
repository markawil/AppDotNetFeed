//
//  AppDelegate.h
//  AppDotNetFeed
//
//  Created by markw on 5/9/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedViewController.h"
#import "AppDotNetService.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) AppDotNetService *service;

@end
