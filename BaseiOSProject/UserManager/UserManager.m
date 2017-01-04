//
//  UserManager.m
//  BaseiOSProject
//
//  Created by getinlight on 17/1/4.
//  Copyright © 2017年 getinlight. All rights reserved.
//

#import "UserManager.h"

static UserManager *_manager = nil;

@implementation UserManager

+ (instancetype)manager {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[super allocWithZone:zone] init];
    });
    
    return _manager;
}

- (id)copyWithZone:(NSZone *)zone {
    return _manager;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _manager;
}

@end
