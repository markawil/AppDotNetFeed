//
//  AppDotNetService.m
//  AppDotNetFeed
//
//  Created by markw on 5/10/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import "AppDotNetService.h"
#import "AFNetworking.h"
#import "FeedPost.h"
#import "SVProgressHUD.h"

#define URL_PATH @"https://alpha-api.app.net/stream/0/posts/stream/global"

@implementation AppDotNetService {
    
    JSONResponseParser *_parser;
}

- (id)initWithJSONParser:(JSONResponseParser *)parser {
    
    self = [super init];
    if (self) {
        _parser = parser;
    }
    
    return self;
}

- (void)queryForUpdatedFeed {
    
    NSURL *url = [NSURL URLWithString:URL_PATH];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        [self handleSuccessJSONResponse:JSON];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        [self handleErrorFromRequest:error];
    }];
    
    [operation start];
}

- (void)handleSuccessJSONResponse:(id)JSON {
    
    NSArray *posts = [_parser parseJSONgetBackArrayOfFeedPosts:JSON];
    [self.delegate queryForUpdatedFeedFinishedWithFeedPosts:posts];
    [SVProgressHUD dismiss];
}

- (void)handleErrorFromRequest:(NSError *)error {
    
    [SVProgressHUD dismiss];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[error localizedDescription]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

@end
