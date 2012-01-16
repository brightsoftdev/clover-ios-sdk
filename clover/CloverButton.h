//
//  CloverButton.h
//  iOS-SDK
//
//  Created by John Marcus Westin on 10/10/11.
//  Copyright (c) 2011 Clover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Clover.h"
#import "CloverOrder.h"

@class Clover;

@interface CloverButton : UIView

// Required
@property (atomic,retain) NSString* amount;
@property (atomic,retain) NSString* title;
@property (atomic,retain) NSString* type;
// Optional
@property (atomic,retain) NSString* image;
@property (atomic,retain) NSString* permissions;
@property (atomic,retain) NSString* client_order_id;
@property (atomic,retain) NSString* account;

+ (CloverButton*) buttonWithType:(NSString*)type;

@end

