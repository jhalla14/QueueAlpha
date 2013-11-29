//
//  Table.h
//  QueueAlpha
//
//  Created by Joshua Hall  on 11/28/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

@import Foundation;
#import "Player.h"

@interface Table : NSObject

@property (nonatomic, getter = isOpen)BOOL *open;



- (void) addPlayer:(Player *)player;




@end
