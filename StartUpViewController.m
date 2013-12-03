//
//  StartUpViewController.m
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/3/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import "StartUpViewController.h"

@interface StartUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailEntryField;
@property (weak, nonatomic) IBOutlet UITextField *passwordEntryField;

@end

@implementation StartUpViewController
- (IBAction)loginButton:(UIButton *)sender
{
    [self.emailEntryField resignFirstResponder];
    NSString *email = [self.emailEntryField text];
    
    NSURLConnection *mongo = [[NSURLConnection alloc] initWithRequest:@"https://api.mongolab.com/api/1/databases?apiKey=ao0BI_lXpgTOsoiKy4THrI3Xi-fQycVX" delegate:self];
    
}

- (IBAction)signUpButton:(UIButton *)sender
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
