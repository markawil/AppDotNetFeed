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
        _dateOfPost = [self getDateFromString:dictionary[@"created_at"]];
        _idString = dictionary[@"id"];
    }
    
    return self;
}

- (NSDate *)getDateFromString:(NSString *)dateAsStr {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ssZ'"];
    NSDate *date = [df dateFromString:dateAsStr];
    return date;
}

- (BOOL)isEqual:(id)object {
    
    if ([object isKindOfClass:[FeedPost class]]) {
        FeedPost *postToCompare = object;
        return [postToCompare.idString isEqual:self.idString];
    }
    
    return NO;
}

@end
