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

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UITextField *activeField;

@property (strong, nonatomic) NSArray *userData;

@property (strong, nonatomic) NSMutableArray *emails;
@property (strong, nonatomic) NSMutableArray *passwords;


@end

@implementation StartUpViewController

- (NSMutableArray *)emails
{
    if (!_emails) {
        _emails = [[NSMutableArray alloc] init];
    }
    return _emails;
}

- (NSMutableArray *)passwords
{
    if (!_passwords) {
        _passwords = [[NSMutableArray alloc] init];
    }
    return _passwords;
}

- (void) setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    self.scrollView.contentSize = CGSizeZero;
}


- (NSArray *) userData
{
    if (!_userData) {
        _userData = [[NSArray alloc] init];
    }
    return _userData;
}

- (IBAction)loginButton:(UIButton *)sender
{
    
    [self startDownloadingUsers];
    
    [self.emailEntryField resignFirstResponder];
  
}
- (void) startDownloadingUsers
{
    NSURL *url = [NSURL URLWithString:@"https://api.mongolab.com/api/1/databases/queuealpha/collections/Users?apiKey=ao0BI_lXpgTOsoiKy4THrI3Xi-fQycVX"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
//    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error) {
//        if (!error) {
//            
//        }
//    }];
//    [task resume];
    
    [connection start];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"UserAccountExists"]) {
        NSLog(@"Going to Tables page");
    }
}

- (void) checkLoginCredentials
{
    for (NSDictionary *item in _userData){
        [[self emails] addObject:[item objectForKey:@"email"]];
        [[self passwords] addObject:[item objectForKey:@"password"]];
    }
}

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
    NSString *email = [self.emailEntryField text];
    NSString *password = [self.passwordEntryField text];
    
    if ([identifier isEqualToString:@"UserAccountExists"]) {
        for (NSString *emailString in [self emails]){
            if ([emailString isEqualToString:email]){
                for (NSString *passwordString in [self passwords]){
                    if ([passwordString isEqualToString:password]) {
                        
                        return YES;
                    }
                }
            }
        }
        
    } else if ([identifier isEqualToString:@"SignUp"]){
        return YES;
    }
    return NO;
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
    
    _userData = jsonArray;
    
    [self checkLoginCredentials];
    
//    if (!jsonArray) {
//        NSLog(@"Error parsing JSON: %@", error);
//    } else {
//        for(NSDictionary *item in jsonArray) {
//            NSLog(@" %@", item);
//            NSLog(@"---------------------------------");
//        }
//    }

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    _activeField = textField;
    
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    _activeField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, _activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:_activeField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
}


- (IBAction)signUpButton:(UIButton *)sender
{
    [self.passwordEntryField resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self registerForKeyboardNotifications];
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
