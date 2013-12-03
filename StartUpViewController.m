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
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.mongolab.com/api/1/databases?apiKey=ao0BI_lXpgTOsoiKy4THrI3Xi-fQycVX"]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(data.description);
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
