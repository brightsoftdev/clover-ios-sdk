//
//  CloverView.h
//  Clover Buy Button Example
//
//  Created by Michael Quinlan on 1/17/12.
//  Copyright (c) 2012 Clover. All rights reserved.
//

#import "CloverViewJavascriptBridge.h"
#import <UIKit/UIKit.h>

@interface CloverView : UIView <CloverViewJavascriptBridgeDelegate> {
	IBOutlet UIWebView *webView;
	IBOutlet UIActivityIndicatorView *activityIndicator;
    
	NSURL *webViewURL;	
}

@property (nonatomic,retain) UIWebView *webView;
@property (nonatomic,retain) NSURL *webViewURL;
@property (strong, nonatomic) CloverViewJavascriptBridge *javascriptBridge;

-(void) show;

// Animations
- (CGAffineTransform)transformForOrientation;
- (void)bounce1AnimationStopped;
- (void)bounce2AnimationStopped;

@end
