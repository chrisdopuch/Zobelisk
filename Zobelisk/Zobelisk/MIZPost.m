//
//  MIZEpisode.m
//  EpisodeListDemo
//
//  Created by Class on 3/6/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZPost.h"

@implementation MIZPost

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.email forKey:@"emai"];
    [aCoder encodeObject:self.date forKey:@"timestamp"];
    [aCoder encodeObject:self.postTitle forKey:@"title"];
    [aCoder encodeObject:self.content forKey:@"body_text"];
    [aCoder encodeObject:self.eventDate forKey:@"event_date"];
    [aCoder encodeObject:self.media forKey:@"media"];
    [aCoder encodeInteger:self.likes forKey:@"likes"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.date = [aDecoder decodeObjectForKey:@"timestamp"];
        self.postTitle = [aDecoder decodeObjectForKey:@"title"];
        self.content = [aDecoder decodeObjectForKey:@"body_text"];
        self.eventDate = [aDecoder decodeObjectForKey:@"event_date"];
        self.media = [aDecoder decodeObjectForKey:@"media"];
        self.likes = [aDecoder decodeIntegerForKey:@"likes"];
    }
    return self;
}

@end
