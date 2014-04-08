//
//  MIZImageFetcher.m
//  Zobelisk
//
//  Created by Seth Wiesman on 4/8/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZImageFetcher.h"

@implementation MIZImageFetcher

+ (UIImage *) getImageFromURL:(NSString *)url{
    UIImage *result = nil;
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    result = [UIImage imageWithData:data];
    
    return result;
}

+ (void) saveImage:(UIImage *)image withFileName:(NSString *)name withExtension:(NSString *)extension inDirectory:(NSString *)directory{
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", name, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", name, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        NSLog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
    }
}

@end
