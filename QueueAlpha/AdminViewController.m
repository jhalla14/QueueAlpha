//
//  AdminViewController.m
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/21/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import "AdminViewController.h"

@interface AdminViewController ()

@end

@implementation AdminViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    [mainView setBackgroundColor:[UIColor grayColor]];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 100, 100)];
    label.text = @"Hello";
    label.textColor = [UIColor whiteColor];
    
    [label sizeToFit];
    
    
    
    
    CGRect frame = CGRectMake(mainView.bounds.origin.x+20, mainView.bounds.origin.y+150, 0, 0);
    
    UITextField *numberOfTablesTextField = [[UITextField alloc] initWithFrame:frame];

    numberOfTablesTextField.borderStyle = UITextBorderStyleRoundedRect;
    numberOfTablesTextField.placeholder = @"Number of allowed tables running";
    numberOfTablesTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [numberOfTablesTextField sizeToFit];
    
    [mainView addSubview:label];
    [mainView addSubview:numberOfTablesTextField];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    numberOfTablesTextField.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *vs = NSDictionaryOfVariableBindings(label, numberOfTablesTextField);
    
    [mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label]|" options:0 metrics:nil views:vs]];
    [mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[numberOfTablesTextField]-20-|" options:0 metrics:nil views:vs]];
    [mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-75-[label]-20-[numberOfTablesTextField]" options:0 metrics:nil views:vs]];

}

@end
