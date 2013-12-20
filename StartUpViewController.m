//
//  StartUpViewController.m
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/3/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import "StartUpViewController.h"
#import <Parse/Parse.h>
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

- (NSArray *) responseData
{
    if (!_responseData){
        _responseData = [[NSArray alloc] init];
    }
    return _responseData;
}

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
    
    [self checkLoginCredentials];
    
    [self.emailEntryField resignFirstResponder];
    
  
}
- (void) startDownloadingUsers
{
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserInformation"];
    [query whereKey:@"name" equalTo:@"test1"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                NSLog(@"%@", object[@"name"]);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    NSURL *url = [NSURL URLWithString:@"https://api.mongolab.com/api/1/databases/queuealpha/collections/Users?apiKey=ao0BI_lXpgTOsoiKy4THrI3Xi-fQycVX"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                      completionHandler:^(NSURL *localFile, NSURLResponse *response, NSError *error) {
                                                          if (!error) {
                                                              NSMutableData *data = [NSMutableData dataWithContentsOfURL:localFile];
                                                              
                                                              NSError *error = nil;
                                                              NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: data
                                                                                                                   options: NSJSONReadingMutableContainers
                                                                                                                     error: &error];
                                                              
//                                                              dispatch_async(dispatch_get_main_queue(), ^{self.responseData = jsonArray;});

                                                              [self performSelectorOnMainThread:@selector(setUserData:) withObject:jsonArray waitUntilDone:NO];
//                                                              [self checkLoginCredentials];
                                                          }
    }];
    
    [task resume];
    
}

- (void) URLSession:(NSURLSession *) session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{

}

- (void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}

- (void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSLog(@"Completed download tasl");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"UserAccountExists"]) {
        NSLog(@"Going to Tables page");
    }
}

- (void) checkLoginCredentials
{
//    NSLog(@"Repsonse data in login credentials is %@", self.responseData);
    for (NSDictionary *item in _userData){
        [[self emails] addObject:[item objectForKey:@"email"]];
        [[self passwords] addObject:[item objectForKey:@"password"]];
    }
    NSLog(@"%@", self.emails);
    NSLog(@"%@", self.passwords);
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
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self startDownloadingUsers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
