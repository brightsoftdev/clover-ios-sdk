//
//  CloverState.m
//  Clover Buy Button Example
//
//  Created by John Marcus Westin on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CloverState.h"

static CloverState* state;

@implementation CloverState

@synthesize accountID, callbacks, callbackID, appUrlScheme, mac, phoneNumber, emailAddress;

+ (CloverState *)setup {
    if (state) { [NSException raise:@"Invalid call order" format:@"[Clover setup:accountID] called twice"]; }
    return state = [[CloverState alloc] init];
}

+ (CloverState *)get {
    [self assertState];
    return state;
}

+ (void)assertState {
    if (!state) { [NSException raise:@"Invalid call order" format:@"[Clover setup:accountID] called twice"]; }
}

+ (NSString *)getCurrentAppURLScheme {
    NSArray* urlTypes = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"];
    if (!urlTypes || urlTypes.count == 0) {
        // ERROR
        return nil;
    }
    NSArray* urlSchemes = [[urlTypes objectAtIndex:0] objectForKey:@"CFBundleURLSchemes"];
    if (!urlSchemes || urlSchemes.count == 0) {
        // ERROR
        return nil;
    }
    return [urlSchemes objectAtIndex:0];
}

+ (NSString *)getMac {
    NSLog(@"TODO implement CloverState getMac");
    return @"mac";
}

@end
