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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UIViewController *rootViewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    UIView* rootView = rootViewController.view;
    [self.window setRootViewController:rootViewController];
    [self.window addSubview:[rootViewController view]];
    
    [Clover setup:@"04c6441a-9bad-4d0f-9abd-bbb1f1b09048"];
    CloverButton* buyButton = [Clover createButtonWithAmount:@"0.01" title:@"Test purchase"];
    buyButton.center = rootView.center;
    [rootView addSubview:buyButton];
    
    return YES;
}

@end
