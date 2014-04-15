//
//  MIZAddPostViewController.m
//  Zobelisk
//
//  Created by Clifford Green on 4/8/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZAddPostViewController.h"

@interface MIZAddPostViewController ()
@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation MIZAddPostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.description.layer.borderColor = [[UIColor grayColor] CGColor];
    self.description.layer.borderWidth = 1.0;
    self.description.layer.cornerRadius = 8;
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.setDate setInputView:self.datePicker];
}

-(void) choosePhotoBtn:(id)sender {
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    //SWITCH SAVED PHOTOS TO CAMERA!!!!!!!!!
    self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:self.picker animated:YES completion:nil];
    
    }
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.selectedImageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender
{
    [self.delegate MIZAddPostViewControllerDidCancel:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:true];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
