#import <UIKit/UIKit.h>

@class CloverViewJavascriptBridge;

@protocol CloverViewJavascriptBridgeDelegate <UIWebViewDelegate>

- (void)javascriptBridge:(CloverViewJavascriptBridge *)bridge receivedMessage:(NSString *)message fromWebView:(UIWebView *)webView;

@end

@interface CloverViewJavascriptBridge : NSObject <UIWebViewDelegate>

@property (nonatomic, assign) IBOutlet id <CloverViewJavascriptBridgeDelegate> delegate;

/* Create a javascript bridge with the given delegate for handling messages */
+ (id)javascriptBridgeWithDelegate:(id <CloverViewJavascriptBridgeDelegate>)delegate;

/* Send a message to the web view. Make sure that this javascript bridge is the delegate
 * of the webview before calling this method (see ExampleAppDelegate.m) */
- (void)sendMessage:(NSString *)message toWebView:(UIWebView *)webView;

@end
