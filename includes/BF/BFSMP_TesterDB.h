
/* Copyright (c) Sybase, Inc. 2010-2013   All rights reserved.
 
 In addition to the license terms set out in the Sybase License Agreement for
 the Sybase Unwired Platform ("Program"), the following additional or different
 rights and accompanying obligations and restrictions shall apply to the source
 code in this file ("Code").  Sybase grants you a limited, non-exclusive,
 non-transferable, revocable license to use, reproduce, and modify the Code
 solely for purposes of (i) maintaining the Code as reference material to better
 understand the operation of the Program, and (ii) development and testing of
 applications created in connection with your licensed use of the Program.
 The Code may not be transferred, sold, assigned, sublicensed or otherwise
 conveyed (whether by operation of law or otherwise) to another party without
 Sybase's prior written consent.  The following provisions shall apply to any
 modifications you make to the Code: (i) Sybase will not provide any maintenance
 or support for modified Code or problems that result from use of modified Code;
 (ii) Sybase expressly disclaims any warranties and conditions, express or
 implied, relating to modified Code or any problems that result from use of the
 modified Code;OT BE LIABLE FOR ANY LOSS OR DAMAGE RELATING
 TO MODIFICATIONS MADE TO THE CODE OR FOR ANY DAMAGES RESULTING FROM USE OF THE
 MODIFIED CODE, INCLUDING, WITHOUT LIMITATION, ANY INACCURACY OF DATA, LOSS OF
 PROFITS OR DIRECT, INDIRECT, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES, EVEN
 IF SYBASE HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES;
 to indemnify, hold harmless, and defend Sybase from and against any claims or
 lawsuits, including attorney's fees, that arise from or are related to the
 modified Code or from use of the modified Code.
 
 */

#import "sybase_sup.h"


#import "SUPAbstractDBRBS.h"
#import "SUPSyncStatusListener.h"
#import "SUPDatabaseDelegate.h"
#import "BFSMP_TesterDBMetaData.h"
// Entity type definitions (for change log query)
#ifndef _ENTITY_TYPES_FOR_BFSMP_TesterDB_
#define _ENTITY_TYPES_FOR_BFSMP_TesterDB_
#endif
// End of entity type definitions
@class BFPersonalizationParameters;
@class SUPApplication;
@protocol SUPSynchronizationGroup;


@class SUPClassDelegate;
@class SUPClassMetaDataRBS;
@class SUPIndexMetaData;

// public interface declaration, can be used by application. 
/*!
 @class BFSMP_TesterDB
 @abstract This class is part of package "SMP_Tester:1.0"
 @discussion Generated by Sybase Unwired Platform, compiler version 2.3.4.285
*/

@interface BFSMP_TesterDB : SUPAbstractDBRBS
{
@private
    
}


- (id)init;
- (id)initWithName:(NSString*)name;
- (void)dealloc;


/*!
  @method 
  @abstract Returns the personalization parameters for this package
  @discussion
  @throws SUPPersistenceException
 */
+ (BFPersonalizationParameters*)getPersonalizationParameters;

/*!
  @method 
  @abstract Returns the database metadata
  @discussion
 */
+ (SUPDatabaseMetaDataRBS*)metaData;

/*!
  @method 
  @abstract Returns the database delegate
  @discussion
 */
+ (SUPDatabaseDelegate*)delegate;

/*!
  @method 
  @abstract Returns the callback handler for the database class.
  @discussion
 */
+ (NSObject<SUPCallbackHandler>*)callbackHandler;
/*!
  @method 
  @abstract Returns the connection profile.
  @discussion
 */
+ (SUPConnectionProfile*)connectionProfile;
/*!
  @method 
  @abstract Returns the connection profile.
  @discussion
 */
+ (SUPConnectionProfile*)getConnectionProfile;
/*!
  @method 
  @abstract Returns the synchronization profile.
  @discussion
 */
+ (SUPConnectionProfile*)getSynchronizationProfile;
/*!
  @method 
  @abstract Creates the database and initializes the tables for all MBOs in this package.
  @discussion
  @throws SUPPersistenceException
 */
+ (void)createDatabase;
/*!
  @method 
  @abstract Drop all data from all tables: if keepClientOnly = YES, do not drop data from client-only tables.
  @discussion
  @throws SUPPersistenceException
 */
+ (void)cleanAllData:(BOOL) keepClientOnly;
/*!
  @method 
  @abstract Drop all data from all tables, except client-only tables.
  @discussion
  @throws SUPPersistenceException
 */
+ (void)cleanAllData;
/*!
  @method 
  @abstract Deletes the database for this package.
  @discussion
  @throws SUPPersistenceException
 */
+ (void)deleteDatabase;
/*!
  @method 
  @abstract Return true if database exists, false otherwise.
  @discussion
 */
