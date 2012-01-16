//
//  CloverRPC.m
//  Clover Buy Button Example
//
//  Created by John Marcus Westin on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CloverRPC.h"

@implementation CloverRPC

+ (BOOL)sendToCloverApp:(NSString *)command params:(NSDictionary *)params handler:(_CloverRPCResponseHandler)handler {
    NSLog(@"TODO: implement sendAppRPC");
    BOOL appDidOpen = false;
    return appDidOpen;
}

+ (NSString *)getRPCHostName {
    return @"CloverResponse";
}

@end
