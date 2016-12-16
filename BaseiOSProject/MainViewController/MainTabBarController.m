//
//  MainTabBarController.m
//  BaseiOSProject
//
//  Created by getinlight on 16/12/16.
//  Copyright © 2016年 getinlight. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "HomeViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MainNavigationController *navi1 = [[MainNavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    
    [self addChildViewController:navi1];
    [self addChildViewController:navi1];
    
}

@end
