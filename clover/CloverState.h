//
//  CloverState.h
//  Clover Buy Button Example
//
//  Created by John Marcus Westin on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CloverState : NSObject

+ (CloverState*)setup;
+ (CloverState*)get;
+ (void)assertState;
+ (NSString*)getCurrentAppURLScheme;
+ (NSString*)getMac;

@property (atomic,retain) NSString* accountID;
@property (atomic,retain) NSMutableDictionary* callbacks;
@property (atomic,assign) NSInteger callbackID;
@property (atomic,assign) NSString* appUrlScheme;
@property (atomic,assign) NSString* mac;

@end
