//
//  MIZPostFetch.h
//  Zobelisk
//
//  Created by Victor Tran on 4/28/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIZPost.h"

@interface MIZPostFetch : NSObject

+ (void)fetchPost;

//+ (void)createPost:(NSString*)title atBeacon:(short) beaconId withBody:(NSString*)body forEventOn:(NSString*)Day duringMonth:(NSString*) andYear:(NSString*)year taggedWithList: (NSString*) taglist;
@end
