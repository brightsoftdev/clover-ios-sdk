//
//  CloverState.m
//  Clover Buy Button Example
//
//  Created by John Marcus Westin on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CloverState.h"

// Need for MAC address
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

static CloverState* state;

@implementation CloverState

@synthesize accountID, callbacks, callbackID, appUrlScheme, mac, phoneNumber, emailAddress, fullName, orderHandler, sdkVersion;

+ (CloverState *)setup {
    if (state) { [NSException raise:@"Invalid call order" format:@"[Clover setup:accountID] called twice"]; }
    return state = [[CloverState alloc] init];
}

+ (CloverState *)get {
    [self assertState];
    return state;
}

+ (void)assertState {
    if (!state) { [NSException raise:@"Invalid call order" format:@"[Clover setup:accountID] called twice"]; }
}

+ (NSString *)getCurrentAppURLScheme {
    NSArray* urlTypes = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"];
    if (!urlTypes || urlTypes.count == 0) {
        // ERROR
        return nil;
    }
    NSArray* urlSchemes = [[urlTypes objectAtIndex:0] objectForKey:@"CFBundleURLSchemes"];
    if (!urlSchemes || urlSchemes.count == 0) {
        // ERROR
        return nil;
    }
    return [urlSchemes objectAtIndex:0];
}

+ (NSString *)getMac {
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macString = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X", 
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return macString;
}

@end
