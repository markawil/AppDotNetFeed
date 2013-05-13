//
//  FeedViewControllerTests.m
//  AppDotNetFeed
//
//  Created by markw on 5/10/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import "FeedViewControllerTests.h"
#import "FeedViewController.h"
#import "NSUnit.h"
#import "OCMockObject.h"
#import "OCMockRecorder.h"
#import "OCMArg.h"
#import "AppDotNetService.h"
#import "AppDotNetServiceDelegate.h"

@implementation FeedViewControllerTests {
    
    FeedViewController *_feedVC_SUT;
    id _appDotNetService;
}

- (void)setUp {
    
    [super setUp];
    _appDotNetService = [OCMockObject niceMockForClass:[AppDotNetService class]];
    _feedVC_SUT = [[FeedViewController alloc] initWithAppDotNetService:_appDotNetService];
}

- (void)test_feedViewController_should_inherit_from_UITableViewController {
    
    [Assert isTrue:[[FeedViewController class] isSubclassOfClass:[UITableViewController class]]];
}

- (void)test_feedViewController_should_conform_to_AppDotNetServiceDelegate_protocol {
    
    BOOL doesConform = [_feedVC_SUT conformsToProtocol:@protocol(AppDotNetServiceDelegate)];
    [Assert isTrue:doesConform];
}

- (void)test_viewDidLoad_should_call_appDotNetService_queryForUpdatedFeed {
    
    [[_appDotNetService expect] queryForUpdatedFeed];
    [_feedVC_SUT viewDidLoad];
    [_appDotNetService verify];
}

- (void)test_queryForUpdatedFeedFinishedWithFeedPosts_should_set_tableViewCells_with_postData {
    
    
}

- (void)tearDown {
    
    [super tearDown];
    _appDotNetService = nil;
    _feedVC_SUT = nil;
}

@end
