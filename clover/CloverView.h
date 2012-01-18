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
    NSDictionary* buttonProperties;
}

@property (nonatomic,retain) UIWebView *webView;
@property (nonatomic,retain) UIButton *cancelButton;
@property (nonatomic,retain)  UIActivityIndicatorView *activityIndicator;
@property (nonatomic,retain)  NSDictionary *buttonProperties;
@property (strong, nonatomic) CloverViewJavascriptBridge *javascriptBridge;

// Additional Constructors
-(id) initWithButtonProperties:(NSDictionary*)_buttonProperties;

// Showing / hiding the overlay
-(void) show;
-(void) closeOverlay;
-(void) fadeAndCloseOverlay;
-(void) shrinkAndCloseOverlay;

// Animations
- (CGAffineTransform)transformForOrientation;
- (void)animationOutStopped;

// Filling with known data
- (void) populateWithKnownData;
- (void) localTest;

@end
