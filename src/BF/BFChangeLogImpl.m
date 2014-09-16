
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

/*
 Generated by Sybase Unwired Platform 
 Compiler version - 2.3.4.285
*/ 

#import "BFChangeLogImpl.h"
#import "BFChangeLogImpl+Internal.h"
#import "BFChangeLogImplMetaData.h"
#import "SUPJsonObject.h"
#import "SUPJsonReader.h"
#import "BFSMP_TesterDB.h"
#import "BFSMP_TesterDB+Internal.h"
#import "SUPEntityDelegate.h"
#import "SUPEntityMetaDataRBS.h"
#import "SUPQuery.h"
#import "BFKeyGenerator.h"
#import "BFLocalKeyGenerator.h"
#import "BFKeyGenerator+Internal.h"
#import "BFLocalKeyGenerator+Internal.h"
#import "BFLogRecordImpl.h"
#import "SUPConnectionWrapper.h"
#import "SUPLocalTransaction.h"
#import "SUPStatementWrapper.h"

@implementation BFChangeLogImpl


@synthesize operationType = _operationType;
@synthesize rootEntityType = _rootEntityType;
@synthesize rootSurrogateKey = _rootSurrogateKey;
@synthesize entityType = _entityType;
@synthesize surrogateKey = _surrogateKey;


#pragma mark -
#pragma mark Init, dealloc, getInstance
- (id) init
{
    if ((self = [super init]))
    {
        self.classMetaData = [BFChangeLogImpl metaData];
        [self setEntityDelegate:(SUPEntityDelegate*)[BFChangeLogImpl delegate]];
    }
    return self;    
}
- (void)dealloc
{
	[super dealloc];
}
+ (BFChangeLogImpl*)getInstance
{
     BFChangeLogImpl* me = [[BFChangeLogImpl alloc] init];
    [me autorelease];
    return me;
}



#pragma mark -
#pragma mark Property getters and setters

- (int32_t)entityType
{
    return _entityType;
}

- (int64_t)surrogateKey
{
    return _surrogateKey;
}

- (void)setOperationType:(unichar)newOperationType
{
    if (newOperationType != self->_operationType)
    {
        self->_operationType = newOperationType;
        self.isDirty = YES;
    }
}

- (void)setRootEntityType:(int32_t)newRootEntityType
{
    if (newRootEntityType != self->_rootEntityType)
    {
        self->_rootEntityType = newRootEntityType;
        self.isDirty = YES;
    }
}

- (void)setRootSurrogateKey:(int64_t)newRootSurrogateKey
{
    if (newRootSurrogateKey != self->_rootSurrogateKey)
    {
        self->_rootSurrogateKey = newRootSurrogateKey;
        self.isDirty = YES;
    }
}

- (void)setEntityType:(int32_t)newEntityType
{
    if (newEntityType != self->_entityType)
    {
        self->_entityType = newEntityType;
        self.isNew = YES;
    }
}

- (void)setSurrogateKey:(int64_t)newSurrogateKey
{
    if (newSurrogateKey != self->_surrogateKey)
    {
        self->_surrogateKey = newSurrogateKey;
        self.isNew = YES;
    }
}

#pragma mark -
#pragma mark Metadata methods

static SUPEntityMetaDataRBS* BFChangeLogImpl_META_DATA;

+ (SUPEntityMetaDataRBS*)metaData
{
    if (BFChangeLogImpl_META_DATA == nil) {
		BFChangeLogImpl_META_DATA = [[BFChangeLogImplMetaData alloc] init];
	}
	
	return BFChangeLogImpl_META_DATA;
}

- (SUPClassMetaDataRBS*)getClassMetaData
{
    return [[self class] metaData];
}

#pragma mark -
#pragma mark Clear relationship objects

- (void)clearRelationshipObjects
{
}

