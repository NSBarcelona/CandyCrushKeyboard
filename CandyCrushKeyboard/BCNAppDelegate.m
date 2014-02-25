//
//  BCNAppDelegate.m
//  CandyCrushKeyboard
//
//  Created by Hermes on 25/02/14.
//  Copyright (c) 2014 Hermes Pique. All rights reserved.
//

#import "BCNAppDelegate.h"
#import "BCNViewController.h"

@implementation BCNAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    UIViewController *vc = [BCNViewController new];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
