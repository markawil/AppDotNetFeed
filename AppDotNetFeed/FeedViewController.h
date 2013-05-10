//
//  FeedViewController.h
//  AppDotNetFeed
//
//  Created by markw on 5/10/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDotNetService.h"
#import "AppDotNetServiceDelegate.h"

@interface FeedViewController : UITableViewController <AppDotNetServiceDelegate>

- (id)initWithAppDotNetService:(AppDotNetService *)service;

@end
