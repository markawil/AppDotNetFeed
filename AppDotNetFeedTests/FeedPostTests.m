//
//  FeedPostTests.m
//  AppDotNetFeed
//
//  Created by markw on 5/10/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import "FeedPostTests.h"
#import "FeedPost.h"
#import "NSUnit.h"

@implementation FeedPostTests {
    
    FeedPost *_feedPost;
}

- (void)setUp {
    
    [super setUp];
    _feedPost = [[FeedPost alloc] initWithDictionary:[self buildUpDictionary]];
}

- (NSDictionary *)buildUpDictionary {
    
    NSDictionary *avatar = @{@"url": @"www.google.com/myImage.png"};
    NSDictionary *user = @{@"username": @"markw",
                           @"avatar_image": avatar};
    NSDictionary *d = @{@"user": user,
                        @"created_at": @"2013-05-10T16:39:29Z",
                        @"text": @"here's my post"};
    return d;
}

- (void)test_init_should_set_text_property_from_dictionary {
    
    [Assert that:_feedPost.text is:[Equal to:@"here's my post"]];
}

- (void)test_init_should_set_imageURL_property_from_dictionary {
    
    NSString *urlPath = _feedPost.imageUrl.path;
    [Assert that:urlPath is:[Equal to:@"www.google.com/myImage.png"]];
}

- (void)test_init_should_set_authorName_property_from_dictionary {
    
    [Assert that:_feedPost.authorName is:[Equal to:@"markw"]];
}

- (void)test_init_should_set_postDate_property_from_dictionary {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:_feedPost.dateOfPost];
    int day = [components day];
    int month = [components month];
    int year = [components year];
    
    

}

- (void)tearDown {
    
    [super tearDown];
}

@end
