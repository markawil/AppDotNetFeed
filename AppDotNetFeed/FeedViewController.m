//
//  FeedViewController.m
//  AppDotNetFeed
//
//  Created by markw on 5/10/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import "FeedViewController.h"

@interface FeedViewController ()

@end

@implementation FeedViewController {
    
    NSMutableArray *_items;
    AppDotNetService *_service;
}

- (id)initWithAppDotNetService:(AppDotNetService *)service {
    
    self = [super init];
    if (self) {
        _service = service;
        self.title = @"App.net Feed";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
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
    
    
}

@end
