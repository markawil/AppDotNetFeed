//
//  FeedViewController.m
//  AppDotNetFeed
//
//  Created by markw on 5/10/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedPostTableViewCell.h"
#import "FeedPost.h"
#import "SVProgressHUD.h"

@interface FeedViewController ()

@end

@implementation FeedViewController {
    
    NSMutableArray *_items;
    AppDotNetService *_service;
}

- (id)initWithAppDotNetService:(AppDotNetService *)service {
    
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _service = service;
        self.title = @"App.net Feed";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:refreshControl];
    
    [SVProgressHUD show];
    [_service queryForUpdatedFeed];
}

- (void)refresh:(id)sender {
    
    [(UIRefreshControl *)sender endRefreshing];
    [_service queryForUpdatedFeed];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FeedPost *feedPost = [_items objectAtIndex:indexPath.row];
    return [FeedPostTableViewCell heightForFeedPost:feedPost];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedPostTableViewCell *cell = [FeedPostTableViewCell cellForTableView:tableView];
    FeedPost *feedPost = [_items objectAtIndex:indexPath.row];
    [cell updateCellForVideo:feedPost];
    return cell;
}

#pragma mark - AppDotNetServiceDelegate methods

- (void)queryForUpdatedFeedFinishedWithFeedPosts:(NSArray *)posts {
    
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    
    // we'll only allow 100 posts at a time in the TableView
    // this will work like a queue of the oldest being bumped out by the newest
    if ([_items count] >= 100) {
        [self removeLast20Items];
    }
    
    [self addItemsPreventDuplicates:posts];
    [self sortPostsByDate:_items];
    [self.tableView reloadData];
}

- (void)addItemsPreventDuplicates:(NSArray *)posts {

    if ([_items count] > 0) {
        
        for (FeedPost *feedPost in posts) {
            
            if (![_items containsObject:feedPost]) {
                [_items addObject:feedPost];
            }
        }
    }
    else {
        [_items addObjectsFromArray:posts];
    }
    
}

- (void)sortPostsByDate:(NSMutableArray *)feedPosts {
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"dateOfPost" ascending:NO];
    [feedPosts sortUsingDescriptors: [NSArray arrayWithObject: sortDescriptor]];
}

- (void)removeLast20Items {
    
    NSRange range;
    range.location = 79;
    range.length = 20;
    [_items removeObjectsInRange:range];
}

@end
