//
//  MIZPost.h
//  Zobelisk
//
//  Created by Victor Tran on 4/28/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIZPost : UIViewController

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *postTitle;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *eventDate;
@property (nonatomic, strong) NSString *media;
@property (nonatomic) NSInteger likes;


+ (void) createPost:(NSString *)title atBeacon:(short)beaconId withBody:(NSString *)body forEventOn:(NSString *)day duringMonth:(NSString *)month andYear:(NSString *)year taggedWithList:(NSString *)taglist;

+ (void) favoritePost:(int)postId;
@end
