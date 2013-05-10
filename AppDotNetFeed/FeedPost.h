//
//  FeedPost.h
//  AppDotNetFeed
//
//  Created by markw on 5/10/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedPost : NSObject

- (id)initWithDictionary:(NSDictionary *)dictionary;

@property (readonly) NSString *text;
@property (readonly) NSURL *imageUrl;
@property (readonly) NSString *authorName;
@property (readonly) NSDate *dateOfPost;

@end
