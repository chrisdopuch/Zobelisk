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

    self.description.delegate = self;
    self.description.text = @"Breifly describe your post...";
    self.description.textColor = [UIColor lightGrayColor];
    
    
    dateFormatter = [[NSDateFormatter alloc] init];
    
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker setHidden:NO];
    [self.datePicker setDate:[NSDate date]];
    [self.datePicker setMinimumDate: [NSDate date]]; //no.4
   // [self.datePicker addTarget:self action:@selector(selectedDate) forControlEvents:UIControlEventValueChanged]; //no.2
    //scale image
    self.selectedImageView.contentMode = UIViewContentModeScaleAspectFit;
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
    if ([self.description isFirstResponder] && [touch view] != self.description) {
        [self.description resignFirstResponder];
    }
    else if  ([self.setDate isFirstResponder] && [touch view] != self.setDate) {
        [_setDate resignFirstResponder];
    }
    else if  ([self.postTitle isFirstResponder] && [touch view] != self.postTitle) {
        [self.postTitle resignFirstResponder];
    }
    else if ([self.datePicker isSelected] && [touch view]!= self.datePicker)
    {
        [self.datePicker resignFirstResponder];
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
