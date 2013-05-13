//
//  AppDotNetService.h
//  AppDotNetFeed
//
//  Created by markw on 5/10/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDotNetServiceDelegate.h"
#import "JSONResponseParser.h"

@interface AppDotNetService : NSObject

- (id)initWithJSONParser:(JSONResponseParser *)parser;

@property (weak, nonatomic) id<AppDotNetServiceDelegate> delegate;

- (void)queryForUpdatedFeed;

@end
