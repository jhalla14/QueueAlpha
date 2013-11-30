//
//  FirstViewController.m
//  QueueAlpha
//
//  Created by Joshua Hall  on 11/28/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)touchTestButton:(UIButton *)sender
{
    
    if ([[sender.currentTitle description]  isEqual: @"Test"] ){
        [sender setTitle:@"Yup" forState:UIControlStateNormal];
    } else {
        [sender setTitle:@"Test" forState:UIControlStateNormal];
 
    }
}

@end
