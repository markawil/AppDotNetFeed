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
#define DETAIL_WIDTH 220.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f
#define FONT_SIZE 12.0f

@interface FeedPostTableViewCell ()

@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation FeedPostTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.font  = [FeedPostTableViewCell textLabelFont];
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
    CGRect imageFrame = CGRectMake(5, MARGIN, 60, 60);
    self.imageView.frame = imageFrame;
    
    CGRect cvf = self.contentView.frame;
    CGRect frame = CGRectMake(imageFrame.size.width + MARGIN + 2,
                              self.textLabel.frame.origin.y,
                              cvf.size.width - cvf.size.height - 2*MARGIN,
                              self.textLabel.frame.size.height);
    self.textLabel.frame = frame;
    
    frame = CGRectMake(imageFrame.size.width + MARGIN + 5,
                       self.detailTextLabel.frame.origin.y,
                       DETAIL_WIDTH,
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

- (void)setDateLabelWithDate:(NSDate *)dateOfPost {
    
    if (self.dateLabel == nil) {
        
        float xValue = self.frame.size.width - 70;
        // create a custom label:                                    x       y   width  height
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(xValue, 5.0f, 80, 12.0f)];
        self.dateLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self.dateLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
        self.dateLabel.textColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
        [self.contentView addSubview:self.dateLabel];
    }
    
    NSDate *dateNow = [NSDate date];
    NSTimeInterval distanceBetweenDates = [dateNow timeIntervalSinceDate:dateOfPost];
    int minutes = round(distanceBetweenDates/60);
    int seconds = round(distanceBetweenDates);
    
    if (minutes > 0) {
        self.dateLabel.text = [NSString stringWithFormat:@"%i min", minutes];
    }
    else {
        self.dateLabel.text = [NSString stringWithFormat:@"%i sec", seconds];
    }
}

+ (CGFloat)heightForFeedPost:(FeedPost *)feedPost {
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    CGSize size = [feedPost.text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:NSLineBreakByCharWrapping];    
    CGFloat height = MAX(size.height, 44.0f);
    
    return height + (CELL_CONTENT_MARGIN * 2) + 30;
}

+ (UIFont *)textLabelFont {
    return [UIFont boldSystemFontOfSize:13];
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