+ (BOOL)databaseExists;
/*!
  @method 
  @abstract Return the database connection for this package.
  @discussion
 */
+ (id<SUPConnectionWrapper>)getConnectionWrapper;
/*!
  @method 
  @abstract Opens database connection.
  @discussion
  @throws SUPPersistenceException
 */
+ (void)openConnection;
/*!
  @method 
  @abstract Closes database connection.
  @discussion
  @throws SUPPersistenceException
 */
+ (void)closeConnection;
/*!
  @method 
  @abstract Return the username used in communcations with server.
  @discussion
 */
+ (NSString*)getSyncUsername;
/*!
  @method 
  @abstract Return the package name.
  @discussion
 */
+ (NSString*)getPackageName;
/*!
  @method 
  @abstract Return the current server domain name.
  @discussion
 */
+ (NSString*)getDomainName;
/*!
  @method 
  @abstract Return the database schema version of this package.
  @discussion
 */
+ (int32_t)getSchemaVersion;
/*!
  @method 
  @abstract Return the protocol version of this package.
  @discussion
 */
+ (int32_t)getProtocolVersion;
/*!
  @method 
  @abstract Return the logger for this package.
  @discussion
 */
+ (id<SUPLogger>)getLogger;
/*!
  @method 
  @abstract Return the SynchronizationGroup instance corresponding to the given group name.
  @discussion
 */
+ (id<SUPSynchronizationGroup>) getSynchronizationGroup:(NSString*)syncGroup;
/*!
  @method 
  @abstract Returns true if this sync group has ever been synchronized.
  @discussion
 */
+ (BOOL)isSynchronized:(NSString*)syncGroup;
/*!
  @method 
  @abstract Returns the last time this group was synchronized, or nil if it has not been synchronized.
  @discussion
 */
+ (NSDate*)getLastSynchronizationTime:(NSString*)syncGroup;
/*!
  @method 
  @abstract Execute the passed in query and return a result set.
  @discussion
  @throws SUPPersistenceException
 */
+ (SUPQueryResultSet*)executeQuery:(SUPQuery*)query;
/*!
  @method 
  @abstract Set the callback handler for the database class.
  @discussion
 */
+ (void)registerCallbackHandler:(NSObject<SUPCallbackHandler>*)handler;
/*!
  @method 
  @abstract Set Application instance.
  @discussion
 */
+ (void)setApplication:(SUPApplication*)application;
/*!
  @method 
  @abstract Begin server communications.
  @discussion
 */
+ (void)startBackgroundSynchronization;
/*!
  @method 
  @abstract End server communications.
  @discussion
 */
+ (void)stopBackgroundSynchronization;
/*!
  @method 
  @abstract Subscribe to the server.
  @discussion
  @throws SUPPersistenceException
 */
+ (void)subscribe;
/*!
  @method 
  @abstract Send a message to the server to synchronize this client with the specified synchronization groups.
  @discussion
 */
+ (void)beginSynchronize:(SUPObjectList*)synchronizationGroups withContext:(NSString*)context withUploadOnly:(BOOL) uploadOnly withSyncStatusListener:(id<SUPSyncStatusListener>)listener;
/*!
  @method 
  @abstract Send a message to the server to synchronize this client with the specified synchronization groups.
  @discussion
 */
+ (void)beginSynchronize:(SUPObjectList*)synchronizationGroups withContext:(NSString*)context withUploadOnly:(BOOL) uploadOnly;
/*!
  @method 
  @abstract Send a message to the server to synchronize this client with the specified synchronization groups.
  @discussion
 */
+ (void)beginSynchronize:(SUPObjectList*)synchronizationGroups withContext:(NSString*)context;
/*!
  @method 
  @abstract Resumes the pending synchronization.
  @discussion
  @result YES if the pending synchronization is resumed; otherwise, NO if there is no synchronization pending.
 */
+ (BOOL)resumePendingSynchronization;
/*!
  @method 
  @abstract Cancels the pending synchronization.
  @discussion
  @result YES if the pending synchronization is cancelled; otherwise, NO if there is no synchronization pending.
 */
+ (BOOL)cancelPendingSynchronization;
/*!
  @method 
  @abstract Sets a flag to disable synchronization and cancel any ongoing synchronizations for this SUP package.
  @discussion
 */
+ (void)disableSync;
/*!
  @method 
  @abstract Enables or re-enables synchronization for this SUP package.
  @discussion
 */
+ (void)enableSync;
/*!
  @method 
  @abstract Returns true if synchronization is enabled, false otherwise.
  @discussion
 */
+ (BOOL)syncEnabled;
/*!
  @method 
  @abstract Submit all the pending operations (ready for sending to server) 
  @discussion
  @throws SUPPersistenceException
 */
