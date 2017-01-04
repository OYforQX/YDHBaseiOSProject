//
//  User.m
//  BaseiOSProject
//
//  Created by getinlight on 16/12/16.
//  Copyright © 2016年 getinlight. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _token = [aDecoder decodeObjectForKey:@"token"];
        _userID = [aDecoder decodeObjectForKey:@"userID"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_token forKey:@"token"];
    [aCoder encodeObject:_userID forKey:@"userID"];
}

@end
