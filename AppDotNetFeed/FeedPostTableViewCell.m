//
//  FeedPostTableViewCell.m
//  AppDotNetFeed
//
//  Created by markw on 5/12/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import "FeedPostTableViewCell.h"
#import "ImageSetter.h"

#define MARGIN 10

@interface FeedPostTableViewCell ()

@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation FeedPostTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.font  = [UIFont boldSystemFontOfSize:14];
        
        self.detailTextLabel.font = [UIFont systemFontOfSize:13];
        self.textLabel.numberOfLines = 2;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

+ (FeedPostTableViewCell *)cellForTableView:(UITableView *)tableView {
    
    NSString *identifier = @"FeedPostCell";
    FeedPostTableViewCell *cell = (FeedPostTableViewCell *)[tableView
                                                      dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[FeedPostTableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:identifier];
    }
    
    return cell;
}

- (void)setDateLabelWithDate:(NSDate *)date {
    
    if (self.dateLabel == nil) {
        
        float xValue = self.frame.size.width - 70;
        // create a custom label:                                    x       y   width  height
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(xValue, 50.0f, 80, 12.0f)];
        self.dateLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self.dateLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
        self.dateLabel.textColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
        [self.contentView addSubview:self.dateLabel];
    }
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yy"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    self.dateLabel.text = dateString;
}

+ (CGFloat)heightForVideo:(FeedPost *)feedPost {
    
    //create a dummy cell
    FeedPostTableViewCell *sampleCell  = [[FeedPostTableViewCell alloc]
                                       initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:nil];
    [sampleCell updateCellForVideo:feedPost];
    
    //calculate the sizes of the text labels
    CGSize textSize = [feedPost.text sizeWithFont: [FeedPostTableViewCell textLabelFont]
                              constrainedToSize:sampleCell.textLabel.frame.size
                                  lineBreakMode:UILineBreakModeWordWrap];
    CGFloat minHeight = 61 + 10;  //image height + margin
    return MAX(textSize.height + 20, minHeight);
}

+ (UIFont *)textLabelFont {
    return [UIFont systemFontOfSize:12];
}

- (void)updateCellForVideo:(FeedPost *)feedPost {
    
    // set the text to the date with the tweet text
    self.textLabel.text = feedPost.authorName;
    self.detailTextLabel.text = feedPost.text;
    [self setDateLabelWithDate:feedPost.dateOfPost];
    [ImageSetter setImageView:self.imageView fromURL:feedPost.imageUrl];
}

@end
