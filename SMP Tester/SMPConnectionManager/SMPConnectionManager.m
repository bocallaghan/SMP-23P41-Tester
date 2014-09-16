//
//  SMPConnectionManager.m
//  SMP Tester
//
//  Created by Brenton O'Callaghan on 15/09/2014.
//  Copyright (c) 2014 Bluefin Solutions Ltd. All rights reserved.
//

#import "SMPConnectionManager.h"
#import "SMPCallbackHandler.h"
#import "SUPApplication.h"
#import "BFSMP_TesterDB.h"
#import "MBOLogger.h"

#define kSMPServer @"gblonsup01.bluefinsolutions.com"
#define kMBSPort    5001
#define kRBSPort    2480
#define kFarmID     @"0"
#define kURLSuffix  @"/tm/?cid=%cid%"
#define kProtocol   @"http"
#define kDomain     @"bf"
#define kClientID   @"0"

@interface SMPConnectionManager()

// An instance of our callback handler for application specific callbacks
// Not to be confused with the callback handler for the database
// activities.
@property (nonatomic, retain) SMPCallbackHandler *callbacklHandler;

@end

@implementation SMPConnectionManager{
    NSString *serverURL;
    NSString *farmID;
    NSString *urlSuffix;
    NSString *protocol;
    NSString *domain;
    NSString *clientID;
    
    int mbs;
    int rbs;
    
    NSString *user;
    NSString *pass;
    NSString *activationCode;
}

// Our static instance of the connection manager.
static SMPConnectionManager *connManager;

#pragma mark - Public Static Methods

// Initialise the app and do a registration over MBS to the SMP Server
+ (void)beginRegistration{
    
    NSLog(@"SMPConnectionManager - beginRegistration");
    
    // As we are using a static connection manager we need to check for its instance.
    // If we don't have an instance then we need to create one.
    if (!connManager) {
        connManager = [[[SMPConnectionManager alloc] init] retain];
        connManager.callbacklHandler = [[SMPCallbackHandler getInstance] retain];
    }
    
    // If we are disconnected then we need to begin the application setup.
    // Otherwise we are connecting or similar already so no need to proceed.
    if ([SUPApplication connectionStatus] == SUPConnectionStatus_DISCONNECTED) {
        
        NSLog(@"Creating new connection to the server");
        
        // Start the application connections.
        [connManager setupApplicationConnection];
        
    } else {
        NSLog(@"Already Connected");
    }
    
}

// Subscribe to the package and do a sync.
+ (void)beginSync{
    NSLog(@"SMPConnectionManager - beginSync");
    
    // Simply subscribe to the package - if this is successful then we will see the user listed as a package
    // user within the SCC for the MBO package that is deployed.
    [BFSMP_TesterDB subscribe];
}

// Retrieve a count of all valid records in the MBO
+ (NSNumber *)beginFindAll{
    NSLog(@"SMPConnectionManager - beginFindAll");
    return nil;
}

// Delete the DB and crash the app to reset.
+ (void)reset{
    @try {
        [BFSMP_TesterDB deleteDatabase];
        exit(0);
    }
    @catch (NSException *exception) {
        exit(1);
    }
}

#pragma mark - Private Methods


- (instancetype)init{
    
    if ([super init]) {
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"https"]) {
            self->protocol = @"https";
        } else {
            self->protocol = @"http";
        }
        
        self->serverURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"server_name"];
        self->mbs = [[[NSUserDefaults standardUserDefaults] stringForKey:@"mbs_port"] intValue];
        self->rbs = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"rbs_port"];
        
        self->farmID = [[NSUserDefaults standardUserDefaults] stringForKey:@"farm_id"];
        self->urlSuffix = [[NSUserDefaults standardUserDefaults] stringForKey:@"url_suffix"];
        self->domain = [[NSUserDefaults standardUserDefaults] stringForKey:@"domain"];
        self->clientID = [[NSUserDefaults standardUserDefaults] stringForKey:@"client_id"];
        
        self->user = [[NSUserDefaults standardUserDefaults] stringForKey:@"user"];
        self->pass = [[NSUserDefaults standardUserDefaults] stringForKey:@"pass"];
        self->activationCode = [[NSUserDefaults standardUserDefaults] stringForKey:@"activation_code"];
    }
    return self;
}

