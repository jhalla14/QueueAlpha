//
//  SignUpViewController.m
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/5/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *affliationTextfield;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) UITextField *activeField;
@end

@implementation SignUpViewController

- (IBAction)createButton:(UIButton *)sender
{
    [self postNewUserToDatabase];
    [self resignFirstResponder];
}

- (void) postNewUserToDatabase
{
    NSURL *url = [NSURL URLWithString:@"https://api.mongolab.com/api/1/databases/queuealpha/collections/Users?apiKey=ao0BI_lXpgTOsoiKy4THrI3Xi-fQycVX"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
//    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
//    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
//    NSError *error = nil;
//    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: _responseData
//                                                         options: NSJSONReadingMutableContainers
//                                                           error: &error];
//    
//    _userData = jsonArray;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL) textFieldShouldReturn:(UITextField *) textField
{
    [self resignFirstResponder];
    return YES;
}

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
