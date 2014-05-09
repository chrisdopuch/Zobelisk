//
//  MIZPocketTableViewCell.h
//  Zobelisk
//
//  Created by Victor Tran on 5/7/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIZPocketTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *email;
@property (nonatomic, weak) IBOutlet UILabel *date;
@property (nonatomic, weak) IBOutlet UILabel *postTitle;
@property (nonatomic, weak) IBOutlet UILabel *body;


@end
