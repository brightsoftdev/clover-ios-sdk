//
//  CloverRPC.h
//  Clover Buy Button Example
//
//  Created by John Marcus Westin on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^_CloverRPCResponseHandler)(NSString* error, NSDictionary* response);

@interface CloverRPC : NSObject

+ (BOOL) sendToCloverApp:(NSString*)command params:(NSDictionary*)params handler:(_CloverRPCResponseHandler)handler;

+ (NSString*) getRPCHostName;

@end
