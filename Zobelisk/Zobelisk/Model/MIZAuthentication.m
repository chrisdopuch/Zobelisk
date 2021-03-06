//
//  MIZAuthentication.m
//  Zobelisk
//
//  Created by Seth Wiesman on 4/23/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZAuthentication.h"

@implementation MIZAuthentication

+ (void) registerUser:(NSMutableDictionary*)user
{
    
    [MIZAuthentication registerEmail:[user objectForKey:@"email"] withPassword:[user objectForKey:@"password"] andConfirmationPassword: [user objectForKey:@"password"]];
    //[MIZAuthentication loginWithEmail:[user objectForKey:@"email"] withPassword:[user objectForKey:@"password"]];
    //[MIZAuthentication updateUser:user];
    
}

+ (void)updateUser:(NSMutableDictionary*)userProfile
{
    {
        NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        
        //converts url into a string
        NSString* urlString = @"http://zobelisk-backend.herokuapp.com/users";
        
        //converts string into URL var
        NSURL *restURL = [NSURL URLWithString:urlString];
        
        NSMutableDictionary *form = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *user = [[NSMutableDictionary alloc] init];
        
        [userProfile setObject:[userProfile objectForKey:@"email"] forKey:@"email"];
        [userProfile  setObject:[userProfile objectForKey:@"password"] forKey:@"current_password"];
        [userProfile  setObject:[userProfile objectForKey:@"first name"] forKey:@"first_name"];
        [userProfile  setObject:[userProfile objectForKey:@"last name"] forKey:@"last_name"];
        [userProfile  setObject:[userProfile objectForKey:@"address"] forKey:@"address"];
        [userProfile  setObject:[userProfile objectForKey:@"twitterHandle"] forKey:@"twitter"];
        
        [form setObject:@"✓" forKey:@"utf8"];
        [form setObject:@"put" forKey:@"_method"];
        [form setObject:user forKey:@"user"];
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
            
        }];
        
        
        //resumes the Datarequest.
        [dataRequest resume];
        
    }
    
}

+ (void) registerEmail:(NSString*)email withPassword:(NSString*)password andConfirmationPassword:(NSString*)password_confirmation
{
   NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    
    //converts url into a string
    NSString* urlString = @"http://zobelisk-backend.herokuapp.com/users.json";
    
    //converts string into URL var
    NSURL *restURL = [NSURL URLWithString:urlString];
    
    NSMutableDictionary *paw = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *user = [[NSMutableDictionary alloc] init];
    
    [user setObject:email forKey:@"email"];
    [user setObject:password forKey:@"password"];
    [user setObject:password_confirmation forKey:@"password_confirmation"];
    
    
    [paw setObject:@"✓" forKey:@"utf8"];
    [paw setObject:user forKey:@"user"];
    [paw setObject:@"Sign up" forKey:@"commit"];
    
    //converts key/value pair into request data
    NSData* requestData = [NSJSONSerialization dataWithJSONObject:paw options:0 error:nil];
    
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
        
        if(error == nil && [[jsonDict objectForKey:@"status"] intValue] == 0)
        {
            NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
            [standardDefaults setObject:email forKey:@"email"];
            [standardDefaults synchronize];
            
        }
    }];
    
    //resumes the Datarequest.
    [dataRequest resume];
    
}

+ (void) logout
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"email"];
}

- (BOOL) verifyLogin{
    NSString *storedEmail = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    if(storedEmail != nil){
        NSLog(@"%@", storedEmail);
        return YES;
    }
    else{
         NSLog(@"NOT logged in");
        return NO;
    }
}

+ (void) registerEmail:(NSString *)email withPassword:(NSString *)password confirmationPassword:(NSString *)password_confirmation firstName:(NSString *)fName lastName:(NSString *)lname dateOfBirth:(NSDate *)dob address:(NSString *)loc twitter:(NSString *)twiterHandle andPhonenumber:(NSString *)number
{
    
}

+ (void) getUserId:(NSString*)email
{
    NSString* urlString = [NSString stringWithFormat: @"http://zobelisk-backend.herokuapp.com/get_user.json?email=%@", [email stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //converts string into URL var
    NSURL *restURL = [NSURL URLWithString:urlString];
    
    
    //converts key/value pair into request data
    NSData* requestData = [NSJSONSerialization dataWithJSONObject:[[NSDictionary alloc] init] options:0 error:nil];
    
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
        
        //NSLog(response);
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        for (NSString* key in [jsonDict allKeys]) {
            NSLog(@"%@: %@", key, [jsonDict objectForKey:key]);
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MIZGetUserIdFinished" object:nil userInfo:@{@"userId": [jsonDict objectForKey:@"id"]}];
        
        if(error == nil)
        {
            

        }
    }];
    
    //resumes the Datarequest.
    [dataRequest resume];
}

+ (void) loginWithEmail:(NSString*)email withPassword:(NSString*)password
{
        NSString* urlString = @"http://zobelisk-backend.herokuapp.com/users/sign_in.json";
        
        NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        //converts string into URL var
        NSURL *restURL = [NSURL URLWithString:urlString];
        
        //sets key value pair for pawprint
        NSMutableDictionary *paw = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *user = [[NSMutableDictionary alloc] init];
        
        [user setObject:email forKey:@"email"];
        [user setObject:password forKey:@"password"];
        [user setObject:@"0" forKey:@"remember_me"];
        
        [paw setObject:@"✓" forKey:@"utf8"];
        [paw setObject:user forKey:@"user"];
        [paw setObject:@"Sign in" forKey:@"commit"];
    
    
        for(NSString *key in [paw allKeys]) {
            NSLog(@"%@",[paw objectForKey:key]);
        }
        //converts key/value pair into request data
        NSData* requestData = [NSJSONSerialization dataWithJSONObject:paw options:0 error:nil];
        
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
            
            //NSLog(response);
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            for(NSString *key in [jsonDict allKeys]) {
                NSLog(@"%@",[jsonDict objectForKey:key]);
            }
            if(error == nil && [jsonDict objectForKey:@"error"] == nil)
            {
                [[NSUserDefaults standardUserDefaults] setValue:email forKey:@"email"];
            }
        }];
    
        //resumes the Datarequest.
        [dataRequest resume];
        
}
@end
