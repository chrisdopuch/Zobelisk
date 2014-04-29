//
//  MIZPost.h
//  Zobelisk
//
//  Created by Victor Tran on 4/28/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIZPost : UIViewController

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *eventDate;
@property (nonatomic, strong) NSString *media;
@property (nonatomic) NSInteger likes;

@end
