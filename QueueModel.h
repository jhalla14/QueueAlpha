//
//  QueueModel.h
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/1/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Table;

@interface QueueModel : NSObject

//number of tables running
- (instancetype) initWithTableCount:(NSUInteger) count;

- (Table *) tableAtIndex:(NSUInteger) index;



@end
