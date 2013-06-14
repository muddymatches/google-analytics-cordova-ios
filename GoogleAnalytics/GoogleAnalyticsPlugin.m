#import "GoogleAnalyticsPlugin.h"
// Dispatch period in seconds
static const NSInteger kGANDispatchPeriodSec = 2;
@implementation GoogleAnalyticsPlugin

- (void) trackerWithTrackingId:(CDVInvokedUrlCommand*)command {
    NSString* accountId = [command.arguments objectAtIndex:0];
    NSLog(accountId);
    [GAI sharedInstance].debug = YES;
    [GAI sharedInstance].dispatchInterval = kGANDispatchPeriodSec;
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [[GAI sharedInstance] trackerWithTrackingId:accountId];
}

- (void) trackEventWithCategory:(CDVInvokedUrlCommand*)command {
    NSDictionary *options = [command.arguments objectAtIndex:0];
    NSString* category = [options valueForKey:@"category"];
    NSString* action = [options valueForKey:@"action"];
    NSString* label = [options valueForKey:@"label"];
    NSNumber* value = [options valueForKey:@"value"];
    if (![[GAI sharedInstance].defaultTracker trackEventWithCategory:category
                                                          withAction:action
                                                           withLabel:label
                                                           withValue:value]) {
        // Handle error here
        NSLog(@"GoogleAnalyticsPlugin.trackEvent Error::");
    }
    NSLog(@"GoogleAnalyticsPlugin.trackEvent::%@, %@, %@, %@",category,action,label,value);
}

- (void) trackView:(CDVInvokedUrlCommand*)command {
    NSString* pageUri = [command.arguments objectAtIndex:0];
    NSLog(pageUri);
    if (![[GAI sharedInstance].defaultTracker trackView:pageUri]) {
        // TODO: Handle error here
    }
}

- (void) hitDispatched:(NSString *)hitString {
    NSString* callback = [NSString stringWithFormat:@"window.plugins.googleAnalyticsPlugin.hitDispatched(%@);", hitString];
    [ self.webView stringByEvaluatingJavaScriptFromString:callback];
}
@end