//
//  DataCache.m
//  BaseiOSProject
//
//  Created by getinlight on 17/1/4.
//  Copyright © 2017年 getinlight. All rights reserved.
//

#import "DataCache.h"

@implementation DataCache

+ (void)setCache:(id)data forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setValue:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)loadCache:(NSString *)key {
    return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] valueForKey:key]];
}

@end
