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

@interface MIZAddPostViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) id <MIZAddPostViewControllerDelegate> delegate;
@property (nonatomic, weak) IBOutlet UIImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet UITextView *description;
@property (weak, nonatomic) IBOutlet UITextField *setDate;
@property (weak, nonatomic) IBOutlet UITextField *postTitle;


-(IBAction)choosePhotoBtn:(id)sender;

- (IBAction)cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *expDate;



@end
