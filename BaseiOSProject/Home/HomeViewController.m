//
//  HomeViewController.m
//  BaseiOSProject
//
//  Created by getinlight on 16/12/16.
//  Copyright © 2016年 getinlight. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (strong, nonatomic) APIFetcher *fetcher;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.fetcher = [APIFetcher fetcher];
    [self.fetcher fetch:@"getIndexPage" parameters:[NSMutableDictionary dictionary] ompletion:^(id data, NSString *message, NSError *error) {
        
    }];
    
}


@end