#pragma mark -
#pragma mark find() and related methods
+ (id)allocInitialTraceRequest:(NSString*)method withSkip:(int32_t)skip withTake:(int32_t)take withSql:(NSString*)sql withValues:(SUPObjectList*)values
{
    id request = nil;
    
    CFSCTraceLevel level = [SUPCFSCTrace getTraceLevel];
    NSMutableString *params = [[[NSMutableString alloc] init] autorelease];

    for (id val in values)
    {
        [params appendFormat:@"%@;", [SUPStringUtil toString_object:val]];
    }
    if (skip >=0)
    	[params appendFormat:@"skip=%d;", skip];
    if (take >= 0)
        [params appendFormat:@"take=%d", take];
    if (level == CFSCTraceLevel_DETAIL)
    {
        
        request = [[SUPCFSCTraceDetailRequest alloc] initWithParams:@"BFChangeLogImpl" :method :nil:nil:[NSDate date] :nil :0
                                                                   :nil :NO :NO :NO :NO :NO :sql :params];
    } else if (level == CFSCTraceLevel_NORMAL)
    {
        request = [[SUPCFSCTraceRequest alloc] initWithParams:@"BFChangeLogImpl"  :method :nil :nil  :[NSDate date] :nil :0 :params];
    }
    return request;
}
+ (void)finishTraceRequest:(id)request :(int)rows
{
    if (!request)
    {
        return;
    }
    
    SUPCFSCTraceRequest *traceReq = (SUPCFSCTraceRequest *)request;
    
    traceReq.endTime = [NSDate date];
  
    traceReq.count = rows;
    
    [SUPCFSCTrace log:(id)request];
}

+ (BFChangeLogImpl*)find:(BFChangeLogKey*)id_
{
    SUPCFSCTraceRequest* request = nil;
    NSString *msg = @"success";
    if ([SUPCFSCTrace isEnabled])
    {
        request = [[SUPCFSCTraceRequest alloc] initWithParams:@"BFChangeLogImpl" :@"find" 
            :nil :[self metaData].synchronizationGroup  :[NSDate date] :nil :0 :[SUPStringUtil toString_object:id_]];
    } 
    BFChangeLogImpl* result = nil;
    @try {
         SUPObjectList *keys = [SUPObjectList getInstance];
         [keys add:[NSNumber numberWithInt:id_.entityType]];
         [keys add:[NSNumber numberWithLongLong:id_.surrogateKey]];
         result = (BFChangeLogImpl*)[(SUPEntityDelegate*)([[self class] delegate]) findEntityWithKeys:keys];
         return result;
     }
     @catch (NSException *e) {
        msg = [NSString stringWithFormat:@"fail in BFChangeLogImpl--find: %@:%@", [e name], [e reason]];        
        CFSCTraceLogError(msg);
        @throw e;
    }
    @finally
    {
        if (request)
        {
            request.endTime = [NSDate date];
            if ([msg isEqualToString:@"success"])
                request.count = 1;

            [SUPCFSCTrace log:(id)request];
            [request release];
        }
    }
}

+ (SUPObjectList*)findWithQuery:(SUPQuery*)query
{
    return (SUPObjectList*)[(SUPEntityDelegate*)([[self class] delegate])  findWithQuery:query:[BFChangeLogImpl class]];
}

- (BFChangeLogKey*)_pk
{
    return (BFChangeLogKey*)[self i_pk];
}

+ (BFChangeLogImpl*)load:(BFChangeLogKey*)id_
{
    return (BFChangeLogImpl*)[(SUPEntityDelegate*)([[self class] delegate]) load:id_];
}
#pragma mark -
#pragma mark Log record methods

- (SUPObjectList*)getLogRecords
{
   return [BFLogRecordImpl findByEntity:@"ChangeLogImpl":[self keyToString]];
}




#pragma mark -
#pragma mark Description implemetation

- (NSString*)toString
{
	NSString* str = [NSString stringWithFormat:@"\
	ChangeLogImpl = \n\
	    operationType = %c,\n\
	    rootEntityType = %i,\n\
	    rootSurrogateKey = %qi,\n\
	    entityType = %i,\n\
	    surrogateKey = %qi,\n\
	    isNew = %i,\n\
        isDirty = %i,\n\
        isDeleted = %i,\n\
	\n"
    	,self.operationType
    	,self.rootEntityType
    	,self.rootSurrogateKey
    	,self.entityType
    	,self.surrogateKey
		,self.isNew
		,self.isDirty
		,self.isDeleted
	];
	return str;

}

- (NSString*)description
{
	return [self toString];
}



+ (void) deleteChangeLogs
{
    NSString *sql = @"truncate table smp_tester_1_0_changelogimpl";
    id<SUPConnectionWrapper> connection = nil;
    id<SUPStatementWrapper> preparedStatement = nil;
    SUPLocalTransaction* transaction = nil;
    BOOL ok = NO;
    @try
    {
        [[BFSMP_TesterDB dblock] writeLock];
        connection = [BFSMP_TesterDB getConnectionWrapper];
        transaction = ([connection inTransaction] ? nil : [BFSMP_TesterDB beginTransaction]);
        preparedStatement = [connection prepareStatement:sql];
        [preparedStatement execute];
     	ok = YES;
    }
    @catch (NSException *e) {
        ok = NO;
        @throw e;
    }
    @finally {
        [preparedStatement close];
        if (ok)
        {
            [transaction commit];
        }
        else
        {
            [transaction rollback];
        }
        [connection releaseToPool];
        [[BFSMP_TesterDB dblock] unlock];
    }    
    
}

