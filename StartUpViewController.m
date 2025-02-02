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
#import "QueuesTableViewController.h"
#import "AdminViewController.h"
@interface StartUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailEntryField;
@property (weak, nonatomic) IBOutlet UITextField *passwordEntryField;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UITextField *activeField;

@property (strong, nonatomic) NSArray *userData;

@property (strong, nonatomic) User *user;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet FBLoginView *loginButtonTouch;

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
    [self.emailEntryField resignFirstResponder];
    [self checkLoginCredentials];
}

- (IBAction)loginButtonTouchHandler:(id)sender  {
    NSLog(@"login button");
    
    // The permissions requested from the user
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
//            [self.navigationController pushViewController:[[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
        } else {
            NSLog(@"User with facebook logged in!");
//            [self.navigationController pushViewController:[[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
        }
    }];
}

- (void) startDownloadingUsers
{

    PFQuery *query = [PFQuery queryWithClassName:@"UserInformation"];
    [query whereKey:@"name" notEqualTo:@""];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            [self performSelectorOnMainThread:@selector(setUserData:) withObject:objects waitUntilDone:NO];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}


- (void) checkLoginCredentials
{

//   NSLog(@"%@",_userData);
    for (PFObject *user in _userData){
        
        NSString *email = user[@"email"];
        NSString *firstName = user[@"firstName"];
        NSString *lastName = user[@"lastName"];
        NSString *password = user[@"password"];
        BOOL isAdmin = [user[@"admin"] boolValue];
//        int isAdmin = (int)user[@"admin"];
        NSLog(@"isAdmin variable %hhd", isAdmin);
        
        if ([email isEqualToString:self.emailEntryField.text]) {
            if ([password isEqualToString:self.passwordEntryField.text]) {
                self.user.email = email;
                self.user.firstName = firstName;
                self.user.lastName = lastName;
                self.user.password = password;
                
                if (isAdmin) {
                    self.user.admin = YES;
                }

                loginCredentialsAlreadyExist = YES;
                NSLog(@"User exists in database");
            }
        }
    }
    if (loginCredentialsAlreadyExist == NO) {
        UIAlertView *deniedAlert = [[UIAlertView alloc] initWithTitle: @"Try again" message:@"Incorrect email / password combination" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [deniedAlert show];
    }
    
    if (self.user.isAdmin) {
        //create UIAlertView
        UIAlertView *alert = [[[UIAlertView alloc] init]initWithTitle:@"Admin Rights Detected" message:@"Would you like to edit table options?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:nil];
        
        [alert addButtonWithTitle:@"YES"];
        [alert setTag:1];
        [alert show];
    }

}


#pragma mark Segue Options

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"UserAccountExists"]) {
        NSLog(@"Going to Queues View page");

//        if ([segue.destinationViewController isKindOfClass:[QueuesViewController class]]) {
//            QueuesViewController *queuesViewController = (QueuesViewController *) segue.destinationViewController;
//            queuesViewController.currentUser = [self user];
//        }
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

#pragma mark UIAlertView Delegate Methods

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Alert view clicked %d", buttonIndex);
    
    //load the admin editing page
    if (alertView.tag == 1 &&buttonIndex == 1) {
        NSLog(@"ADMIN RIGHTS DETECTED");
        AdminViewController *adminVC = [[AdminViewController alloc] init];
        [self.navigationController pushViewController:adminVC animated:YES];
    } else if (buttonIndex == 0){
        QueuesTableViewController *queuesTablesVC = [[QueuesTableViewController alloc] init];
        [self.navigationController pushViewController:queuesTablesVC animated:YES];
    }

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
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 100);
    [self.view addSubview:loginView];
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    [self startDownloadingUsers];
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


@end
