//
//  Table.m
//  QueueAlpha
//
//  Created by Joshua Hall  on 11/28/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import "Table.h"
@interface Table()
@property (strong, nonatomic) NSMutableArray *players;
@end

@implementation Table

- (NSMutableArray *) players
{
    if (!_players) {
        _players = [[NSMutableArray alloc] init];
        
    }
    return _players;
}


- (void) addPlayer:(Player *) player
{
    [self.players insertObject:player atIndex:0];
}

@end


