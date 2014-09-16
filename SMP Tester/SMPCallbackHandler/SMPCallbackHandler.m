//
//  SMPCallbackHandler.m
//  SMP Tester
//
//  Created by Brenton O'Callaghan on 15/09/2014.
//  Copyright (c) 2014 Bluefin Solutions Ltd. All rights reserved.
//

#import "SMPCallbackHandler.h"

@interface SMPCallbackHandler()

@property (nonatomic, retain) NSMutableArray *logMessages;

@end

@implementation SMPCallbackHandler

static SMPCallbackHandler *handler;

#pragma mark - Static methods.

+ (SMPCallbackHandler *)getInstance{
    if (!handler) {
        handler = [[[SMPCallbackHandler alloc] init] retain];
    }
    return handler;
}

+ (NSMutableArray *)getLogMessages{
    
    if (!handler) {
        handler = [[[SMPCallbackHandler alloc] init] retain];
    }
    return handler.logMessages;
}

#pragma mark - Instance methods

- (instancetype)init{
    if ([super init]) {
        self.logMessages = [[NSMutableArray alloc] init];
    }
    return self;
}

/*!
 @method
 @abstract   Invoked when one or more applicationSettings have been changed by the server administrator.
 @discussion
 */
- (void)onApplicationSettingsChanged:(SUPStringList*)names{
    NSLog(@"SMPCallackHandler-onApplicationSettingsChanged");
    NSLog(@"Setting: %@", names);
    [self.logMessages addObject:names];
}

/*!
 @method
 @abstract   Invoked when the connectionStatus changes.
 @discussion
 */
- (void)onConnectionStatusChanged:(SUPConnectionStatusType)connectionStatus :(int32_t)errorCode :(NSString*)errorMessage{
    NSLog(@"SMPCallackHandler-onConnectionStatusChanged");
    NSLog(@"Status: %i Message: %@", connectionStatus, errorMessage);
}

/*!
 @method
 @abstract   Invoked when the registrationStatus changes.
 @discussion
 */
- (void)onRegistrationStatusChanged:(SUPRegistrationStatusType)registrationStatus :(int32_t)errorCode :(NSString*)errorMessage{
    NSLog(@"SMPCallackHandler-onRegistrationStatusChanged");
    NSLog(@"Status: %i Message: %@", registrationStatus, errorMessage);
}

/*!
 @method
 @abstract   Invoked when a condition is detected on the mobile device that may be of interest to the application or the application user.
 @discussion
 */
- (void)onDeviceConditionChanged :(SUPDeviceConditionType)condition{
    NSLog(@"SMPCallackHandler-onDeviceConditionChanged");
    NSLog(@"Condition: %i", condition);
}

/*!
 @method
 @abstract Invoked when an HTTP communication server rejects HTTP communication with an error code.
 @discussion
 If error code is 401, it might be an authentication challenge that the httpCredential in the ConnectionProperties should be provided.
 If the httpCredentials are not valid and have not been changed since last challenge, then the connection attempt will be canceled.
 @param errorCode Error code returned by the HTTP server. For example: code 401 for authentication failure, code 403 for authorization failure.
 @param errorMessage Error message returned by the HTTP server.
 @param responseHeaders Response headers returned by the HTTP server.
 */
- (void)onHttpCommunicationError :(int32_t)errorCode :(NSString*)errorMessage :(SUPStringProperties*)responseHeaders{
    NSLog(@"SMPCallackHandler-onHttpCommunicationError");
}


/*!
 @method
 @abstract Invoked when download resource bundle complete
 @discussion
 @param customizationBundleID  The customization resource name. If null, application default bundled resource is downloaded
 @param errorCode If download fail, return error code. If download success, return 0
 @param errorMessage If download fail, return error message. If download success, return ""
 */
- (void)onCustomizationBundleDownloadComplete : (NSString*) customizationBundleID :  (int32_t) errorCode : (NSString*) errorMessage{
    NSLog(@"SMPCallackHandler-onCustomizationBundleDownloadComplete ");
}

/*!
 @method
 @abstract Invoked when a notification arrives.
 @discussion
 @param notifications
 @return An int to indicate if the notification has been handled.
 SUP_NOTIFICATION_CONTINUE if the notification was not handled by the callback method.
 SUP_NOTIFICATION_CANCEL if the notification has already been handled by the callback method.
 */
- (int)onPushNotification :(NSDictionary*)notification{
    NSLog(@"SMPCallackHandler-onPushNotification");
    return SUP_NOTIFICATION_CONTINUE;
}

@end
