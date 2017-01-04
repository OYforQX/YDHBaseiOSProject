//
//  DataCache.h
//  BaseiOSProject
//
//  Created by getinlight on 17/1/4.
//  Copyright © 2017年 getinlight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataCache : NSObject

+ (void)setCache:(id)data forKey:(NSString *)key;

+ (id)loadCache:(NSString *)key;

@end
