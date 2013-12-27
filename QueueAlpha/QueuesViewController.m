//
//  QueuesViewController.m
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/5/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import "QueuesViewController.h"

@interface QueuesViewController () <ScrollingCellDelegate>
-(UIColor *) randomColor;


@end

@implementation QueuesViewController

#pragma mark ScrollingCellDelegate

- (void) scrollingCellDidBeginPulling:(ScrollingCell *) cell
{
//    NSLog(@"began pulling");
    [self.scrollView setScrollEnabled:NO];
}

- (void) scrollingCell:(ScrollingCell *)cell didChangePullOffset:(CGFloat)offset
{
   [self.scrollView setContentOffset:CGPointMake(offset, 0)];
//    NSLog(@"pull offset");
}

- (void) scrollingCellDidEndPulling:(ScrollingCell *)cell
{
//     NSLog(@"ended pulling");
    [self.scrollView setScrollEnabled:YES];
   
}


#pragma mark UICollectionViewDataSource

-(NSInteger) collectionView:(UICollectionView *) cv numberOfItemsInSection:(NSInteger)section
{
    //need to make an NSURL session for requesting the number of tables / cells to create
    return 80;
}


- (UICollectionViewCell *) collectionView: (UICollectionView *) cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"creating scrolling cells");
    ScrollingCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
//    CGFloat red = (CGFloat)arc4random() / (CGFloat)RAND_MAX;
//    CGFloat green = (CGFloat)arc4random() / (CGFloat)RAND_MAX;
//    CGFloat blue = (CGFloat)arc4random() / (CGFloat)RAND_MAX;

    [cell setBackgroundColor:[self randomColor]];
    cell.delegate = self;
    NSLog(@"%ld", (long)indexPath.item);
    cell.tableLabel.text = [NSString stringWithFormat:@"Table %ld",(long)indexPath.item];

    return cell;
}

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
