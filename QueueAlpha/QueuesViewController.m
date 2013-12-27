//
//  QueuesViewController.m
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/5/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import "QueuesViewController.h"

@interface QueuesViewController ()
-(UIColor *) randomColor;


@end

@implementation QueuesViewController



-(UIColor *) randomColor {
    CGFloat red =  (CGFloat)arc4random() / (CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)arc4random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)arc4random() / (CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

- (void) editAdminOptions:(id)sender
{
    NSLog(@"Editing admin options");
    UIViewController *AdminViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AdminViewControllerId"];

    [self.navigationController pushViewController: AdminViewController animated:YES];
}

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"AdminOptions"]) {
        NSLog(@"Going to Admin Page");
        return YES;
    }
    return NO;
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
    NSLog(@"Current user is %hhd", _currentUser.admin);
    if (_currentUser.admin) {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        [self.navigationItem.rightBarButtonItem setAction:@selector(editAdminOptions:)];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
