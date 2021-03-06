
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


#import "SUPClassWithMetaData.h"
#import "SUPAbstractROEntity.h"
#import "SUPLocalBusinessObject.h"
#import "SUPLocalEntityDelegate.h"
#import "SUPOperationReplay.h"


@class SUPEntityMetaDataRBS;
@class SUPLocalEntityDelegate;
@class SUPClassMetaDataRBS;

// public interface declaration, can be used by application. 
/*!
 @class BFOperationReplay
 @abstract This class is part of package "SMP_Tester:1.0"
 @discussion Generated by Sybase Unwired Platform, compiler version 2.3.4.285
*/

@interface BFOperationReplay : SUPAbstractROEntity<SUPOperationReplay, SUPClassWithMetaData>
{
@private
    NSString* _remoteId;
    NSString* _component;
    NSString* _entityKey;
    NSString* _attributes;
    NSString* _operation;
    NSString* _parameters;
    NSString* _replayLog;
    NSString* _exception;
    BOOL _completed;
    int64_t _requestId;
}


@property(retain,nonatomic) NSString* remoteId;
@property(retain,nonatomic) NSString* component;
@property(retain,nonatomic) NSString* entityKey;
@property(retain,nonatomic) NSString* attributes;
@property(retain,nonatomic) NSString* operation;
@property(retain,nonatomic) NSString* parameters;
@property(retain,nonatomic) NSString* replayLog;
@property(retain,nonatomic) NSString* exception;
@property(assign,nonatomic) BOOL completed;
@property(assign,nonatomic) int64_t requestId;


- (id) init;
- (void)dealloc;
/*!
  @method 
  @abstract Creates a new autoreleased instance of this class
  @discussion
 */
+ (BFOperationReplay*)getInstance;


+ (SUPEntityMetaDataRBS*)metaData;
/*!
  @method 
  @abstract Sets relationship attributes to null to save memory (they will be retrieved from the DB on the next getter call or property reference)
  @discussion
  @throws SUPPersistenceException
 */
- (void)clearRelationshipObjects;
/*!
  @method 
  @abstract Returns the entity for the primary key value passed in, or null if the entity is not found.
  @discussion
  @throws SUPPersistenceException
 */
+ (BFOperationReplay*)find:(int64_t)id_;
/*!
  @method 
  @abstract Returns the primary key for this entity.
  @discussion
 */
- (int64_t)_pk;
/*!
  @method 
  @abstract Returns the entity for the primary key value passed in; throws an exception if the entity is not found.
  @discussion
  @throws SUPPersistenceException
 */
+ (BFOperationReplay*)load:(int64_t)id;
/*!
  @method 
  @abstract Returns an SUPObjectList of log records for this entity.
  @discussion
  @throws SUPPersistenceException
 */
- (SUPObjectList*)getLogRecords;
/*!
  @method 
  @abstract Return a string description of this entity.
  @discussion
 */
- (NSString*)toString;
/*!
  @method 
  @abstract Return a string description of this entity.
  @discussion
 */
- (NSString*)description;
/*!
  @method
  @abstract Generated class method 
  @throws SUPPersistenceException
 */
+ (void)replay;
/*!
  @method
  @abstract Generated instance method 
  @throws SUPPersistenceException
 */
- (void)mbsReplay;
/*!
  @method
  @abstract Generated instance method 
  @throws SUPPersistenceException
 */
- (void)saveErrorInfo;
/*!
  @method
  @abstract Generated from an object query defined in the Eclipse tooling project for this package
  @param remoteId
  @throws SUPPersistenceException
 */

+ (SUPObjectList*)findReadyToReplay:(NSString*)remoteId;

/*!
  @method
  @abstract Generated from an object query defined in the Eclipse tooling project for this package
  @param remoteId
  @param skip
  @param take
  @throws SUPPersistenceException
 */

+ (SUPObjectList*)findReadyToReplay:(NSString*)remoteId skip:(int32_t)skip take:(int32_t)take;
/*!
  @method
  @abstract Generated from an object query defined in the Eclipse tooling project for this package
  @param remoteId
  @throws SUPPersistenceException
 */

+ (SUPObjectList*)findAsyncOperationToReplay:(NSString*)remoteId;

/*!
  @method
  @abstract Generated from an object query defined in the Eclipse tooling project for this package
  @param remoteId
  @param skip
  @param take
  @throws SUPPersistenceException
 */

+ (SUPObjectList*)findAsyncOperationToReplay:(NSString*)remoteId skip:(int32_t)skip take:(int32_t)take;
/*!
  @method
  @abstract Generated from an object query defined in the Eclipse tooling project for this package
  @throws SUPPersistenceException
 */

+ (SUPObjectList*)findReadyToFinish;

/*!
  @method
  @abstract Generated from an object query defined in the Eclipse tooling project for this package
  @param skip
  @param take
  @throws SUPPersistenceException
 */

+ (SUPObjectList*)findReadyToFinish:(int32_t)skip take:(int32_t)take;


@end
typedef SUPObjectList BFOperationReplayList;