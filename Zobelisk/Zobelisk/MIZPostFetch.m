//
//  MIZEpisodeListFetcher.m
//  EpisodeListDemo
//
//  Created by Class on 3/6/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZPostFetch.h"

@implementation MIZPostFetch

+ (void)fetchPost
{
    NSString *urlString = @"http://zobelisk-backend.herokuapp.com/posts.json";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200) {
            [MIZPostFetch processEpisodeListFromData:data];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MIZPostFetchFailed" object:nil userInfo:nil];
        }
    }] resume];
}

+ (void)processEpisodeListFromData:(NSData *)data
{
    NSMutableArray *posts = [[NSMutableArray alloc] init];
    
    // Here, have an error.
    NSError *error;
    // Turn the data into a dictionary
    NSArray *postArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    // get the root array for the JSON
      NSLog(@"Success?");
//    NSArray *postDictionaries = postDictionary[@"posts"];
    for (NSDictionary *dictionary in postArray) {
        MIZPost *post = [[MIZPost alloc] init];
        post.email = dictionary[@"email"];
        post.date = dictionary[@"timestamp"];
        post.title = dictionary[@"title"];
        post.content = dictionary[@"body_text"];
        post.eventDate = dictionary[@"event_date"];
        post.media = dictionary[@"media"];
        if (dictionary[@"likes"] == [NSNull null]) {
            post.likes = 0;
        }
        else
        {
            post.likes = [dictionary[@"likes"] integerValue];
        }
       // post.likes = [dictionary[@"likes"] integerValue];
        [posts addObject:post];
    }
    NSLog(@"Success");
    
    NSString* path = [NSSearchPathForDirectoriesInDomains(
                                                          NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    path = [path stringByAppendingPathComponent:@"posts.miz"];
    [NSKeyedArchiver archiveRootObject:posts toFile:path];
    
    // send out a notification that processing is complete.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MIZPostFinishedProcessing" object:nil userInfo:@{@"post": posts}];
}

@end
