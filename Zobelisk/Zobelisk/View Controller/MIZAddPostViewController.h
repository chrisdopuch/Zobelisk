//
//  MIZAddPostViewController.h
//  Zobelisk
//
//  Created by Clifford Green on 4/8/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MIZAddPostViewController;

@protocol MIZAddPostViewControllerDelegate <NSObject>

- (void)MIZAddPostViewControllerDidCancel:(MIZAddPostViewController *)controller;

@end

@interface MIZAddPostViewController : UIViewController

@property (nonatomic, weak) id <MIZAddPostViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;


@end
