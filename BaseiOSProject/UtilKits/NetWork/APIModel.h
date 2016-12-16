//
//  APIModel.h
//  BaseiOSProject
//
//  Created by getinlight on 16/12/16.
//  Copyright © 2016年 getinlight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIModel : NSObject

@property (strong, nonatomic) NSData *resultData;
@property (assign, nonatomic) NSInteger code;
@property (strong, nonatomic) NSString *resultMsg;

@end
