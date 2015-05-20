//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Ray Lin on 5/4/15.
//  Copyright (c) 2015 BananaFoundation. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRDateChangeViewController.h"
#import "BNRImageStore.h"
#import "BNRItemsStore.h"
#import "BNRAssetTypeViewController.h"
#import "AppDelegate.h"

@interface BNRDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;

@property (strong, nonatomic)UIPopoverController* imagePickerPopover;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (weak, nonatomic) IBOutlet UILabel* nameLabel;
@property (weak, nonatomic) IBOutlet UILabel* serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel* valueLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *assetTypeButton;

@end

@implementation BNRDetailViewController

-(void)encodeRestorableStateWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.item.itemKey forKey:@"item.itemKey"];
    
    self.item.itemName = self.nameField.text;
    self.item.serialNumber = self.serialNumberField.text;
    self.item.valueInDollars = [self.valueField.text intValue];
    
    [[BNRItemsStore sharedStore]saveChanges];
    
    [super encodeRestorableStateWithCoder:coder];
}
-(void)decodeRestorableStateWithCoder:(NSCoder *)coder{
    NSString* itemKey = [coder decodeObjectForKey:@"item.itemKey"];
    for (BNRItem* item in [[BNRItemsStore sharedStore]allItems]) {
        if ([itemKey isEqualToString:item.itemKey]) {
            self.item = item;
            break;
        }
    }
    [super decodeRestorableStateWithCoder:coder];
}

+(UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder{
    BOOL isNew = NO;
    if ([identifierComponents count]==3) {
        isNew = YES;
    }
    
    return [[self alloc]initForNewItem:isNew];
}

- (IBAction)showAssetTypePicker:(id)sender {
    BNRAssetTypeViewController *avc = [[BNRAssetTypeViewController alloc]init];
    avc.item = self.item;
    [self.navigationController pushViewController:avc animated:YES];
}

-(void)updateFonts{
    UIFont* font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.nameLabel.font = font;
    self.serialNumberLabel.font = font;
    self.valueLabel.font = font;
    self.dateLabel.font = font;
    
    self.nameField.font = font;
    self.serialNumberField.font = font;
    self.valueField.font = font;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    @throw [NSException exceptionWithName:@"wrong initializer" reason:@"use initForNewItem" userInfo:nil];
    return nil;
}

-(void)save:(id)sender{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

-(void)cancel:(id)sender{
    [[BNRItemsStore sharedStore]removeItem:self.item];
    [self dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

-(instancetype)initForNewItem:(BOOL)isNew{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.restorationIdentifier = NSStringFromClass([self class]);
        self.restorationClass = [self class];
        
        if (isNew) {
            UIBarButtonItem* doneItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            UIBarButtonItem * cancelItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self selector:@selector(updateFonts) name:UIContentSizeCategoryDidChangeNotification object:nil];
    }
    return self;
}
-(void)dealloc{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
}

-(void)prepareViewsForOrientation:(UIInterfaceOrientation)orientation{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return;
    }
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        self.imageView.hidden = YES;
        self.cameraButton.enabled = NO;
    }else{
        self.imageView.hidden = NO;
        self.cameraButton.enabled = YES;
    }
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    NSLog(@"user dismissed popover");
    self.imagePickerPopover = nil;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [self prepareViewsForSize:size];
}

- (void)prepareViewsForSize:(CGSize)size
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return;
    }
    
    if (size.width > size.height) {
        self.imageView.hidden = YES;
        self.cameraButton.enabled = NO;
    } else {
        self.imageView.hidden = NO;
        self.cameraButton.enabled = YES;
    }
}

- (IBAction)takePicture:(id)sender {
    
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    //[self presentViewController:imagePicker animated:YES completion:nil];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        self.imagePickerPopover = [[UIPopoverController alloc]initWithContentViewController:imagePicker];
        self.imagePickerPopover.delegate = self;
        [self.imagePickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }else{
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage* image = info[UIImagePickerControllerOriginalImage];
    
    [self.item setThumbnailFromImage:image];
    
    [[BNRImageStore sharedStore]setImage:image forKey:self.item.itemKey];
    
    self.imageView.image = image;
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.imagePickerPopover) {
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover = nil;
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)setItem:(BNRItem *)item{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIImageView *iv = [[UIImageView alloc]initWithImage:nil];
//    iv.contentMode = UIViewContentModeScaleAspectFit;
//    iv.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:iv];
    
//    [self.imageView setContentHuggingPriority:200 forAxis:UILayoutConstraintAxisVertical];
//    [self.imageView setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisVertical];
//    
//    NSDictionary *nameMap = @{@"imageView": self.imageView, @"toolbar": self.toolbar, @"dateLabel": self.dateLabel};
//    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|" options:0 metrics:nil views:nameMap];
//    NSArray * verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[dateLabel]-[imageView]-[toolbar]" options:0 metrics:nil views:nameMap];
//    [self.view addConstraints:horizontalConstraints];
//    [self.view addConstraints:verticalConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeDate:(id)sender {
    BNRDateChangeViewController* dcvc = [[BNRDateChangeViewController alloc]init];
    dcvc.item = self.item;
    
    [self.navigationController pushViewController:dcvc animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
    BNRItem* item = self.item;
    
    
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    
    int newValue = [self.valueField.text intValue];
    if (newValue != item.valueInDollars) {
        item.valueInDollars = newValue;
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:newValue forKey:BNRNextItemValuePrefsKey];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self prepareViewsForSize:self.view.frame.size];
    
    BNRItem* item = self.item;
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateIntervalFormatterNoStyle;
    }
    
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    NSString* imageKey = self.item.itemKey;
    
    UIImage* imageToDisplay = [[BNRImageStore sharedStore]imageForKey:imageKey];
    
    self.imageView.image = imageToDisplay;
    
    NSString* typeLabel = [self.item.assetType valueForKey:@"label"];
    if (!typeLabel) {
        typeLabel = @"None";
    }
    self.assetTypeButton.title = [NSString stringWithFormat:@"Type: %@", typeLabel];
    
    
    [self updateFonts];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
