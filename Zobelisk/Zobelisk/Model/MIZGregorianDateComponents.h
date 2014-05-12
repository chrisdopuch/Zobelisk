//
//  MIZGregorianDateComponents.h
//  Zobelisk
//
//  Created by Seth Wiesman on 4/28/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIZGregorianDateComponents : NSObject

@property NSNumber* year;
@property NSNumber* month;
@property NSNumber* day;
@property NSNumber* hour;
@property NSNumber* minute;

- (MIZGregorianDateComponents*) init;
- (MIZGregorianDateComponents*) initWithDate:(NSDate*)timestamp;
- (MIZGregorianDateComponents*) initWithString:(NSString*)timestamp;

@end
