//
//  Clover.m
//  iOS-SDK
//
//  Created by John Marcus Westin on 10/10/11.
//  Copyright (c) 2011 Clover. All rights reserved.
//

#import "Clover.h"
#import "CloverState.h"
#import "CloverButton.h"
#import "CloverRPC.h"

@implementation Clover

+ (void)setup:(NSString *)accountID {
    CloverState* state = [CloverState setup];
    state.accountID = accountID;
    state.callbackID = 0;
    state.callbacks = [NSMutableDictionary dictionary];
    state.mac = [CloverState getMac];
    state.appUrlScheme = [CloverState getCurrentAppURLScheme];
    state.sdkVersion = @"0.1";
    if (!state.appUrlScheme || [state.appUrlScheme length] == 0) {
        [NSException raise:@"Custom App URL Scheme Required" format:@"You must register a custom URL scheme in your app in order to receive messages back from the Clover App - see https://www.clover.com/docs/ios-sdk"];
    }
}

+ (CloverButton *)createButtonWithAmount:(NSString *)amount title:(NSString *)title {
    [CloverState assertState];
    CloverButton* button = [CloverButton buttonWithType:@"buy"];
    button.amount = amount;
    button.title = title;
    return button;
}

+ (void)onOrder:(CloverOrderHandler)handler {
    [CloverState assertState];
    [CloverState get].orderHandler = handler;
}

+ (BOOL)handleOpenURL:(NSURL *)url {
    [CloverState assertState];
    return [CloverRPC handleOpenURL:url];
}

+ (void)setUserPhoneNumber:(NSString *)phoneNumber {
    [CloverState assertState];
    [CloverState get].phoneNumber = phoneNumber;
}

+ (void)setUserEmailAddress:(NSString *)emailAddress {
    [CloverState assertState];
    [CloverState get].emailAddress = emailAddress;
}

+ (void)setUserFullName:(NSString *)fullName {
    [CloverState assertState];
    [CloverState get].fullName = fullName;
}

@end
