//
//  User.h
//  BaseiOSProject
//
//  Created by getinlight on 16/12/16.
//  Copyright © 2016年 getinlight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSString *token;

@end
