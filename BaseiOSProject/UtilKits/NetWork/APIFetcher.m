//
//  APIFetcher.m
//  BaseiOSProject
//
//  Created by getinlight on 16/12/16.
//  Copyright © 2016年 getinlight. All rights reserved.
//

#import "APIFetcher.h"
#import "Reachability.h"
#import "APIModel.h"
#import <YYModel/YYModel.h>

static const NSTimeInterval kDefaultTimeoutInterval = 15.0f;

NSString * const APIErrorDomain = @"com.xxx.api.error";

NSString *const kDuplicateLoginNotification = @"com.xxx.notification.duplicateLogin";
NSString *const kTokenExpiredNotification = @"com.xxx.notification.tokenExpired";

@interface APIFetcher ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;

@end

@implementation APIFetcher

+ (instancetype)fetcher {
    return [[[self class] alloc] init];
}

+ (NSString *)urlForAPI:(NSString *)api {
    return [kAPIDomain stringByAppendingString:api];
}

+ (NSString *)urlForLink:(NSString *)link {
    return [kLinkDomain stringByAppendingString:link];
}

- (void)fetch:(NSString *)url parameters:(NSMutableDictionary *)parameters ompletion:(APIFetcherCompletion)completion {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    DDLog(@"请求的url = %@, 请求参数 = %@", [APIFetcher urlForAPI:url], parameters);
    
    [self.sessionManager POST:[APIFetcher urlForAPI:url] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self handleSuccess:task responseObject:responseObject completion:completion];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self handleFailure:task error:error completion:completion];
    }];
}

- (void)invalidateTasks {
    [self.sessionManager invalidateSessionCancelingTasks:YES];
}

#pragma mark -
#pragma mark private method

- (void)handleSuccess:(NSURLSessionDataTask *)task responseObject:(id)responseObject completion:(APIFetcherCompletion)completion {
#ifdef DEBUG
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
    NSString *responseString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    DDLog(@"返回数据 = %@", responseString);
#endif
    
    if (!completion) {
        return;
    }
    
    APIModel *model = [APIModel yy_modelWithJSON:responseObject];
    
    if (!model) {
        completion(nil, nil, [APIFetcher badServerResponse]);
        return;
    }
    
    NSInteger code = model.code;
    if (code == XKAPIErrorCodeSuccess) {
        completion(model.resultData, model.resultMsg, nil);
        return;
    }
    
    if (code == XKAPIErrorCodeTokenExpired) {
        DDLog(@"Token过期");
        [[NSNotificationCenter defaultCenter] postNotificationName:kTokenExpiredNotification object:nil userInfo:nil];
        return;
    }
    
    if (code == XKAPIErrorCodeDuplicateLogin) {
        DDLog(@"异端登录");
        [[NSNotificationCenter defaultCenter] postNotificationName:kDuplicateLoginNotification object:nil userInfo:nil];
        return;
    }
    
    DDLog(@"code异常 = %zd resultMsg = %@", code, model.resultMsg);
    completion(nil, nil, [APIFetcher errorWithCode:model.code message:model.resultMsg]);
    return;
    
}

- (void)handleFailure:(NSURLSessionDataTask *)task error:(NSError *)error completion:(APIFetcherCompletion)completion {
    DDLog(@"响应错误 = %@\n 返回数据 = %@", error, task.response);
    
    if (!completion) {
        return;
    }
    
    completion(nil, nil, [APIFetcher badServerResponse]);
}

+ (NSError *)badServerResponse {
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    if (reach.currentReachabilityStatus == NotReachable) {
        return [NSError errorWithDomain:APIErrorDomain code:XKAPIErrorCodeBadServerResponse userInfo:@{NSLocalizedDescriptionKey: @"当前网络不可用,请检查网络连接"}];
    } else {
        return [NSError errorWithDomain:APIErrorDomain code:XKAPIErrorCodeBadServerResponse userInfo:@{NSLocalizedDescriptionKey: @"服务器异常"}];
    }
}

+ (NSError *)badModelData {
    return [NSError errorWithDomain:APIErrorDomain code:XKAPIErrorCodeBadServerResponse userInfo:@{NSLocalizedDescriptionKey: @"模型解析失败"}];
}

+ (NSError *)errorWithCode:(APIErrorCode)code message:(NSString *)message {
    return [NSError errorWithDomain:APIErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey: message}];
}

#pragma mark -
#pragma mark getter & setter

- (AFHTTPSessionManager *)sessionManager {
    if (_sessionManager == nil) {
        NSURLSessionConfiguration *confi = [NSURLSessionConfiguration defaultSessionConfiguration];
        confi.timeoutIntervalForResource = self.timeoutInterval > 0 ? self.timeoutInterval : kDefaultTimeoutInterval;
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:confi];
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return _sessionManager;
}

@end
