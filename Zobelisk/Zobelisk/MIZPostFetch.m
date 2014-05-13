//
//  MIZEpisodeListFetcher.m
//  EpisodeListDemo
//
//  Created by Class on 3/6/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZGregorianDateComponents.h"
#import "MIZPostFetch.h"
#import "MIZGregorianDateComponents.h"

@implementation MIZPostFetch

+ (void) createPost:(NSString *)title atBeacon:(short)beaconId withBody:(NSString *)body forEventOn:(NSString *)day duringMonth:(NSString *)month andYear:(NSString *)year taggedWithList:(NSString *)taglist{
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];

    NSString *urlString = @"http://zobelisk-backend.herokuapp.com/posts/new";
    //converts string into URL var
    NSURL *restURL = [NSURL URLWithString:urlString];
    
    NSMutableDictionary *post = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *form = [[NSMutableDictionary alloc] init];
    
    MIZGregorianDateComponents *components = [MIZGregorianDateComponents init];
    
    NSString* email = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];

    [post setObject: [NSNumber numberWithInt:beaconId ] forKey:@"beacon_id"];
    [post setObject: email forKey:@"email"];
    [post setObject:[components year] forKey:@"timestamp(1i)"];
    [post setObject:[components month] forKey:@"timestamp(2i)"];
    [post setObject:[components day] forKey:@"timestamp(3i)"];
    [post setObject:[components hour] forKey:@"timestamp(4i)"];
    [post setObject:[components  minute] forKey:@"timestamp(5i)"];
    [post setObject:[NSNumber numberWithInt:0] forKey: @"likes"];
    [post setObject:title forKey:@"title"];
    [post setObject:year forKey:@"event_date(1i)"];
    [post setObject:month forKey:@"event_date(2i)"];
    [post setObject:day forKey:@"day"];
    [post setObject:body forKey:@"body_text"];
    [post setObject:taglist forKey:@"tag_list"];

    
    
    [form setObject:@"✓" forKey:@"utf8"];
    [form setObject:post forKey:@"post"];
    [form setObject:@"Sign up" forKey:@"commit"];
    
    //converts key/value pair into request data
    NSData* requestData = [NSJSONSerialization dataWithJSONObject:form options:0 error:nil];
    
    //sets up URL session using config
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    //sets up URL request with POST method to url
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:restURL];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:requestData];
    
    //Data task request sent to server
    NSURLSessionDataTask *dataRequest = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
       // NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        if(error == nil )
        {
            NSLog(@"post");
            
        }
    }];
    
    //resumes the Datarequest.
    [dataRequest resume];
    
}

+ (void)fetchPostforBeacon:(NSNumber*)id
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", @"http://zobelisk-backend.herokuapp.com/posts.json?beacon_id=", id];
    NSLog(@"%@", urlString);
    //NSString *urlString = @"http://zobelisk-backend.herokuapp.com/posts.json";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200) {
            [MIZPostFetch processPostListFromData:data];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MIZPostFetchFailed" object:nil userInfo:nil];
        }
    }] resume];
}

+ (void)fetchPostFavorite
{
    NSUserDefaults *defaults = [[NSUserDefaults alloc] init];
    NSString* uid = [defaults objectForKey:@"userID"];
    
    NSString *urlString = [NSString stringWithFormat: @"http://zobelisk-backend.herokuapp.com/favorited.json?user_id=%@", uid];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200) {
            [MIZPostFetch processPostListFromData:data];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MIZPostFetchFailed" object:nil userInfo:nil];
        }
    }] resume];
}

+ (void)fetchPost
{
    NSString *urlString = @"http://zobelisk-backend.herokuapp.com/posts.json";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200) {
            [MIZPostFetch processPostListFromData:data];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MIZPostFetchFailed" object:nil userInfo:nil];
        }
    }] resume];
}

//grab list of posts for the backend
+ (void)processPostListFromData:(NSData *)data
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
        post.postTitle = dictionary[@"title"];
        post.content = dictionary[@"body_text"];
        post.eventDate = dictionary[@"event_date"];
        post.media = dictionary[@"media"];
        post.postID = [dictionary[@"post_id"] integerValue];
        
        
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

//grab a specifi users information from the backend
+ (void)fetchUser
{

    NSString *urlString = @"http://zobelisk-backend.herokuapp.com/get_user.json";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200) {
            [MIZPostFetch processUsersListFromData:data];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"MIZUserFetchFailed" object:nil userInfo:nil];
        }
    }] resume];
}


+ (void)processUsersListFromData:(NSData *)data
{
    NSMutableArray *users = [[NSMutableArray alloc] init];
    
    // Here, have an error.
    NSError *error;
    // Turn the data into a dictionary
    NSArray *postArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    // get the root array for the JSON
    NSLog(@"Success?");
    //    NSArray *postDictionaries = postDictionary[@"posts"];
    for (NSDictionary *dictionary in postArray) {
        MIZPost *user = [[MIZPost alloc] init];
        user.email = dictionary[@"email"];
        user.firstName = dictionary[@"first_name"];
        user.lastName = dictionary[@"last_name"];
       user.phone = dictionary[@"phone"];
        user.twitter = dictionary[@"twitter"];
        
        [users addObject: user];
    }
    NSLog(@"Success");
    
    NSString* path = [NSSearchPathForDirectoriesInDomains(
                                                          NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    path = [path stringByAppendingPathComponent:@"users.miz"];
    [NSKeyedArchiver archiveRootObject:users toFile:path];
    
    // send out a notification that processing is complete.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MIZPostFinishedProcessing" object:nil userInfo:@{@"user": users}];
}

@end
