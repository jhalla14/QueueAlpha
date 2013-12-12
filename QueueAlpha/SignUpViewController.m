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

@property (strong, nonatomic) NSURLConnection *URLconnection;
@end

@implementation SignUpViewController

- (IBAction)createButton:(UIButton *)sender
{
    [self postNewUserToDatabase];
    [self resignFirstResponder];
}

- (void) postNewUserToDatabase
{
    
    [self retrieveNewUserInfo];
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    NSMutableData *data = [NSMutableData dataWithContentsOfFile:email];
    [data appendData:[NSMutableData dataWithContentsOfFile:password]];
    
    BOOL test = [NSJSONSerialization isValidJSONObject:data];
    NSLog(@"Test is %hhd",test);
    
    NSError *error = nil;
//    NSJSONSerialization *json
    
//    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: data
//                                                         options: NSJSONReadingMutableContainers
//                                                           error: &error];
//    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
//
//    NSURL *url = [NSURL URLWithString:@"https://api.mongolab.com/api/1/databases/queuealpha/collections/Users?apiKey=ao0BI_lXpgTOsoiKy4THrI3Xi-fQycVX"];
//    
//    NSURLRequest *uploadRequest = [NSURLRequest requestWithURL:url];
//    
//    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:uploadRequest fromData:data ];
//    
//    [uploadTask resume];
    
    
//
////    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    
////    [request setHTTPPMethod: @"POST"];
//    
//    
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void) retrieveNewUserInfo
{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSString *username = @"username";
    NSString *password = @"password";
    
    NSURLCredential *credential = [NSURLCredential credentialWithUser:username
                                                             password:password
                                                          persistence:NSURLCredentialPersistenceForSession];
    [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    _activeField = textField;
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    _activeField = nil;
}

- (BOOL) textFieldShouldReturn:(UITextField *) textField
{
    [textField resignFirstResponder];
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
