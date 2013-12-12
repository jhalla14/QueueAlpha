//
//  ScrollingCell.m
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/12/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import "ScrollingCell.h"
#define PULL_THRESHOLD 60
@implementation ScrollingCell
{
    UIScrollView *_scrollView;
    UIView *_colorView;
    
    BOOL _pulling;
}

#pragma mark UIScrollViewDelegate

- (void) scrollViewDidScroll:(UIScrollView *) scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    
    if (offset > PULL_THRESHOLD && !_pulling){
        [_delegate scrollingCellDidBeginPulling:self];
        _pulling = YES;
    }
    
    if (_pulling) {
        CGFloat pullOffset = MAX(0,offset - PULL_THRESHOLD);
        
        [_delegate scrollingCell:self didChangePullOffset:pullOffset];
    }
}

- (void) scrollingEnded
{
    [_delegate scrollingCellDidEndPulling:self];
    _pulling = NO;
}

- (void) scrollViewDidEndDragging:(UIScrollView *) scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollingEnded];
    }
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *) scrollView
{
    [self scrollingEnded];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _colorView = [[UIView alloc] init];
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        
        [self.contentView addSubview:_scrollView];
        [_scrollView addSubview:_colorView];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
