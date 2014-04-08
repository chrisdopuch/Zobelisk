//
//  MIZImageFetcher.h
//  Zobelisk
//
//  Created by Seth Wiesman on 4/8/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIZImageFetcher : NSObject

+ (UIImage *) getImageFromURL:(NSString *)url;
+ (void) saveImage:(UIImage *)image withFileName:(NSString *)name withExtension:(NSString *)extension inDirectory:(NSString *)directory;

@end
