//
//  AdminViewController.m
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/21/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import "AdminViewController.h"
#import <Parse/Parse.h>
#import "QueuesTableViewController.h"

@interface AdminViewController ()

@property(nonatomic, weak) UIView *firstResponder;
@property(nonatomic, weak) UIScrollView *scrollView;

@property(nonatomic, weak) UITextField *numberOfTablesRunning;
@property(nonatomic, weak) UITextField *maxQueueLength;

@property(nonatomic, weak) UIBarButtonItem *saveButton;

@end

@implementation AdminViewController
{
    UIEdgeInsets _oldContentInset;
    UIEdgeInsets _oldIndicatorInset;
    CGPoint _oldOffset;
}

- (void) uploadAdminOptions
{
    PFObject *adminOptions = [PFObject objectWithClassName:@"AdminOptions"];
    
    adminOptions[@"numberOfTablesRunning"] = _numberOfTablesRunning.text;
    adminOptions[@"maxQueueLength"] = _maxQueueLength.text;
    
    [adminOptions saveInBackground];
}

- (IBAction)saveButtonClicked:(id)sender
{
    NSLog(@"Clicked");
    [self uploadAdminOptions];
    [self goToQueuesTableView];
}

- (void) goToQueuesTableView
{
    QueuesTableViewController *queuesVC = [QueuesTableViewController new];
    [self.navigationController pushViewController:queuesVC animated:YES];
}

- (void) loadView
{
    UIView *view = [UIView new];
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *mainView = self.view;
    self.navigationItem.title = @"Admin Options";

    //sign up for Keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //create Save Button in upper right corner
    UIBarButtonItem *submit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonClicked:)];
    [self.navigationItem setRightBarButtonItem:submit];
    _saveButton = submit;
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor darkGrayColor];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [mainView addSubview:scrollView];

    //set the background color
    [mainView setBackgroundColor:[UIColor darkGrayColor]];
    
    //tables running
    UILabel *tablesRunningLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 100, 100)];
    tablesRunningLabel.text = @"Tables Running:";
    tablesRunningLabel.textColor = [UIColor whiteColor];
    
    [tablesRunningLabel sizeToFit];

    CGRect frame = CGRectMake(mainView.bounds.origin.x+20, mainView.bounds.origin.y+150, 0, 0);
    UITextField *numberOfTablesTextField = [[UITextField alloc] initWithFrame:frame];

    numberOfTablesTextField.borderStyle = UITextBorderStyleRoundedRect;
    numberOfTablesTextField.placeholder = @"Number of allowed tables running";
    numberOfTablesTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    numberOfTablesTextField.keyboardType = UIKeyboardTypeNumberPad;
    numberOfTablesTextField.keyboardAppearance = UIKeyboardAppearanceDark;
    [numberOfTablesTextField sizeToFit];
    
    //maximum queue length
    UILabel *maxQueueLengthLabel = [UILabel new];
    maxQueueLengthLabel.text = @"Maximum Queue Length:";
    maxQueueLengthLabel.textColor = [UIColor whiteColor];
    [maxQueueLengthLabel sizeToFit];
    
    UITextField *maxQueueTextField = [UITextField new];
    maxQueueTextField.borderStyle = UITextBorderStyleRoundedRect;
    maxQueueTextField.placeholder =@"Max Line Length";
    maxQueueTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    maxQueueTextField.keyboardType = UIKeyboardTypeNumberPad;
    maxQueueTextField.keyboardAppearance = UIKeyboardAppearanceDark;
    [maxQueueTextField sizeToFit];
    
    //create subview hierarchy
    [scrollView addSubview:tablesRunningLabel];
    [scrollView addSubview:numberOfTablesTextField];
    [scrollView addSubview:maxQueueLengthLabel];
    [scrollView addSubview:maxQueueTextField];
    
    tablesRunningLabel.translatesAutoresizingMaskIntoConstraints = NO;
    numberOfTablesTextField.translatesAutoresizingMaskIntoConstraints = NO;
    maxQueueLengthLabel.translatesAutoresizingMaskIntoConstraints = NO;
    maxQueueTextField.translatesAutoresizingMaskIntoConstraints = NO;
    
    //visual format dictionary for mapping variables to actual views
    NSDictionary *vs = NSDictionaryOfVariableBindings(tablesRunningLabel, numberOfTablesTextField, maxQueueLengthLabel, maxQueueTextField, scrollView);
    
    //Auto Layout Contraints
    scrollView.contentSize = CGSizeMake(mainView.bounds.size.width+10, mainView.bounds.size.height+10); // This is the crucial line
    NSLog(@"%@", scrollView);
    
    [mainView addConstraints:
    [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|" options:0 metrics:nil views:vs]];
    [mainView addConstraints:
    [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:0 metrics:nil views:vs]];
    
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[numberOfTablesTextField]-20-|" options:0 metrics:nil views:vs]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-75-[tablesRunningLabel]-5-[numberOfTablesTextField]" options:0 metrics:nil views:vs]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[tablesRunningLabel]-20-|" options:0 metrics:nil views:vs]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[maxQueueLengthLabel]-20-|" options:0 metrics:nil views:vs]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[maxQueueTextField]-20-|" options:0 metrics:nil views:vs]];
    [scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[numberOfTablesTextField]-10-[maxQueueLengthLabel]-5-[maxQueueTextField]" options:0 metrics:nil views:vs]];
    
    _scrollView = scrollView;
    _numberOfTablesRunning = numberOfTablesTextField;
    _maxQueueLength = maxQueueTextField;
    
}

