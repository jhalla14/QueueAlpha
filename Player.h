//
//  Player.h
//  QueueAlpha
//
//  Created by Joshua Hall & Kalon Stephen  on 11/28/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, retain) NSString *firstName;
@property NSString *lastName;
@property BOOL *isHoldingLine;
@property NSInteger *points;

@end
