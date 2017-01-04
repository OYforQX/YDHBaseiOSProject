//
//  HomeViewController.m
//  BaseiOSProject
//
//  Created by getinlight on 16/12/16.
//  Copyright © 2016年 getinlight. All rights reserved.
//

#import "HomeViewController.h"
#import "User.h"
#import "DataCache.h"

@interface HomeViewController ()

@property (strong, nonatomic) APIFetcher *fetcher;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.fetcher = [APIFetcher fetcher];
    [self.fetcher fetch:@"getIndexPage" parameters:[NSMutableDictionary dictionary] ompletion:^(id data, NSString *message, NSError *error) {
        [self.fetcher invalidateTasks];
        DDLog(@"getIndexPage请求成功");
    }];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"listType"] = @"0";
    dict[@"pageNo"] = @"1";
    [self.fetcher fetch:@"getInvestList" parameters:dict ompletion:^(id data, NSString *message, NSError *error) {
        DDLog(@"getInvestList请求成功");
    }];
    
    User *user = [[User alloc] init];
    user.token = @"1234567765432";
    user.userID = @"123";
    
    [DataCache setCache:user forKey:@"user"];
    User *loaduser = [DataCache loadCache:@"user"];
    
    DDLog(@"%@", loaduser);
    
}


@end