#pragma mark UITextFieldDelegate Methods

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    self.firstResponder = textField;
}

- (BOOL) textFieldShouldReturn:(UITextField *) textField
{
    [textField resignFirstResponder];
    self.firstResponder = nil;
    return YES;
}

- (void) keyboardShow: (NSNotification*) n
{
    self->_oldContentInset = self.scrollView.contentInset;
    self->_oldIndicatorInset = self.scrollView.scrollIndicatorInsets;
    self->_oldOffset = self.scrollView.contentOffset;
    
    NSDictionary* d = [n userInfo];
    CGRect r = [[d objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    r = [self.scrollView convertRect:r fromView:nil];
    CGRect f = self.firstResponder.frame;
    CGFloat y =
    CGRectGetMaxY(f) + r.size.height -
    self.scrollView.bounds.size.height + 5;
    if (r.origin.y < CGRectGetMaxY(f)) {
        NSNumber* duration = d[UIKeyboardAnimationDurationUserInfoKey];
        NSNumber* curve = d[UIKeyboardAnimationCurveUserInfoKey];
        [UIView animateWithDuration:duration.floatValue
                              delay:0
                            options:curve.integerValue << 16
                         animations:^{
                             CGRect b = self.scrollView.bounds;
                             b.origin = CGPointMake(0, y);
                             self.scrollView.bounds = b;
                         } completion: nil];
    }
    UIEdgeInsets insets = self.scrollView.contentInset;
    insets.bottom = r.size.height;
    self.scrollView.contentInset = insets;
    insets = self.scrollView.scrollIndicatorInsets;
    insets.bottom = r.size.height;
    self.scrollView.scrollIndicatorInsets = insets;
}

- (void) keyboardHide: (NSNotification*) n {
    NSNumber* duration = n.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSNumber* curve = n.userInfo[UIKeyboardAnimationCurveUserInfoKey];
    [UIView animateWithDuration:duration.floatValue
                          delay:0
                        options:curve.integerValue << 16
                     animations:^{
                         CGRect b = self.scrollView.bounds;
                         b.origin = self->_oldOffset;
                         self.scrollView.bounds = b;
                         self.scrollView.scrollIndicatorInsets = self->_oldIndicatorInset;
                         self.scrollView.contentInset = self->_oldContentInset;
                         
                     } completion:nil];
}


@end
