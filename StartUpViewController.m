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
    NSString *password = [self.passwordEntryField text];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.mongolab.com/api/1/databases/queuealpha/collections?apiKey=ao0BI_lXpgTOsoiKy4THrI3Xi-fQycVX"]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    NSError *error = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: _responseData
                                                         options: NSJSONReadingMutableContainers
                                                           error: &error];
    
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", error);
    } else {
        for(NSDictionary *item in jsonArray) {
            NSLog(@" %@", item);
            NSLog(@"---------------------------------");
        }
    }

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    
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
