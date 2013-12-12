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
    //take to the tables page
}

- (void) postNewUserToDatabase
{
    
    NSString *email = @"email";
    NSString *password = @"password";
    
    NSString *emailEntry = self.emailTextField.text;
    NSString *passwordEntry = self.passwordTextField.text;
    
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:passwordEntry, password, emailEntry, email, nil];
    
    NSError *error = nil;
    NSData *beta = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [NSString stringWithUTF8String:beta.bytes];

    NSLog(@"json string is %@",jsonString);

    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    configuration.HTTPAdditionalHeaders = @{@"Content-Type": @"application/json"};
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];

    NSURL *url = [NSURL URLWithString:@"https://api.mongolab.com/api/1/databases/queuealpha/collections/Users?apiKey=ao0BI_lXpgTOsoiKy4THrI3Xi-fQycVX"];

    NSMutableURLRequest *uploadRequest = [NSMutableURLRequest requestWithURL:url];
 
    uploadRequest.HTTPBody = beta;
    uploadRequest.HTTPMethod = @"POST";
    

    NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:uploadRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (!error) {
            NSLog(@"No Error");
        }
        
    }];

    [uploadTask resume];
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
