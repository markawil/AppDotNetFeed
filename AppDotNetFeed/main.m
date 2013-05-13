//
//  main.m
//  AppDotNetFeed
//
//  Created by markw on 5/9/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnitTestAppDelegate.h"
#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        BOOL inTests = (NSClassFromString(@"SenTestCase") != nil);
        
        int returnValue;
        
        if (inTests) {
            //use a special empty delegate when we are inside the tests
            returnValue = UIApplicationMain(argc, argv, nil, NSStringFromClass([UnitTestAppDelegate class]));
        }
        else {
            //use the normal delegate
            returnValue = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
        
        return returnValue;
    }
}
