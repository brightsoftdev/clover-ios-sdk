//
//  CloverView.m
//  Clover Buy Button Example
//
//  Created by Michael Quinlan on 1/17/12.
//  Copyright (c) 2012 Clover. All rights reserved.
//

#import "CloverView.h"
#import "CloverState.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat appearDuration = 0.4;
static CGFloat disappearDuration = 0.4;

@implementation CloverView

@synthesize webView, cancelButton, activityIndicator, javascriptBridge;

#pragma mark Regular controller methods

- (id)init {
    CGRect screen = [UIScreen mainScreen].applicationFrame;
    if (self == [super initWithFrame:screen]) {
        // Setup the green border
        int padding = 10;
        int padding2 = padding * 2;
        UIView* border = [[UIView alloc] initWithFrame:CGRectMake(padding, padding, screen.size.width-padding2, screen.size.height-padding2)];
        int borderSize = 5;

        // Set up the actual webview inside the border
        CGRect contentFrame = CGRectMake(padding + borderSize, padding + borderSize, screen.size.width - 2*borderSize - padding2, screen.size.height - 2*borderSize - padding2);
        self.webView = [[UIWebView alloc] initWithFrame:contentFrame];
        border.layer.cornerRadius = 10;
        self.webView.layer.cornerRadius = 6;
        self.webView.backgroundColor = [UIColor whiteColor];
        border.clipsToBounds = self.webView.clipsToBounds = YES;
        border.backgroundColor = [UIColor colorWithRed:0.22 green:0.65 blue:0.20 alpha:0.7];
        self.backgroundColor = [UIColor clearColor];
        
        // Set up the cancel / close button
        // TODO style
        CGRect buttonFrame = CGRectMake(screen.size.width-60,5, 50, 20);
        self.cancelButton = [[UIButton alloc] initWithFrame:buttonFrame];
        [self.cancelButton setBackgroundColor:[UIColor lightGrayColor]];
        [[self.cancelButton titleLabel] setFont:[UIFont boldSystemFontOfSize:12.0]]; 
        [self.cancelButton setTitle:@"Close" forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(shrinkAndCloseOverlay) forControlEvents:UIControlEventTouchUpInside];

        // Setup the actvity spinner
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityIndicator.center = CGPointMake(160, 240);
        self.activityIndicator.hidesWhenStopped = YES;

        // Add them to the view
        [self addSubview:border];
        [self addSubview:webView];
        [self addSubview:cancelButton];
        [self addSubview:activityIndicator];

        // Set the javascript bridge
        self.javascriptBridge = [CloverViewJavascriptBridge javascriptBridgeWithDelegate:self];
        webView.delegate = self.javascriptBridge;
    }
    return self;
}

- (void)show {
    // Fill the java script bridge with data we know about
    NSString* name = [CloverState get].fullName;
    NSString* phoneNumber = [CloverState get].phoneNumber;
    NSString* email = [CloverState get].emailAddress;
    NSString* mac = [CloverState getMac];
    if (name)
        [self.javascriptBridge sendMessage:name toWebView:self.webView];
    if (phoneNumber)
        [self.javascriptBridge sendMessage:phoneNumber toWebView:self.webView];
    if (email)
        [self.javascriptBridge sendMessage:email toWebView:self.webView];
    if (mac)
        [self.javascriptBridge sendMessage:mac toWebView:self.webView];

    // Load a test view
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.clover.com"]];
    [webView loadRequest:requestObj];

    /*
    [self.webView loadHTMLString:@""
        "<!doctype html>"
        "<html><head>"
        "  <style type='text/css'>h1 { color:red; }</style>"
        "</head><body>"
        "  <h1>Test Clover Overlay</h1>"
        "  <script>"
        "  document.addEventListener('WebViewJavascriptBridgeReady', onBridgeReady, false);"
        "  function onBridgeReady() {"
        "      WebViewJavascriptBridge.setMessageHandler(function(message) {"
        "          var el = document.body.appendChild(document.createElement('div'));"
        "          el.innerHTML = message;"
        "      });"
        "      var button = document.body.appendChild(document.createElement('button'));"
        "      button.innerHTML = 'Buy something';"
        "      button.onclick = button.ontouchstart = function() { WebViewJavascriptBridge.sendMessage('from the button'); };"
        "  }"
        "  </script>"
        "</body></html>" baseURL:nil];
    */

    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }

    // Animate the window (expand)
    self.transform = CGAffineTransformScale([self transformForOrientation], 0.001, 0.001);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:appearDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationOutStopped)];
    self.transform = CGAffineTransformScale([self transformForOrientation], 1.0, 1.0);
    [UIView commitAnimations];

    [window addSubview:self];
}

- (void) closeOverlay {
    [self removeFromSuperview];
}

- (void) fadeAndCloseOverlay {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:disappearDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(closeOverlay)];
    self.alpha = 0;
    [UIView commitAnimations];
}

- (void) shrinkAndCloseOverlay {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:disappearDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(closeOverlay)];
    self.transform = CGAffineTransformScale([self transformForOrientation], 0.001, 0.001);
    [UIView commitAnimations];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

#pragma mark Web View methods

- (void)webViewDidStartLoad:(UIWebView *)wv {
	[activityIndicator startAnimating];
    [activityIndicator setHidden:FALSE];
}

- (void)webViewDidFinishLoad:(UIWebView *)wv {
	[activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)wv didFailLoadWithError:(NSError *)error {
	[activityIndicator stopAnimating];

	// Make sure there's an actual error, and the error is not -999 (JS-induced, or WebKit bug)
    if (error != NULL && ([error code] != NSURLErrorCancelled)) {
		if ([error code] != NSURLErrorCancelled) {
			//show error alert, etc.
		}
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error Loading Page" message: [error localizedFailureReason] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
    }
}

// Delegate call back from the javascript bridge
- (void)javascriptBridge:(CloverViewJavascriptBridge *)bridge receivedMessage:(NSString *)message fromWebView:(UIWebView *)webView {
    NSLog(@"Message from JS :%@", message); 
}

#pragma mark Animations
// Some basic aminmation handling
- (CGAffineTransform)transformForOrientation {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI*1.5);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI/2);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
    } else {
        return CGAffineTransformIdentity;
    }
}

- (void)animationOutStopped {
  
}



#pragma mark Memory management
// TODO dealloc maybe

@end
