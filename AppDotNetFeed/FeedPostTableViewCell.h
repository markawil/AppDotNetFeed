//
//  FeedPostTableViewCell.h
//  AppDotNetFeed
//
//  Created by markw on 5/12/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedPost.h"

@interface FeedPostTableViewCell : UITableViewCell

+ (FeedPostTableViewCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForFeedPost:(FeedPost *)feedPost;
- (void)updateCellForVideo:(FeedPost *)feedPost;

@end