- (void)setupApplicationConnection{
    
    NSLog(@"SMPConnectionManager - setupApplicationConnection");
    
    NSInteger debugLevel = 7; // Same as macro LOG_DEBUG but without the warning.
    
    [MBOLogger setLogLevel:debugLevel];
    
    // Get a new instance of a SUP application.
    SUPApplication *app = [SUPApplication getInstance];
    
    // Set our app ID as defined within the MBO package.
    [app setApplicationIdentifier:@"SMP_Tester"];
    
    // Setup the callback handler for the application.
    [app setApplicationCallback:self.callbacklHandler];
    
    // Now we need to setup the connection properties for the MBS communication.
    SUPConnectionProperties *properties = [app connectionProperties];
    [properties setServerName:self->serverURL];
    [properties setPortNumber:self->mbs];
    [properties setFarmId:self->farmID];
    [properties setUrlSuffix:self->urlSuffix];
    [properties setNetworkProtocol:self->protocol];
    
    // Create and setup the login credentials for the server.
    SUPLoginCredentials *loginCred = [SUPLoginCredentials getInstance];
    [loginCred setUsername:self->user];
    [loginCred setPassword:@""];
    [properties setLoginCredentials:loginCred];
    [properties setActivationCode:self->activationCode];
    
    // If the database does not exist we need to create it.
    if (![BFSMP_TesterDB databaseExists]) {
        [BFSMP_TesterDB createDatabase];
    }
    
    // Now we setup the connection profile for the synchronisation with the server.
    SUPConnectionProfile *connProfile = [BFSMP_TesterDB getSynchronizationProfile];
    [connProfile setNetworkProtocol:self->protocol];
    [connProfile setPortNumber:self->rbs];
    [connProfile setServerName:self->serverURL];
    [connProfile setDomainName:self->domain];
    [connProfile setUser:self->user];
    [connProfile setPassword:self->pass];
    [connProfile setAsyncReplay:YES];
    [connProfile setClientId:self->clientID];
    
    // Register the database callback handler.
    [BFSMP_TesterDB registerCallbackHandler:self];
    
    // Set the application associated with the database.
    [BFSMP_TesterDB setApplication:app];
    
    // If we are registered then we simply start our connection again.
    // Otherwise we register the device.
    if ([SUPApplication registrationStatus] == SUPRegistrationStatus_REGISTERED) {
        [app startConnection:0];
    } else {
        [app registerApplication:0];
    }
}

// =========================================================================
#pragma mark - SUPCallbackHandler protocol methods

- (void)onSynchronizeSuccess{
    NSLog(@"SMPConnectionManager - onSynchronizeSuccess");
}

- (void)onSynchronizeFailure{
    NSLog(@"SMPConnectionManager - onSynchronizeFailure");
}

/*!
 @method
 @abstract Called at the beginning of processing a message from the server, before the message transaction starts.
 @param size The size of the incoming message content in bytes.
 @param method The method string from the message header.
 @param mbo If this message is for a specific MBO, the name of the MBO; otherwise null.
 @discussion This method will only be called on platforms using message-based synchronization.  Only the callback handler registered with the package database class will be invoked.
 */
- (void)onMessageStart:(int)size withMethod:(NSString*)method withMbo:(NSString*)mbo{
    NSLog(@"SMPConnectionManager - onMessageStart");
}

/*!
 @method
 @abstract   Called before applying an import to the database.
 @param entityObject The Mobile Business Object to be imported
 @discussion  Both CallbackHandlers registered for the MBO class of the entity and Package DB will be invoked.
 */
- (void)beforeImport:(id)entityObject{
    NSLog(@"SMPConnectionManager - beforeImport");
}

