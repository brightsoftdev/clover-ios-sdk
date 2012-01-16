//
//  Clover.m
//  iOS-SDK
//
//  Created by John Marcus Westin on 10/10/11.
//  Copyright (c) 2011 Clover. All rights reserved.
//

#import "Clover.h"
#import "CloverState.h"
#import "CloverButton.h"
#import "CloverRPC.h"

@implementation Clover

+ (void)setup:(NSString *)accountID {
    CloverState* state = [CloverState setup];
    state.accountID = accountID;
    state.callbackID = 0;
    state.callbacks = [NSMutableDictionary dictionary];
    NSLog(@"TODO read app url scheme from plist (throw if none available), and read mac");
    state.appUrlScheme = [CloverState getCurrentAppURLScheme];
    state.mac = [CloverState getMac];
}

+ (CloverButton *)createButtonWithAmount:(NSString *)amount title:(NSString *)title {
    [CloverState assertState];
    CloverButton* button = [CloverButton buttonWithType:@"buy"];
    button.amount = amount;
    button.title = title;
    return button;
}

+ (BOOL)handleOpenURL:(NSURL *)url {
    [CloverState assertState];
    return [CloverRPC handleOpenURL:url];
}

@end
