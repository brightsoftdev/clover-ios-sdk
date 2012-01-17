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
	IBOutlet UIButton *cancelButton;
    IBOutlet UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic,retain) UIWebView *webView;
@property (nonatomic,retain) UIButton *cancelButton;
@property (strong, nonatomic) CloverViewJavascriptBridge *javascriptBridge;

-(void) show;
-(void) closeOverlay;
-(void) fadeAndCloseOverlay;

// Animations
- (CGAffineTransform)transformForOrientation;
- (void)animationOutStopped;

@end
