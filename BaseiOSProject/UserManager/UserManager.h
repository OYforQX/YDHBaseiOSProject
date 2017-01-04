//
//  UserManager.h
//  BaseiOSProject
//
//  Created by getinlight on 17/1/4.
//  Copyright © 2017年 getinlight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserManager : NSObject <NSCopying, NSMutableCopying>

@property (strong, nonatomic) User *user;

+ (instancetype)manager;

@end



// 更新用户信息
// 