#pragma mark - 
#pragma mark Delegate method (internal)

static SUPEntityDelegate *g_BFChangeLogImpl_delegate = nil;

+ (SUPEntityDelegate *) delegate
{
	@synchronized(self) {
		if (g_BFChangeLogImpl_delegate == nil) {
			g_BFChangeLogImpl_delegate = [[SUPEntityDelegate alloc] initWithName:@"BFChangeLogImpl" clazz:[self class]
				metaData:[self metaData] dbDelegate:[BFSMP_TesterDB delegate] database:[BFSMP_TesterDB instance]];
		}
	}
	
	return [[g_BFChangeLogImpl_delegate retain] autorelease];
}

#pragma mark -
#pragma mark JSON methods (internal)


- (SUPJsonObject*)getAttributeJson:(int)id_
{
    switch(id_)
    {
        default:
        return [super getAttributeJson:id_];
    }

}
- (void)setAttributeJson:(int)id_ :(SUPJsonObject*)value
{
    switch(id_)
    { 
        default:
            [super setAttributeJson:id_:value];
            break;
    }

}

+ (SUPObjectList*)fromJSONList:(SUPJsonArray*)jsonArray
{
    if(jsonArray == nil)
        return nil;
    
    SUPObjectList* instanceList = [[SUPObjectList alloc] initWithCapacity:1];
    [instanceList autorelease];
    if(instanceList == nil)
        return nil;

    for (SUPJsonObject* jsonObject in jsonArray)
    {
        BFChangeLogImpl* inst = [[BFChangeLogImpl alloc] init];
        [inst readJson:jsonObject];
        [instanceList add:inst];
        [inst release];
    }
    return instanceList;
}

+ (SUPJsonArray*)toJSONList:(SUPObjectList*)instanceList
{
    SUPJsonArray* jsonArray = [[SUPJsonArray alloc] init];
    [jsonArray autorelease];
    for (BFChangeLogImpl* inst in instanceList)
    {
        SUPJsonObject *o = [[SUPJsonObject alloc] init];
        [inst writeJson:o];
        [jsonArray add:o];
        [o release];
    }
    return jsonArray;
}

#pragma mark -
#pragma mark Internal attribute get/set methods
-(SUPLong) getAttributeLong:(int)id_
{
    switch(id_)
    {
    case 208:
        return self.rootSurrogateKey;
    case 205:
        return self.surrogateKey;
    default:
         return [super getAttributeLong:id_];
    }
}

-(void) setAttributeLong:(int)id_ :(SUPLong)v
{
    switch(id_)
    {
    case 208:
        self.rootSurrogateKey = v;
        break;;
    case 205:
        self.surrogateKey = v;
        break;;
    default:
        [super setAttributeLong:id_:v];
        break;;
    }
}
-(SUPChar) getAttributeChar:(int)id_
{
    switch(id_)
    {
    case 206:
        return self.operationType;
    default:
         return [super getAttributeChar:id_];
    }
}

-(void) setAttributeChar:(int)id_ :(SUPChar)v
{
    switch(id_)
    {
    case 206:
        self.operationType = v;
        break;;
    default:
        [super setAttributeChar:id_:v];
        break;;
    }
}
-(SUPInt) getAttributeInt:(int)id_
{
    switch(id_)
    {
    case 207:
        return self.rootEntityType;
    case 204:
        return self.entityType;
    default:
         return [super getAttributeInt:id_];
    }
}

-(void) setAttributeInt:(int)id_ :(SUPInt)v
{
    switch(id_)
    {
    case 207:
        self.rootEntityType = v;
        break;;
    case 204:
        self.entityType = v;
        break;;
    default:
        [super setAttributeInt:id_:v];
        break;;
    }
}
- (id)getAttributeLargeObject:(int)id_ loadFromDB:(BOOL)loadFromDB
{
    switch(id_)
    {
        default:
        return [super getAttributeJson:id_];
    }
}
- (void)setAttributeLargeObject:(int)id_ :(id)value
{
    switch(id_)
    {
        default:
            [super setAttributeJson:id_:value];
            break;
    }

}



#pragma mark -
#pragma mark Object queries and operation implementations
/*!
  @method
  @abstract Generated class method 
  @param query
  @throws SUPPersistenceException
 */
+ (int32_t)getSize:(SUPQuery*)query
{
    return [(SUPEntityDelegate*)([[self class] delegate]) getSize:query];
}

@end