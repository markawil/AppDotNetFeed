//
//  AppDelegateTests.m
//  AppDotNetFeed
//
//  Created by markw on 5/10/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import "AppDelegateTests.h"
#import "AppDelegate.h"
#import "NSUnit.h"
#import "AppDotNetServiceDelegate.h"
#import "AppDotNetService.h"

@implementation AppDelegateTests {
    
    AppDelegate *appDelegate;
}

- (void)setUp {
    
    [super setUp];
    appDelegate = [[AppDelegate alloc] init];
    [appDelegate application:nil didFinishLaunchingWithOptions:nil];
}

- (void)test_UINavBar_color_should_be_black {
    
    UIColor *barColor = [[UINavigationBar appearance] tintColor];
    [Assert that:barColor is:[Equal to:[UIColor blackColor]]];
}

- (void)test_window_rootViewController_should_be_the_NavController {
    
    [Assert that:appDelegate.window.rootViewController is:[Equal to:appDelegate.navController]];
}

- (void)test_navControllers_rootViewController_is_a_FeedViewController {
    
    id rootController = appDelegate.navController.topViewController;
    [Assert Class:[rootController class] isSameAs:[FeedViewController class]];
}

- (void)test_appDotNetService_delegate_should_be_feedViewController {
    
    id feedViewController = appDelegate.navController.topViewController;
    [Assert that:appDelegate.service.delegate is:[Equal to:feedViewController]];
}

- (void)tearDown {
    
    [super tearDown];
    appDelegate = nil;
}

@end
