//
//  MIZGregorianDateComponents.m
//  Zobelisk
//
//  Created by Seth Wiesman on 4/28/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZGregorianDateComponents.h"

@implementation MIZGregorianDateComponents

- (MIZGregorianDateComponents*) init
{
    return [self initWithDate: [[NSDate alloc]init]];
}

- (MIZGregorianDateComponents*) initWithDate:(NSDate*)timestamp
{
    MIZGregorianDateComponents* date = [MIZGregorianDateComponents alloc];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:timestamp];

    NSCalendar *gregorianCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComps = [gregorianCal components: (NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate: timestamp];
    
    [date setYear:[NSNumber numberWithInteger:[components year]]];
    [date setMonth:[NSNumber numberWithInteger:[components month]]];
    [date setYear: [NSNumber numberWithInteger:[components day]]];
    [date setHour:[NSNumber numberWithInteger:[dateComps hour]]];
    [date setMinute:[NSNumber numberWithInteger:[dateComps minute]]];
    
    return date;
}

@end
