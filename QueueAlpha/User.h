//
//  User.h
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/22/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *password;
@property (nonatomic, getter = isAdmin) BOOL admin;

@end
