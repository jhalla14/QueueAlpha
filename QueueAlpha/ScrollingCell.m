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
//
//- (void) setColor:(UIColor *)color
//{
//    _color = color;
//    _colorView.backgroundColor = color;
//}

- (void) scrollViewDidScroll:(UIScrollView *) scrollView
{
//    NSLog(@"did scroll");
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
    NSLog(@"hello");
    [_delegate scrollingCellDidEndPulling:self];
    _pulling = NO;
}

- (void) scrollViewDidEndDragging:(UIScrollView *) scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"sup");
    if (!decelerate) {
        [self scrollingEnded];
    }
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *) scrollView
{
    NSLog(@"anybody");
    [self scrollingEnded];
}

#pragma mark Setup & Initalization

- (id)initWithCoder:(NSCoder *)aDecoder
{
//    NSLog(@"Init with Coder");
//    self = [super initWithFrame:frame];
    if (self = [super initWithCoder:aDecoder]) {
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

- (void)layoutSubviews {
    UIView * contentView = self.contentView;
    CGRect bounds = contentView.bounds;
    
    CGFloat pageWidth = bounds.size.width + PULL_THRESHOLD;
    _scrollView.frame = CGRectMake(0, 0, pageWidth, bounds.size.height);
    _scrollView.contentSize = CGSizeMake(pageWidth * 2, bounds.size.height);
    
    _colorView.frame = [_scrollView convertRect:bounds fromView:contentView];
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
