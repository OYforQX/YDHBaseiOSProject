//
//  APIFetcher.h
//  BaseiOSProject
//
//  Created by getinlight on 16/12/16.
//  Copyright © 2016年 getinlight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "ConfigNetWork.h"

typedef NS_ENUM(NSUInteger, APIErrorCode) {
    XKAPIErrorCodeBadServerResponse = 0,
    XKAPIErrorCodeSuccess,
    XKAPIErrorCodeFail,
    XKAPIErrorCodeTokenExpired,
    XKAPIErrorCodeDuplicateLogin
};

/**
 *  用户在其他设备上登录
 */
extern NSString * const kDuplicateLoginNotification;
/**
 *  token过期
 */
extern NSString * const kTokenExpiredNotification;

@interface APIFetcher : NSObject

typedef void(^APIFetcherCompletion) (id data,NSString *message, NSError *error);

@property (strong, nonatomic) NSURLSessionDataTask *task;
@property (assign, nonatomic) NSTimeInterval timeoutInterval;

+ (instancetype)fetcher;

- (void)invalidateTasks;

+ (NSString *)urlForLink:(NSString *)link;

+ (NSString *)urlForAPI:(NSString *)api;

- (void)fetch:(NSString *)url parameters:(NSMutableDictionary *)parameters ompletion:(APIFetcherCompletion)completion;

@end
