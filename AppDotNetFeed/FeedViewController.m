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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - AppDotNetServiceDelegate methods

- (void)queryForUpdatedFeedFinishedWithFeedPosts:(NSArray *)posts {
    
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    
    [_items removeAllObjects];
    [_items addObjectsFromArray:posts];
    [self.tableView reloadData];
}

- (void)sortPostsByDate {
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"dateOfPost" ascending:NO];
    [_items sortUsingDescriptors: [NSArray arrayWithObject: sortDescriptor]];
}

@end
