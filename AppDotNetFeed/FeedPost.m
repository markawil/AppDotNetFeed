//
//  FeedPost.m
//  AppDotNetFeed
//
//  Created by markw on 5/10/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import "FeedPost.h"

@implementation FeedPost

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        
        _text = dictionary[@"text"];
        NSDictionary *user = dictionary[@"user"];
        NSDictionary *avatar = user[@"avatar_image"];
        NSString *avUrl = avatar[@"url"];
        _imageUrl = [NSURL URLWithString:avUrl];
        _authorName = user[@"username"];
    }
    
    return self;
}

@end
