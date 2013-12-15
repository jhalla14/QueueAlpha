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

- (void) scrollingCellDidBeginPulling:(ScrollingCell *)cell
{
//    [_outerScrollView setScrollEnabled:NO];
    
}

- (void) scrollingCell:(ScrollingCell *)cell didChangePullOffset:(CGFloat)offset
{
    
}

- (void) scrollingCellDidEndPulling:(ScrollingCell *)cell
{
//    [_outerScrollView setScrollEnabled:YES];
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
    [cell setBackgroundColor:[UIColor blueColor]];
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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