/*!
 @method
 @abstract   Called when an import message is successfully applied to the local database.
 @param entityObject The object.
 @discussion This method will be invoked when an import message is successfully applied to local database. However, it is not committed. One message from server may have multiple import entities and they would be committed in one transaction for the whole message.<p>Note:</p><p><ul><li>Stale data may be read from database at this time before commit of the whole message. Programmers are encouraged to wait for the next onTransactionCommit() is invoked then to read from database to obtain the updated data.</li><li> Both CallbackHandlers registered for the MBO class of the entity and Package DB will be invoked.</li></ul></p>
 */
- (void)onImport:(id)entityObject{
    NSLog(@"SMPConnectionManager - onImport");
}

/*!
 @method
 @abstract   Callback method invoked on replay failure.
 @param entityObject The Mobile Business Object to replay.
 @discussion Note that both CallbackHandlers registered for the MBO class of the entity and Package DB will be invoked.
 */
- (void)onReplayFailure:(id)entityObject{
    NSLog(@"SMPConnectionManager - onReplayFailure");
}

/*!
 @method
 @abstract   Callback method invoked on replay success.
 @param entityObject The Mobile Business Object to replay..
 @discussion Note that both CallbackHandlers registered for the MBO class of the entity and Package DB will be invoked.
 */
- (void)onReplaySuccess:(id)entityObject{
    NSLog(@"SMPConnectionManager - onReplaySuccess");
}

/*!
 @method
 @abstract   Callback method invoked on search failure.
 @param entityObject The backend search object.
 @discussion This method is for DOE-based applications only.  Note that both CallbackHandlers registered for the MBO class of the entity and Package DB will be invoked.
 */
- (void)onSearchFailure:(id)entityObject{
    NSLog(@"SMPConnectionManager - onSearchFailure");
}

/*!
 @method
 @abstract   Callback method invoked on search success.
 @param entityObject The backend search object.
 @discussion This method is for DOE-based applications only.  Note that both CallbackHandlers registered for the MBO class of the entity and Package DB will be invoked.
 */
- (void)onSearchSuccess:(id)entityObject{
    NSLog(@"SMPConnectionManager - onSearchSuccess");
}

/*!
 @method
 @abstract   Callback method invoked on login failure.
 @discussion This method will be invoked when login fails for a beginOnlineLogin call.  Only the callback handler registered for the package database class will be invoked.
 */
- (void)onLoginFailure{
    NSLog(@"SMPConnectionManager - onLoginFailure");
}

/*!
 @method
 @abstract   Callback method invoked on login success.
 @discussion This method will be invoked when login succeeds for a beginOnlineLogin call.  Only the callback handler registered for the package database class will be invoked.
 */
- (void)onLoginSuccess{
    NSLog(@"SMPConnectionManager - onLoginSuccess");
}

/*!
 @method
 @abstract   Callback method invoked on recover failure.
 @discussion Only the callback handler registered with the package database class will be invoked.
 */
- (void)onRecoverFailure{
    NSLog(@"SMPConnectionManager - onRecoverFailure");
}

/*!
 @method
 @abstract   Callback method invoked on recover success.
 @discussion Only the callback handler registered with the package database class will be invoked.
 */
- (void)onRecoverSuccess{
    NSLog(@"SMPConnectionManager - onRecoverSuccess");
}

/*!
 @method
 @abstract   Callback method invoked on subscribe failure.
 @discussion Only the callback handler registered with the package database class will be invoked.
 */
- (void)onSubscribeFailure{
    NSLog(@"SMPConnectionManager - onSubscribeFailure");
}

/*!
 @method
 @abstract   Callback method invoked on subscribe success.
 @discussion Only the callback handler registered with the package database class will be invoked.
 */
- (void)onSubscribeSuccess{
    NSLog(@"SMPConnectionManager - onSubscribeSuccess");
}

/*!
 @method
 @abstract   Callback method invoked when synchronization status changes.
 @param syncGroupList List of affected synchronization groups.
 @param context The current synchronization context.
 @return An @link //apple_ref/occ/tdef/SUPSynchronizationStatus/SUPSynchronizationStatusType SUPSynchronizationStatusType @/link value (SUPSynchronizationAction_CANCEL or SUPSynchronizationAction_CONTINUE)
 @discussion This method will be invoked at different stages of the synchronization. The status of the synchronization context specifies the stage of the synchronization.  If SynchronizationAction_CANCEL is returned then the synchronize will be cancelled if the  the status of the synchronization context is SynchronizationStatus_STARTING.
 */
