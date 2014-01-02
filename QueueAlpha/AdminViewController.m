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
    [maxQueueTextField sizeToFit];
    
    
    [mainView addSubview:tablesRunningLabel];
    [mainView addSubview:numberOfTablesTextField];
    [mainView addSubview:maxQueueLengthLabel];
    [mainView addSubview:maxQueueTextField];
    
    tablesRunningLabel.translatesAutoresizingMaskIntoConstraints = NO;
    numberOfTablesTextField.translatesAutoresizingMaskIntoConstraints = NO;
    maxQueueLengthLabel.translatesAutoresizingMaskIntoConstraints = NO;
    maxQueueTextField.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *vs = NSDictionaryOfVariableBindings(tablesRunningLabel, numberOfTablesTextField, maxQueueLengthLabel, maxQueueTextField);
    
    //Auto Layout Contraints
    [mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[numberOfTablesTextField]-20-|" options:0 metrics:nil views:vs]];
    [mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-75-[tablesRunningLabel]-5-[numberOfTablesTextField]" options:0 metrics:nil views:vs]];
    [mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[tablesRunningLabel]-20-|" options:0 metrics:nil views:vs]];
    [mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[maxQueueLengthLabel]-20-|" options:0 metrics:nil views:vs]];
    [mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[maxQueueTextField]-20-|" options:0 metrics:nil views:vs]];
    [mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[numberOfTablesTextField]-10-[maxQueueLengthLabel]-5-[maxQueueTextField]" options:0 metrics:nil views:vs]];
    
}

@end
