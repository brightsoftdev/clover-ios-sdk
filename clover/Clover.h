//
//  Clover.h
//  iOS-SDK
//
//  Created by John Marcus Westin on 10/10/11.
//  Copyright (c) 2011 Clover. All rights reserved.
//

#import "CloverButton.h"
#import "CloverOrder.h"
#import <Foundation/Foundation.h>

typedef void (^CloverOrderHandler)(CloverOrder* order);

@class CloverButton;

@interface Clover : NSObject

+ (void) setup:(NSString*)accountID;
+ (CloverButton*) createButtonWithAmount:(NSString*)amount title:(NSString*)title;
+ (BOOL) handleOpenURL:(NSURL *)url;

@end