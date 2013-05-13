//
//  ImageSetter.m
//  AppDotNetFeed
//
//  Created by markw on 5/12/13.
//  Copyright (c) 2013 markw. All rights reserved.
//

#import "ImageSetter.h"
#import "AFNetworking.h"
#import <QuartzCore/QuartzCore.h>

@implementation ImageSetter

+ (void)setImageView:(UIImageView *)imageView fromURL:(NSURL *)url {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeHolder = [UIImage imageNamed:@"Logo"];
    imageView.clipsToBounds = YES;
    __weak UIImageView *weakImage = imageView;
    
    [imageView setImageWithURLRequest:request placeholderImage:placeHolder success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        weakImage.image = [self makeRoundedImage:image radius:10.0];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"couldn't load image: %@", [error localizedDescription]);
    }];
}

+ (UIImage *)makeRoundedImage:(UIImage *) image
                       radius: (float) radius;
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

@end
