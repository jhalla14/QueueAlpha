//
//  StartUpViewController.m
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/3/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import "StartUpViewController.h"
#import <Parse/Parse.h>
#import "User.h"
#import "QueuesViewController.h"
@interface StartUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailEntryField;
@property (weak, nonatomic) IBOutlet UITextField *passwordEntryField;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UITextField *activeField;

@property (strong, nonatomic) NSArray *userData;

@property (strong, nonatomic) User *user;


@end

@implementation StartUpViewController
{
    BOOL loginCredentialsAlreadyExist;
}

- (void) setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    self.scrollView.contentSize = CGSizeZero;
}

- (User *) user
{
    if (!_user) {
        _user = [[User alloc] init];
    }
    return _user;
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
    [query whereKey:@"name" notEqualTo:@""];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
//            for (PFObject *object in objects) {
//                NSLog(@"%@", object.objectId);
//                NSLog(@"%@", object[@"name"]);
//            }
            
            [self performSelectorOnMainThread:@selector(setUserData:) withObject:objects waitUntilDone:NO];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}


- (void) checkLoginCredentials
{

    NSLog(@"%@",_userData);
    for (PFObject *user in _userData){
        
        NSString *email = user[@"email"];
        NSString *firstName = user[@"firstName"];
        NSString *lastName = user[@"lastName"];
        NSString *password = user[@"password"];
        int isAdmin = (int)user[@"admin"];
        NSLog(@"Admin boolean is %d", isAdmin);

        if ([email isEqualToString:self.emailEntryField.text]) {
            if ([password isEqualToString:self.passwordEntryField.text]) {
                self.user.email = email;
                self.user.firstName = firstName;
                self.user.lastName = lastName;
                self.user.password = password;
                
                if (isAdmin == 40616784) {
                    NSLog(@"Email of admin is %@",self.emailEntryField.text);
                    self.user.admin = YES;
                }

                loginCredentialsAlreadyExist = YES;
                NSLog(@"User exists in database");
            }
        }
    }
}

#pragma mark Segue Options

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"UserAccountExists"]) {
        NSLog(@"Going to Queues View page");
        if ([segue.destinationViewController isKindOfClass:[QueuesViewController class]]) {
            QueuesViewController *queuesViewController = (QueuesViewController *) segue.destinationViewController;
            queuesViewController.currentUser = [self user];
        }
    }
}

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"UserAccountExists"]) {
        if (loginCredentialsAlreadyExist) {
            return YES;
        }
        
    } else if ([identifier isEqualToString:@"SignUp"]){
        return YES;
    }
    return NO;
}

#pragma mark TextField Delegate Methods

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

#pragma mark ViewController Lifecycle Methods

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
