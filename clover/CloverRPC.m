//
//  CloverRPC.m
//  Clover Buy Button Example
//
//  Created by John Marcus Westin on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CloverRPC.h"
#import "CloverState.h"
#import "JSONKit.h"

@interface CloverRPC (hidden)
+ (NSString*) encodeURIComponent:(NSString*)component;
+ (NSString*) decodeURIComponent:(NSString*)component;
@end

@implementation CloverRPC

+ (BOOL)sendToCloverApp:(NSString *)command params:(NSDictionary *)params handler:(_CloverRPCResponseHandler)handler {
    CloverState* state = [CloverState get];
    
    NSString* callbackID = [NSString stringWithFormat:@"cb%d", state.callbackID++];
    [state.callbacks setValue:handler forKey:callbackID];
    
    NSMutableDictionary* data = [NSMutableDictionary dictionaryWithDictionary:params];
    NSString* responseURL = [NSString stringWithFormat:@"%@://%@?cloverCallbackID=%@&cloverResponse=", state.appUrlScheme, [self getRPCHostName], callbackID];
    [data setValue:responseURL forKey:@"responseURL"];
    
    NSString* dataString = [self encodeURIComponent:[data JSONString]];
    NSString* protocolVersion = @"1";
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"clover://HandleActionLink?%@&version=%@&data=%@", command, protocolVersion, dataString]];
    
    NSLog(@"Send %@", [url  absoluteString]);
    return [[UIApplication sharedApplication] openURL:url];
}

+ (NSString *)getRPCHostName {
    return @"CloverResponse";
}

+ (BOOL)handleOpenURL:(NSURL *)url {
    if (![[url host] isEqualToString:[self getRPCHostName]]) { return NO; }
    NSLog(@"TODO handle action link response from Clover app %@", url);
    
    // Stub code for letting app know when order is authorized
    BOOL isOrderAuthorizedResponse = false;
    if (isOrderAuthorizedResponse) {
        CloverOrderHandler orderHandler = [CloverState get].orderHandler;
        CloverOrder* order = [[CloverOrder alloc] init];
        NSLog(@"TODO populate order from response");
        if (orderHandler) { orderHandler(order); }
    }
    
    return YES;
}

@end

@implementation CloverRPC (hidden)
    
+ (NSString*) encodeURIComponent:(NSString *)component {
    return (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef) component, NULL, (CFStringRef) @"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
}

+ (NSString*) decodeURIComponent:(NSString *)component {
    return (__bridge NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef) component, CFSTR(""), kCFStringEncodingUTF8);
}

@end