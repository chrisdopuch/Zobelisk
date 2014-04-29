//
//  MIZPostFeedCellTableViewCell.h
//  Zobelisk
//
//  Created by Victor Tran on 4/28/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIZPostFeedCellTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *email;
@property (nonatomic, weak) IBOutlet UILabel *date;
@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *body;


@end
