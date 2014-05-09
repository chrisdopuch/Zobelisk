//
//  MIZAuthentication.h
//  Zobelisk
//
//  Created by Seth Wiesman on 4/23/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIZAuthentication : NSObject

+ (void) registerUser:(NSMutableDictionary*)user;

+ (void) registerEmail:(NSString*)email withPassword:(NSString*)password andConfirmationPassword:(NSString*)password_confirmation;

+ (void) loginWithEmail:(NSString*)email withPassword:(NSString*)password;

- (BOOL) verifyLogin;
@end
