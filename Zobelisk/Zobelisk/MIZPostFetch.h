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

+ (void)fetchPostforBeacon:(NSNumber*)id;
+ (void) fetchPostFavorite;
+ (void)fetchPost;
+ (void) fetchUser;
@end
