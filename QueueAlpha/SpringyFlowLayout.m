//
//  SpringyFlowLayout.m
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/16/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import "SpringyFlowLayout.h"

@implementation SpringyFlowLayout
{
    UIDynamicAnimator *_dynamicAnimator;
    
}

- (void) prepareLayout
{
    [super prepareLayout];
    
    if (!_dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc]initWithCollectionViewLayout:self];
    }
    
    CGSize contentSize = [self collectionViewContentSize];
    NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
    
    for (UICollectionViewLayoutAttributes *item in items) {
        UIAttachmentBehavior *spring = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:[item center]];
        
        NSLog(@"Spring is %@", spring);
        
        spring.length = 0;
        spring.damping = .5;
        spring.frequency = .8;

        [_dynamicAnimator addBehavior:spring];
    }

}

//tells what items are visible in the rect
- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect
{
    return [_dynamicAnimator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [_dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}

- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    UIScrollView *scrollView = self.collectionView;
    CGFloat scrollDelta = newBounds.origin.y - scrollView.bounds.origin.y;
    
    for (UIAttachmentBehavior *spring in _dynamicAnimator.behaviors){
        UICollectionViewLayoutAttributes *item = [spring.items firstObject];
        CGPoint center = [item center];
        center.y += scrollDelta;
        item.center = center;
        
        [_dynamicAnimator updateItemUsingCurrentState:item];
        
    }
    return NO;
}

@end
