//
//  FeedPostBuilder.m
//  AppDotNetFeed
//
//  Created by markw on 5/13/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import "FeedPostBuilder.h"
#import "FeedPost.h"

@implementation FeedPostBuilder

+ (NSArray *)buildStubbedArrayOfPosts {
    
    NSDate *startDate = [NSDate date];
    NSMutableArray *arrayToReturn = [NSMutableArray array];
    
    for (int i = 0; i < 20; i++) {
        
        // lets add 10 seconds to each date so they can be sortable
        NSDate *newDateTime = [startDate dateByAddingTimeInterval:10];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ssZ'"];
        NSString *stringFromDate = [df stringFromDate:newDateTime];
        
        NSDictionary *avatar = @{@"url": @"www.google.com/myImage.png"};
        NSDictionary *user = @{@"username": [NSString stringWithFormat:@"author %i", i],
                               @"avatar_image": avatar};
        NSDictionary *d = @{@"user": user,
                            @"created_at": stringFromDate,
                            @"text": [NSString stringWithFormat:@"here's my post number %i", i]};
        
        FeedPost *newPost = [[FeedPost alloc] initWithDictionary:d];
        [arrayToReturn addObject:newPost];
    }
    
    return arrayToReturn;
}

@end
