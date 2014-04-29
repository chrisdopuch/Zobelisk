//
//  MIZGregorianDateComponents.m
//  Zobelisk
//
//  Created by Seth Wiesman on 4/28/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZGregorianDateComponents.h"

@implementation MIZGregorianDateComponents

+ (NSNumber*) getYear
{
    NSDate* currentDate = [[NSDate alloc] init];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate];
    NSNumber* year = [NSNumber numberWithInt:[components year]];
    return year;
}
+ (NSNumber*) getMonth
{
    NSDate* currentDate = [[NSDate alloc] init];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate];
    NSNumber* month = [NSNumber numberWithInt:[components month]];
    return month;
}
+ (NSNumber*) getDay
{
    NSDate* currentDate = [[NSDate alloc] init];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate];
    NSNumber* day = [NSNumber numberWithInt:[components day]];
    return day;
}

+ (NSNumber*) getHour
{
    NSDate *date = [[NSDate alloc] init];
    // Assume you have a 'date'
    NSCalendar *gregorianCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComps = [gregorianCal components: (NSHourCalendarUnit | NSMinuteCalendarUnit)
                                                  fromDate: date];
    // Then use it
    return [NSNumber numberWithInteger:[dateComps hour]];
}

+ (NSNumber*) getMinute
{
    NSDate *date = [[NSDate alloc] init];
    // Assume you have a 'date'
    NSCalendar *gregorianCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComps = [gregorianCal components: (NSHourCalendarUnit | NSMinuteCalendarUnit)
                                                  fromDate: date];
    // Then use it
    return [NSNumber numberWithInteger:[dateComps minute]];
}

@end
