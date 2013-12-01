//
//  QueueModel.m
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/1/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import "QueueModel.h"
#import "Table.h"

@interface QueueModel()
@property (nonatomic, strong) NSMutableArray *tables; //# of tables
@end

@implementation QueueModel

- (NSMutableArray *) tables
{
    if (!_tables) _tables = [[NSMutableArray alloc] init];
    
    return _tables;
    
}

- (instancetype) initWithTableCount:(NSUInteger)count
{
    self = [super init];
    
    if (self) {
        for (int i=0; i<count; i++) {
            self.tables[i];
        }
        
    }
    
    return nil;
}

- (Table *) tableAtIndex:(NSUInteger)index
{
    
    
    return nil;
}

@end