+ (void)submitPendingOperations;
/*!
  @method 
  @abstract Submit all the pending operations for the given synchronization group (ready for sending to server).
  @discussion
  @throws SUPPersistenceException
 */
+ (void)submitPendingOperations:(NSString*)synchronizationGroup;
/*!
  @method 
  @abstract Search through all entities in this package and cancel any pending changes.
  @discussion
  @throws SUPPersistenceException
 */
+ (void)cancelPendingOperations;
/*!
  @method 
  @abstract Search through all entities in this package for the given synchronization group and cancel any pending changes.
  @discussion
  @throws SUPPersistenceException
 */
+ (void)cancelPendingOperations:(NSString*)synchronizationGroup;
/*!
  @method 
  @abstract return TRUE if there are replay pending requests, false otherwise.
  @discussion
 */
+ (BOOL)hasPendingOperations;
/*!
  @method 
  @abstract End the current subscription to the server.
  @discussion
 */
+ (void)unsubscribe;
/*!
  @method 
  @abstract Generate a new encryption key.
  @discussion
  @throws SUPPersistenceException
 */
+ (void)generateEncryptionKey;
/*!
  @method 
  @abstract Change the encryption key used for database encryption.
  @discussion
  @throws SUPPersistenceException
 */
+ (void)changeEncryptionKey:(NSString *)newKey;
/*!
  @method 
  @abstract Return log records matching the passed in query.
  @discussion
  @throws SUPPersistenceException
 */
+ (SUPObjectList*)getLogRecords:(SUPQuery*)query;
/*!
  @method 
  @abstract Submit any pending client-created log records to the server.
  @discussion
  @throws SUPPersistenceException
 */
+ (void)submitLogRecords;
/*!
  @method 
  @abstract synchronize the synchronizationGroup with server.
  @discussion
  @throws SUPPersistenceException
 */
+ (void)synchronize:(NSString*)synchronizationGroup;
/*!
  @method 
  @abstract synchronize all the synchronizationGroups with server.
  @discussion
  @throws SUPPersistenceException
 */
+ (void)synchronize;
/*!
  @method 
  @abstract synchronize the synchronizationGroups with server, using custom syncStatusListener.
  @discussion
  @throws SUPPersistenceException
 */
+ (void)synchronizeWithListener:(id<SUPSyncStatusListener>) listener;
/*!
  @method 
  @abstract synchronize the synchronizationGroup with server, using custom syncStatusListener.
  @discussion
  @throws SUPPersistenceException
 */
+ (void)synchronize:(NSString *)synchronizationGroup withListener:(id<SUPSyncStatusListener>)listener;
/*!
  @method 
  @abstract return YES if there is no replay pending request, NO otherwise
  @discussion
 */
+ (BOOL) isReplayQueueEmpty;
/*!
  @method 
  @abstract Retrieve currently queued background synchronization requests.
  @discussion
 */
+ (SUPObjectList*) getBackgroundSyncRequests;
/*!
  @method 
  @abstract enable Change Log.
  @discussion
 */
+ (void) enableChangeLog;
/*!
  @method 
  @abstract disable Change Log.
  @discussion
 */
+ (void) disableChangeLog;
/*!
  @method 
  @abstract Get the log record based on the query filtering 
  @discussion
 */
+ (SUPObjectList*) getChangeLogs:(SUPQuery*)query;
/*!
  @method 
  @abstract Delete all the change logs in the client.
  @discussion
 */
+ (void) deleteChangeLogs;
/*!
  @method 
  @abstract Get the MBO class name string from change log entity type. 
  @discussion
 */
+ (NSString*) getEntityName:(int)entityType;
/*!
  @method 
  @abstract Authenticate against the server.
  @discussion
  @throws SUPPersistenceException
 */
+ (void) onlineLogin;
/*!
  @method 
  @abstract Begin a local transaction.
  @discussion
 */
+ (SUPLocalTransaction*)beginTransaction;

/*!
  @method 
  @abstract Gets the path of the database file.
  @discussion
 */
+ (NSString*)getDbPath;
/*!
  @method 
  @abstract Create index for a table
  @discussion
  @throws SUPPersistenceException
 */
+ (void) createIndex:(SUPIndexMetaData *)index withEntity:(SUPEntityMetaDataRBS *)entity;
/*!
  @method 
  @abstract Drop the index for a table
  @discussion
  @throws SUPPersistenceException
 */
+ (void) dropIndex:(NSString*)name withEntity:(SUPEntityMetaDataRBS *)entity;
/*!
  @method 
  @abstract return list of indexes for the given entity
  @discussion
  @result SUPObjectList object - list of SUPIndexMetaData objects.
 */
+ (SUPObjectList*) getIndexes:(SUPEntityMetaDataRBS *)entity;


@end