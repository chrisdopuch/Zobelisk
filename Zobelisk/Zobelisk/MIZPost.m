//
//  MIZEpisode.m
//  EpisodeListDemo
//
//  Created by Class on 3/6/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZPost.h"
#import "MIZGregorianDateComponents.h"

@implementation MIZPost
//ecoding and decoding variables read in the JSON file

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.email forKey:@"emai"];
    [aCoder encodeObject:self.date forKey:@"timestamp"];
    [aCoder encodeObject:self.postTitle forKey:@"title"];
    [aCoder encodeObject:self.content forKey:@"body_text"];
    [aCoder encodeObject:self.eventDate forKey:@"event_date"];
    [aCoder encodeObject:self.media forKey:@"media"];
    [aCoder encodeInteger:self.likes forKey:@"likes"];
    [aCoder encodeInteger:(self.postID) forKey:@"post_id"];
    
    [aCoder encodeObject:self.firstName forKey:@"first_name"];
    [aCoder encodeObject:self.lastName forKey:@"last_name"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.twitter forKey:@"twitter"];
    
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
        self.firstName= [aDecoder decodeObjectForKey:@"first_name"];
        self.lastName = [aDecoder decodeObjectForKey:@"last_name"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.twitter = [aDecoder decodeObjectForKey:@"twitter"];
    }
    return self;
}
//creating post at a specific iBeacon


+ (void) createPost:(NSDictionary*)obj onBeacon:(NSNumber*)beacon
{
 
 NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
 
 NSString *urlString = @"http://zobelisk-backend.herokuapp.com/posts";
 //converts string into URL var
 NSURL *restURL = [NSURL URLWithString:urlString];
 
 NSMutableDictionary *post = [[NSMutableDictionary alloc] init];
 NSMutableDictionary *form = [[NSMutableDictionary alloc] init];
 MIZGregorianDateComponents* components = [[MIZGregorianDateComponents alloc] init];
 MIZGregorianDateComponents* event   = [[MIZGregorianDateComponents alloc] initWithString: [obj objectForKey:@"expiration_date"]];
    
 [post setObject: [obj objectForKey:@"email"] forKey:@"email"];
 [post setObject: beacon forKey:@"beacon_id"];
 [post setObject:[components year] forKey:@"timestamp(1i)"];
 [post setObject:[components month] forKey:@"timestamp(2i)"];
 [post setObject:[components day] forKey:@"timestamp(3i)"];
 [post setObject:[components hour] forKey:@"timestamp(4i)"];
 [post setObject:[components minute] forKey:@"timestamp(5i)"];
 [post setObject:[NSNumber numberWithInt:0] forKey: @"likes"];
 [post setObject:[obj objectForKey:@"title"] forKey:@"title"];
 [post setObject:[event year] forKey:@"event_date(1i)"];
 [post setObject:[event month] forKey:@"event_date(2i)"];
 [post setObject:[event day] forKey:@"event_date(3i)"];
 [post setObject:[obj objectForKey:@"description"] forKey:@"body_text"];
 //[post setObject: forKey:@"tag_list"];
 
 
 [form setObject:@"✓" forKey:@"utf8"];
 [form setObject:post forKey:@"post"];
 [form setObject:@"Create Post" forKey:@"commit"];
 
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
 
 
 NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
     
 if(error == nil )
 {
     for (NSString *key in [jsonDict allKeys]) {
         NSLog(@"%@ : %@\n", key, [jsonDict objectForKey:key]);
     }
     NSLog(@"post");
 }
 }];
 
 //resumes the Datarequest.
 [dataRequest resume];
 
 }

//pocket post function

- (void) favoritePost:(int)postId
{
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSString *urlString = @"http://zobelisk-backend.herokuapp.com/favorited.json";
    NSURL *restURL = [NSURL URLWithString:urlString];
    NSMutableDictionary *favorite = [[NSMutableDictionary alloc] init];
    [favorite setObject: [NSNumber numberWithInt:postId] forKey:@"favorable_id"];
    [favorite setObject: @"post" forKey:@"favorable_type"];
    
    NSMutableDictionary *form = [[NSMutableDictionary alloc]init];
    [form setObject:favorite forKey:@"favorite"];
    [form setObject:@"✓" forKey:@"utf8"];
    [form setObject:@"Create Favorite" forKey:@"commit"];
    
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
        
        NSLog(@"%@", response);
        //NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        if(error == nil )
        {
            //NSLog(@"post");
        }
    }];
    
    //resumes the Datarequest.
    [dataRequest resume];
}


- (void) commentPost:(NSDictionary*) comment {
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSString *urlString = @"http://zobelisk-backend.herokuapp.com/comments.json";
    NSURL *restURL = [NSURL URLWithString:urlString];
    MIZGregorianDateComponents* components = [[MIZGregorianDateComponents alloc] init];
    NSMutableDictionary *com = [[NSMutableDictionary alloc] init];
    
    [com setObject:[comment objectForKey:@"text_body"] forKey:@"text_body"];
    [com setObject:[comment objectForKey:@"post_id"] forKey:@"post_id"];
    [com setObject: [components year] forKey:@"timestamp(1i)"];
    [com setObject:[components month] forKey:@"timestamp(2i)"];
    [com setObject:[components day] forKey:@"timestamp(3i)"];
    [com setObject:[components hour] forKey:@"timestamp(4i)"];
    [com setObject:[components minute] forKey:@"timestamp(5i)"];
    
    NSMutableDictionary *form = [[NSMutableDictionary alloc]init];
    [form setObject:com forKey:@"comment"];
    [form setObject:@"✓" forKey:@"utf8"];
    [form setObject:@"Create Favorite" forKey:@"commit"];
    
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
        
        NSLog(@"%@", response);
        //NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        if(error == nil )
        {
            //NSLog(@"comment");
        }
    }];
    
    //resumes the Datarequest.
    [dataRequest resume];
}


@end
