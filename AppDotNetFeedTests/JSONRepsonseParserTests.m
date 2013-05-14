//
//  JSONRepsonseParserTests.m
//  AppDotNetFeed
//
//  Created by markw on 5/13/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import "JSONRepsonseParserTests.h"
#import "JSONResponseParser.h"
#import "JSONKit.h"
#import "NSUnit.h"

@implementation JSONRepsonseParserTests {
    
    JSONResponseParser *_parserSUT;
}

- (void)setUp {
    
    [super setUp];
    _parserSUT = [[JSONResponseParser alloc] init];
}

- (void)test_parser_should_return_correct_number_of_feedPosts_from_JSON_in_file {
    
    id JSON = [self data_from_JSON_file:@"response"];
    NSArray *arrayOfPosts = [_parserSUT parseJSONgetBackArrayOfFeedPosts:JSON];
    NSNumber *postsCount = [NSNumber numberWithInt:[arrayOfPosts count]];
    // should be 20 posts given back at time from global feed
    [Assert that:postsCount is:[Equal to:@20]];
}

- (id)data_from_JSON_file:(NSString *)fileName {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *jsonString = [bundle pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonString];
    JSONDecoder *decoder = [[JSONDecoder alloc] initWithParseOptions:JKParseOptionNone];
    
    NSError *error = nil;
    id results =  [decoder objectWithData:data error:&error];
    if (error)
        NSLog(@"\r\r\r\r\r\r%s: error = %@", __FUNCTION__, error);
    return results;
}


- (void)tearDown {
    
    [super tearDown];
    _parserSUT = nil;
}

@end
