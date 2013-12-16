//
//  QueuesViewController.m
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/5/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import "QueuesViewController.h"

@interface QueuesViewController () <ScrollingCellDelegate>

@end

@implementation QueuesViewController

#pragma mark ScrollingCellDelegate

- (void) scrollingCellDidBeginPulling:(ScrollingCell *) cell
{
    NSLog(@"began pulling");
    [self.scrollView setScrollEnabled:NO];
}

//- (void) scrollingCellDidBeginPulling:(ScrollingCell *)cell
//{
////    [self.scrollView setScrollEnabled:NO];
//    NSLog(@"began pulling");
//}

- (void) scrollingCell:(ScrollingCell *)cell didChangePullOffset:(CGFloat)offset
{
   [self.scrollView setContentOffset:CGPointMake(offset, 0)];
    NSLog(@"pull offset");
}

- (void) scrollingCellDidEndPulling:(ScrollingCell *)cell
{
     NSLog(@"ended pulling");
    [self.scrollView setScrollEnabled:YES];
   
}


#pragma mark UICollectionViewDataSource

-(NSInteger) collectionView:(UICollectionView *) cv numberOfItemsInSection:(NSInteger)section
{
    return 80;
}

- (UICollectionViewCell *) collectionView: (UICollectionView *) cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"creating scrolling cells");
    ScrollingCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
//    cell.color = [UIColor greenColor];
    CGFloat red = (CGFloat)arc4random() / (CGFloat)RAND_MAX;;
    CGFloat green = (CGFloat)arc4random() / (CGFloat)RAND_MAX;;
    CGFloat blue = (CGFloat)arc4random() / (CGFloat)RAND_MAX;;
//    cell.color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    [cell setBackgroundColor:[UIColor colorWithRed:red green:green blue:blue alpha:1.0f]];
    cell.delegate = self;
    
    return cell;
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
//    [self.collectionView registerClass:[ScrollingCell class] forCellWithReuseIdentifier:@"cell"];
//    self.scrollView.contentSize = CGSizeMake(2 * self.view.frame.size.width, self.view.frame.size.height);
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
