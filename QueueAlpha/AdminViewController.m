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
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 100, 100)];
    label.text = @"Hello";
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:label];
    
    UITextField *numberOfTables = [[UITextField alloc] initWithFrame:CGRectMake(0, 500, 100, 100)];
    numberOfTables.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:numberOfTables];
    [self.view setNeedsDisplay];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
