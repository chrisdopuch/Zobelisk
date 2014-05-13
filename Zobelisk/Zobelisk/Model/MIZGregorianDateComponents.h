//
//  MIZGregorianDateComponents.h
//  Zobelisk
//
//  Created by Seth Wiesman on 4/28/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIZGregorianDateComponents : NSObject

@property NSString* year;
@property NSString* month;
@property NSString* day;
@property NSString* hour;
@property NSString* minute;

- (MIZGregorianDateComponents*) init;
- (MIZGregorianDateComponents*) initWithDate:(NSDate*)timestamp;
- (MIZGregorianDateComponents*) initWithString:(NSString*)timestamp;

@end
