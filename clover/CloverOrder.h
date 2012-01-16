//
//  CloverOrder.h
//  Clover Buy Button Example
//
//  Created by John Marcus Westin on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CloverOrder : NSObject

@property (atomic,retain) NSString* id;
@property (atomic,retain) NSString* amount;
@property (atomic,retain) NSString* title;
@property (atomic,retain) NSNumber* created_on;
@property (atomic,retain) NSString* client_order_id;
@property (atomic,retain) NSString* status;
@property (atomic,retain) NSDictionary* permissions;

@end

typedef void (^CloverOrderHandler)(CloverOrder* order);