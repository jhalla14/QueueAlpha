//
//  Player.h
//  QueueAlpha
//
//  Created by Joshua Hall & Kalon Stephen  on 11/28/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

@import Foundation;
@class Table;


@interface Player : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (nonatomic, getter = isHoldingLine) BOOL *holdingLine;
@property (nonatomic) NSInteger *points;

- (BOOL) callTable:(Table *) table;
- (BOOL) stepOff:(Table *) table;

@end
