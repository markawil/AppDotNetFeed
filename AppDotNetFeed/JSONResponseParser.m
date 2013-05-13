//
//  JSONResponseParser.m
//  AppDotNetFeed
//
//  Created by markw on 5/13/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import "JSONResponseParser.h"
#import "FeedPost.h"

@implementation JSONResponseParser

- (NSArray *)parseJSONgetBackArrayOfFeedPosts:(id)JSON {
    
    NSArray *arrayFromJSON = [JSON objectForKey:@"data"];
    NSMutableArray *arrayOfPosts = [NSMutableArray array];
    
    for (NSDictionary *d in arrayFromJSON) {
        FeedPost *feedPost = [[FeedPost alloc] initWithDictionary:d];
        [arrayOfPosts addObject:feedPost];
    }
    
    return arrayOfPosts;
}

@end
