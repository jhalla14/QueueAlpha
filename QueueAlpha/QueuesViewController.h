//
//  QueuesViewController.h
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/5/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollingCell.h"

@interface QueuesViewController : UIViewController<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end
