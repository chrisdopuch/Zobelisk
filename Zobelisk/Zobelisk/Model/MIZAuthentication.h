//
//  MIZAuthentication.h
//  Zobelisk
//
//  Created by Seth Wiesman on 4/23/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIZAuthentication : NSObject

+ (void) registerEmail:(NSString*)email withPassword:(NSString*)password confirmationPassword:(NSString*)password_confirmation firstName:(NSString*)fName lastName:(NSString*)lname dateOfBirth:(NSDate*)dob address:(NSString*)loc twitter:(NSString*)twiterHandle andPhonenumber:(NSString*)number;

+ (void) registerEmail:(NSString*)email withPassword:(NSString*)password andConfirmationPassword:(NSString*)password_confirmation;

//+ (void) loginWithEmail:(NSString*)email withPassword:(NSString*)password;

- (BOOL) verifyLogin;
@end
