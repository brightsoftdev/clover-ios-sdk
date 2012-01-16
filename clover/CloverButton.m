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
- (void)onButtonTapped:(UIButton*)button;
- (NSDictionary*) getButtonProperties;
@end

@implementation CloverButton

@synthesize amount, title, type, image, permissions, client_order_id, account;

+ (CloverButton*)buttonWithType:(NSString *)type {
    if (![type isEqualToString:@"buy"]) { [NSException raise:@"Invalid button type" format:@"Invalid button type %@", type, nil]; }
    CloverButton* cloverButton = [[CloverButton alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    cloverButton.type = type;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = cloverButton.frame;
    [button setTitle:@"Buy now" forState:UIControlStateNormal];
    [button addTarget:cloverButton action:@selector(onButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [cloverButton addSubview:button];
    return cloverButton;
}

@end

@implementation CloverButton (hidden)

- (void)onButtonTapped:(UIButton*)button {
    _CloverRPCResponseHandler rpcHandler = ^(NSString *error, NSDictionary *response) {
        NSLog(@"Got RCP error:%@ response:%@", error, response);
    };
    
    NSDictionary* params = [NSDictionary dictionaryWithObject:[self getButtonProperties] forKey:@"buttonProperties"];
    BOOL didOpenCloverApp = [CloverRPC sendToCloverApp:@"authorize_order_new" params:params handler:rpcHandler];
    if (!didOpenCloverApp) {
        NSLog(@"Show overlay");
    }
}

- getButtonProperties {
    NSMutableDictionary* props = [NSMutableDictionary dictionary];
    [props setValue:amount forKey:@"amount"];
    [props setValue:title forKey:@"title"];
    if (type) { [props setValue:type forKey:@"type"]; }
    if (image) { [props setValue:image forKey:@"image"]; }
    if (permissions) { [props setValue:permissions forKey:@"permissions"]; }
    if (client_order_id) { [props setValue:client_order_id forKey:@"client_order_id"]; }
    if (account) { [props setValue:account forKey:@"account"]; }
    return props;
}

@end