- (SUPSynchronizationActionType)onSynchronize:(SUPObjectList*)syncGroupList withContext:(SUPSynchronizationContext*)context{
    NSLog(@"SMPConnectionManager - onSynchronize");
    return SUPSynchronizationAction_CONTINUE;
}

/*!
 @method
 @abstract   Callback method invoked when suspend subscription fails.
 @discussion Only the callback handler registered for the package database class will be invoked.
 */
- (void)onSuspendSubscriptionFailure{}

/*!
 @method
 @abstract   Callback method invoked when suspend subscription is successful.
 @discussion Only the callback handler registered for the package database class will be invoked.
 */
- (void)onSuspendSubscriptionSuccess{}

/*!
 @method
 @abstract   Callback method invoked when resume subscription fails.
 @discussion Only the callback handler registered for the package database class will be invoked.
 */
- (void)onResumeSubscriptionFailure{}

/*!
 @method
 @abstract   Callback method invoked when  resume subscription is successful.
 @discussion Only the callback handler registered for the package database class will be invoked.
 */
- (void)onResumeSubscriptionSuccess{}

/*!
 @method
 @abstract   Callback method invoked on unsubscribe failure.
 @discussion Only the callback handler registered for the package database class will be invoked.
 */
- (void)onUnsubscribeFailure{}

/*!
 @method
 @abstract   Callback method invoked on unsubscribe success.
 @discussion Only the callback handler registered for the package database class will be invoked.
 */
- (void)onUnsubscribeSuccess{}

/*!
 @method
 @abstract   Called when server has finished sending initial MBO data after the client has subscribed.
 @discussion Only the callback handler registered with the package database class will be invoked.
 */
- (void)onImportSuccess{
    NSLog(@"SMPConnectionManager - onImportSuccess");
}

/*!
 @method
 @abstract   Called when an exception occurs during message processing.
 @discussion Other callbacks in this interface (whose names begin with "on") are invoked inside a database transaction.  If the transaction will be rolled back due to an unexpected exception, this operation will be called with the exception (before rollback occurs). @link //apple_ref/occ/cl/SUPDefaultCallbackHandler SUPDefaultCallbackHandler @/link's onMessageException will rethrow the exception so that the messaging layer could retry the message. The application programmer has the option to implement a custom CallbackHandler NOT to rethrow the exception based on exception types or other conditions so that the message will not be retried.
 */
- (void)onMessageException:(NSException*)e{
    NSLog(@"SMPConnectionManager - onMessageException");
}

/*!
 @method
 @abstract   This method will be invoked after one message has been processed and committed.
 @discussion This method is only called at the end of handling an incoming message from the server - not for client initiated database changes that involve database transactions. Normally, onTransactionCommit is called at the end of the message handling to indicate that all database operations for the message have completed. Only the callback handler registered with the package database class will be invoked.
 
 */
- (void)onTransactionCommit{}

/*!
 @method
 @abstract   This method will be invoked after one message has been rolled back. It only happens when an exception was thrown when processing the message or from a custom callback method.
 @discussion This method is only called at the end of handling an incoming message from the server - not for client initiated database changes that involve database transactions. If there is a database error or some other problem that throws an exception during incoming message handling, e.g. when importing data, onTransactionRollback will be called. Only the callback handler registered with the package database class will be invoked.
 */
- (void)onTransactionRollback{}

/*!
 @method
 @abstract   Callback method invoked when all data is cleared after a server reset message is received..
 @discussion Only the callback handler registered with the package database class will be invoked.
 */
- (void)onResetSuccess{}

/*!
 @method
 @abstract   Callback method invoked on subscription end.
 @discussion This method will be invoked when reregistered or unsubscribed. All MBO data on the device would have been wiped out when this method is invoked. Only the callback handler registered with the package database class will be invoked.
 */
- (void)onSubscriptionEnd{}


@end
