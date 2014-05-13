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
    
    [self setYear:[NSString stringWithFormat:@"%d", [components year]]];
    [self setMonth:[NSString stringWithFormat:@"%d", [components month]]];
    [self setDay:[NSString stringWithFormat:@"%d", [components month]]];
    [self setHour:[NSString stringWithFormat:@"%d", [dateComps hour]]];
    [self setMinute:[NSString stringWithFormat:@"%d", [dateComps minute]]];
    
    return self;
}

- (NSString*) numberFromMonth:(NSString*)month
{
    if ([month isEqualToString:@"January"])
        return @"1";
    else if([month isEqualToString:@"February"])
        return @"2";
    else if ([month isEqualToString:@"March"])
        return @"3";
    else if ([month isEqualToString:@"April"])
        return @"4";
    else if ([month isEqualToString:@"May"])
        return @"5";
    else if ([month isEqualToString:@"June"])
        return @"6";
    else if ([month isEqualToString:@"July"])
        return @"7";
    else if ([month isEqualToString:@"August"])
        return @"8";
    else if ([month isEqualToString:@"September"])
        return @"9";
    else if ([month isEqualToString:@"October"])
        return @"10";
    else if ([month isEqualToString:@"November"])
        return @"11";
    else
        return @"12";
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
    
    [self setYear:date[4]];
    [self setMonth: [self numberFromMonth:date[1]]];
    [self setDay: date[2]];
    
    [self setHour: [NSString stringWithFormat:@"%d",[dateComps hour]]];
    [self setMinute:[NSString stringWithFormat:@"%d",[dateComps minute] ]];
    
    return self;
}

@end
