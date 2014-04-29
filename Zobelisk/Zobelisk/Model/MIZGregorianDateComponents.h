//
//  MIZGregorianDateComponents.h
//  Zobelisk
//
//  Created by Seth Wiesman on 4/28/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIZGregorianDateComponents : NSObject

+ (NSNumber*) getYear;
+ (NSNumber*) getMonth;
+ (NSNumber*) getDay;
+ (NSNumber*) getHour;
+ (NSNumber*) getMinute;

@end
