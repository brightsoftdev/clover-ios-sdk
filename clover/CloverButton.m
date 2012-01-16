//
//  CloverButton.m
//  iOS-SDK
//
//  Created by John Marcus Westin on 10/10/11.
//  Copyright (c) 2011 Clover. All rights reserved.
//

#import "CloverButton.h"
#import "CloverRPC.h"

@interface CloverButton (hidden)
- (void)_onButtonTapped:(UIButton*)button;
@end

@implementation CloverButton

@synthesize amount, title, type, image, permissions, transaction_id, account;

+ (CloverButton*)buttonWithType:(NSString *)type {
    if (![type isEqualToString:@"buy"]) { [NSException raise:@"Invalid button type" format:@"Invalid button type %@", type, nil]; }
    CloverButton* cloverButton = [[CloverButton alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    cloverButton.type = type;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = cloverButton.frame;
    [button setTitle:@"Buy now" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(_onButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [cloverButton addSubview:button];
    return cloverButton;
}

@end

@implementation CloverButton (hidden)

- (void)_onButtonTapped:(UIButton*)button {
    _CloverRPCResponseHandler rpcHandler = ^(NSString *error, NSDictionary *response) {
        NSLog(@"Got RCP error:%@ response:%@", error, response);
    };
    
    NSDictionary* params = [NSDictionary dictionaryWithObject:[[NSNumber numberWithInt:100] stringValue] forKey:@"amount"];
    BOOL didOpenCloverApp = [CloverRPC sendToCloverApp:@"authorize_order_new" params:params handler:rpcHandler];
    if (!didOpenCloverApp) {
        NSLog(@"Show overlay");
    }
}

@end
