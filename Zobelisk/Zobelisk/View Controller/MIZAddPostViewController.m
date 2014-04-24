//
//  MIZAddPostViewController.m
//  Zobelisk
//
//  Created by Clifford Green on 4/8/14.
//  Copyright (c) 2014 Mizzou IT. All rights reserved.
//

#import "MIZAddPostViewController.h"

@interface MIZAddPostViewController () <UITextViewDelegate>
@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, strong) UIDatePicker *datePicker;


@end


NSDateFormatter *dateFormatter;

NSDate *selectedDate;

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
    [self.datePicker setDate:[NSDate dateWithTimeIntervalSinceNow:0] animated:true ];

    [self.setDate setInputView:self.datePicker];
 
   
    
    [self.datePicker addTarget:self action:@selector(updateLabelFromPicker) forControlEvents:UIControlEventValueChanged];

    _description.delegate = self;
    self.description.text = @"Breifly describe your post...";
    self.description.textColor = [UIColor lightGrayColor];
    

    _selectedImageView.contentMode = UIViewContentModeScaleAspectFit;
}
-(void)updateLabelFromPicker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"EEEE MMMM dd, yyyy"];
    NSString *expirationDate = [formatter stringFromDate:self.datePicker.date];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.expDate.text = expirationDate;
    }];
}
    
- (void)textViewDidBeginEditing:(UITextView *)textView
{

    if ([textView.text isEqualToString:@"Breifly describe your post..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Breifly describe your post...";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([_description isFirstResponder] && [touch view] != _description) {
        [_description resignFirstResponder];
    }
    else if  ([_setDate isFirstResponder] && [touch view] != _setDate) {
        [_setDate resignFirstResponder];
    }
    else if  ([_postTitle isFirstResponder] && [touch view] != _postTitle) {
        [_postTitle resignFirstResponder];
    }
    else if ([_datePicker isSelected] && [touch view]!= _datePicker)
    {
        [_datePicker resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
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
    //Cancel button delegate method
    [self.delegate MIZAddPostViewControllerDidCancel:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //navigates back to last view controller
    [self.navigationController popToRootViewControllerAnimated:true];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
