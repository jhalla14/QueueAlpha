//
//  User.m
//  QueueAlpha
//
//  Created by Joshua Hall  on 12/22/13.
//  Copyright (c) 2013 Queue. All rights reserved.
//

#import "User.h"

@implementation User

- (NSString *) email
{
    if (!_email) {
        _email = [[NSString alloc] init];
    }
    return _email;
}

- (NSString *) firstName
{
    if (!_firstName) {
        _firstName = [[NSString alloc] init];
    }
    return _firstName;
}

- (NSString *) lastName
{
    if (!_lastName) {
        _lastName = [[NSString alloc] init];
    }
    return _lastName;
}

- (NSString *) password
{
    if (!_password) {
        _password = [[NSString alloc] init];
    }
    return _password;
}

@end
