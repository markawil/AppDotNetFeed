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
        
        self.textLabel.font  = [UIFont boldSystemFontOfSize:13];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.detailTextLabel.font = [FeedPostTableViewCell detailTextLabelFont];
        self.detailTextLabel.numberOfLines = 7;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return self;
}

// needed to align the imageviews in the cells
// and set the imageview size
- (void)layoutSubviews {
    
    [super layoutSubviews];
    CGRect cvf = self.contentView.frame;
    self.imageView.frame = CGRectMake(5, MARGIN, 60, 60);
    
    CGRect frame = CGRectMake(cvf.size.height + MARGIN,
                              self.textLabel.frame.origin.y,
                              cvf.size.width - cvf.size.height - 2*MARGIN,
                              self.textLabel.frame.size.height);
    self.textLabel.frame = frame;
    
    frame = CGRectMake(cvf.size.height + MARGIN,
                       self.detailTextLabel.frame.origin.y,
                       cvf.size.width - cvf.size.height - 2*MARGIN,
                       self.detailTextLabel.frame.size.height);
    self.detailTextLabel.frame = frame;
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
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(xValue, 5.0f, 80, 12.0f)];
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

+ (CGFloat)heightForFeedPost:(FeedPost *)feedPost {
    
    //create a dummy cell
    FeedPostTableViewCell *sampleCell = [[FeedPostTableViewCell alloc]
                                       initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:nil];
    
    sampleCell.textLabel.text = feedPost.authorName;
    sampleCell.detailTextLabel.text = feedPost.text;
    sampleCell.imageView.image = [UIImage imageNamed:@"portrait_placeholder"];
    [sampleCell layoutSubviews];
    
    //calculate the sizes of the text labels
    CGSize authorNameSize = [feedPost.authorName sizeWithFont: [UIFont boldSystemFontOfSize:13]
                                   constrainedToSize:sampleCell.textLabel.frame.size
                                       lineBreakMode:NSLineBreakByTruncatingHead];
    
    CGSize textSize = [feedPost.text sizeWithFont: [FeedPostTableViewCell detailTextLabelFont]
                              constrainedToSize:sampleCell.detailTextLabel.frame.size
                                  lineBreakMode:NSLineBreakByWordWrapping];
    
    NSLog(@"textSize height was: %f", textSize.height);
    NSLog(@"textSize width was: %f", textSize.width);
    CGFloat minHeight = 60 + 20;  //image height and margin should be the minimum
    return MAX(authorNameSize.height + textSize.height, minHeight);
}

+ (UIFont *)detailTextLabelFont {
    return [UIFont systemFontOfSize:12];
}

- (void)updateCellForVideo:(FeedPost *)feedPost {
    
    self.textLabel.text = feedPost.authorName;
    self.detailTextLabel.text = feedPost.text;
    [self setDateLabelWithDate:feedPost.dateOfPost];
    [ImageSetter setImageView:self.imageView fromURL:feedPost.imageUrl];
}

@end
