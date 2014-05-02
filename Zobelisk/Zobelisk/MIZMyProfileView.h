//
//  MIZMyProfileView.h
//  Zobelisk
//
//  Created by Victor Tran on 4/29/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIZMyProfileView : UITableView

@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UILabel *phoneNumber;
@property (nonatomic, weak) IBOutlet UILabel *email;
@property (nonatomic, weak) IBOutlet UILabel *body;


@end
