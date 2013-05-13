//
//  JSONResponseParser.h
//  AppDotNetFeed
//
//  Created by markw on 5/13/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONResponseParser : NSObject

- (NSArray *)parseJSONgetBackArrayOfFeedPosts:(id)JSON;

@end
