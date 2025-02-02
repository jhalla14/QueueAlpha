//
//  ScrollingCell.h
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/12/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollingCellDelegate;

@interface ScrollingCell : UICollectionViewCell<UIScrollViewDelegate>

@property (strong, nonatomic) UIColor *color;
@property (weak, nonatomic) id<ScrollingCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *tableLabel;

@end

@protocol ScrollingCellDelegate <NSObject>
- (void) scrollingCellDidBeginPulling:(ScrollingCell *) cell;
- (void) scrollingCell:(ScrollingCell *) cell didChangePullOffset:(CGFloat) offset;
- (void) scrollingCellDidEndPulling:(ScrollingCell *) cell;
@end

