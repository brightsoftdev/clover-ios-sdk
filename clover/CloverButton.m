//
//  CloverButton.m
//  iOS-SDK
//
//  Created by John Marcus Westin on 10/10/11.
//  Copyright (c) 2011 Clover. All rights reserved.
//

#import "CloverButton.h"
#import "CloverRPC.h"
#import "CloverView.h"

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
    [cloverButton setTitle:@"Buy now" forState:UIControlStateNormal];
    [cloverButton addTarget:cloverButton action:@selector(onButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    return cloverButton;
}

// Alows construction from both programmatically and in a xib
- (id)initWithFrame:(CGRect)frame { 
    self = [super initWithFrame:frame];    
    if (self) {
        // Set the background image (just a color more the current time)
        // TODO make this look really nice!
        [self setBackgroundColor:[UIColor colorWithRed:0.22 green:0.65 blue:0.20 alpha:1.0]];

        // Set the background image (just a color more the current time)
        // TODO make this look really nice!
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal]; 
        [[self titleLabel] setShadowOffset:CGSizeMake(1.0, 1.0)];

        // Bold the font (keep size set in nib)
        UIFont* font = [[self titleLabel] font];
        [[self titleLabel] setFont:[UIFont boldSystemFontOfSize:font.pointSize]]; 
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)inCoder {
    if (self = [super initWithCoder:inCoder]) {
        // Set the background image (just a color more the current time);
        [self setBackgroundColor:[UIColor colorWithRed:0.22 green:0.65 blue:0.20 alpha:1.0]];

        // Set the font
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal]; 
        [[self titleLabel] setShadowOffset:CGSizeMake(1.0, 1.0)];

        // Bold the font (keep size set in nib)
        UIFont* font = [[self titleLabel] font];
        [[self titleLabel] setFont:[UIFont boldSystemFontOfSize:font.pointSize]]; 
    }
    return self;
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
        CloverView *overlay = [[CloverView alloc] initWithButtonProperties:[self getButtonProperties]];
        [overlay show];
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
