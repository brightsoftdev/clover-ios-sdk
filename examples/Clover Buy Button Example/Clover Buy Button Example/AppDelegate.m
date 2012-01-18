//
//  AppDelegate.m
//  Clover Buy Button Example
//
//  Created by John Marcus Westin on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Clover.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    [self.window makeKeyAndVisible];
    
    UIViewController *rootViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    UIView* rootView = rootViewController.view;
    [self.window setRootViewController:rootViewController];
    [self.window addSubview:[rootViewController view]];
    
    [Clover setup:@"58129cb7-1a1f-4cf3-8699-13f33bbaa6ae"];
    [Clover setUserPhoneNumber:@"555-555-5556"];
    [Clover setUserFullName:@"Jack Clover"];
    [Clover setUserEmailAddress:@"jack@clover.com"];
    CloverButton* buyButton = [Clover createButtonWithAmount:@"0.10" title:@"Test purchase"];
    buyButton.permissions = @"full_name, phone_number";
    buyButton.center = rootView.center;
    [rootView addSubview:buyButton];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([Clover handleOpenURL:url]) { return YES; }
    return YES;
}
@end
