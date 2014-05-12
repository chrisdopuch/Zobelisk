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
    return [[MIZGregorianDateComponents alloc] initWithDate: [[NSDate alloc]init]];
}

- (MIZGregorianDateComponents*) initWithDate:(NSDate*)timestamp
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:timestamp];

    NSCalendar *gregorianCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComps = [gregorianCal components: (NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate: timestamp];
    
    [self setYear:[NSNumber numberWithInteger:[components year]]];
    [self setMonth:[NSNumber numberWithInteger:[components month]]];
    [self setDay: [NSNumber numberWithInteger:[components day]]];
    [self setHour:[NSNumber numberWithInteger:[dateComps hour]]];
    [self setMinute:[NSNumber numberWithInteger:[dateComps minute]]];
    
    return self;
}

- (NSNumber*) numberFromMonth:(NSString*)month
{
    if ([month isEqualToString:@"January"])
        return [NSNumber numberWithInt:1];
    else if([month isEqualToString:@"February"])
        return [NSNumber numberWithInt:2];
    else if ([month isEqualToString:@"March"])
        return [NSNumber numberWithInt:3];
    else if ([month isEqualToString:@"April"])
        return [NSNumber numberWithInt:4];
    else if ([month isEqualToString:@"May"])
        return [NSNumber numberWithInt:5];
    else if ([month isEqualToString:@"June"])
        return [NSNumber numberWithInt:6];
    else if ([month isEqualToString:@"July"])
        return [NSNumber numberWithInt:7];
    else if ([month isEqualToString:@"August"])
        return [NSNumber numberWithInt:8];
    else if ([month isEqualToString:@"September"])
        return [NSNumber numberWithInt:9];
    else if ([month isEqualToString:@"October"])
        return [NSNumber numberWithInt:10];
    else if ([month isEqualToString:@"November"])
        return [NSNumber numberWithInt:11];
    else
        return [NSNumber numberWithInt:12];
}

- (MIZGregorianDateComponents*) initWithString:(NSString*)timestamp
{
    //NSCalendar* calendar = [NSCalendar currentCalendar];
    //NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:timestamp];
    
    NSCalendar *gregorianCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComps = [gregorianCal components: (NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate: [[NSDate alloc] init]];
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSArray* date = [timestamp componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" ,\n"]];
    
    [self setYear:[formatter numberFromString:date[4]]];
    [self setMonth: [self numberFromMonth:date[1]]];
    [self setDay: [formatter numberFromString:date[2]]];
    
    [self setHour:[NSNumber numberWithInteger:[dateComps hour]]];
    [self setMinute:[NSNumber numberWithInteger:[dateComps minute]]];
    
    return self;
}

@end
