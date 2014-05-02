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
    [MIZAuthentication updateUser:user];
    
}

+ (void)updateUser:(NSMutableDictionary*)userProfile
{
    {
        NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        
        //converts url into a string
        NSString* urlString = @"http://zobelisk-backend.herokuapp.com/users.json";
        
        //converts string into URL var
        NSURL *restURL = [NSURL URLWithString:urlString];
        
        NSMutableDictionary *form = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *user = [[NSMutableDictionary alloc] init];
        
        [user setObject:[userProfile objectForKey:@"email"] forKey:@"email"];
        [user setObject:[userProfile objectForKey:@"password"] forKey:@"current_password"];
        [user setObject:[userProfile objectForKey:@"first name"] forKey:@"first_name"];
        [user setObject:[userProfile objectForKey:@"last name"] forKey:@"last_name"];
        [user setObject:[userProfile objectForKey:@"address"] forKey:@"address"];
        [user setObject:[userProfile objectForKey:@"twitter"] forKey:@"twitter"];
        
        [form setObject:@"✓" forKey:@"utf8"];
        [form setObject:userProfile forKey:@"user"];
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
            
            
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                    
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

- (BOOL) verifyLogin{
    NSString *storedEmail = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    if(storedEmail != nil){
        NSLog(@"%@", storedEmail);
        storedEmail = nil;
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
/*+ (void) loginWithEmail:(NSString*)email withPassword:(NSString*)password
{
    //NSString* urlString = @"http://zobelisk-backend.herokuapp.com/users/sign_in";
}
*/
@end
