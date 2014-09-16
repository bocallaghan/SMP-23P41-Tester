
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

#import "BFLocalKeyGenerator.h"
#import "BFLocalKeyGenerator+Internal.h"
#import "BFLocalKeyGeneratorMetaData.h"
#import "SUPLocalEntityDelegate.h"
#import "BFSMP_TesterDB.h"
#import "BFSMP_TesterDB+Internal.h"
#import "SUPEntityDelegate.h"
#import "SUPLocalKeyGenerator.h"

@implementation BFLocalKeyGenerator



#pragma mark -
#pragma mark Init, dealloc, getInstance
- (id)init
{
    self = [super initWithParameters:[BFSMP_TesterDB delegate]:@"co_smp_tester_1_0_localkeygenerator":100000];
    if (self) {
        // Initialization code here.
        [SUPLocalKeyGenerator setObjectInstance:@"BF":self];
    }
    
    return self;
}
- (void)dealloc
{
    self.remoteId = nil;
	[super dealloc];
}
+ (BFLocalKeyGenerator*)getInstance
{
    return [self instance];
}

static SUPLocalEntityDelegate *g_BFLocalKeyGenerator_delegate = nil;

+ (SUPLocalEntityDelegate *) delegate
{
	@synchronized(self) {
		if (g_BFLocalKeyGenerator_delegate == nil) {
			g_BFLocalKeyGenerator_delegate = [[SUPLocalEntityDelegate alloc] initWithName:@"BFLocalKeyGenerator" clazz:[self class]
				metaData:[self metaData] dbDelegate:[BFSMP_TesterDB delegate] database:[BFSMP_TesterDB instance]];
		}
	}
	
	return [[g_BFLocalKeyGenerator_delegate retain] autorelease];
}

static SUPEntityMetaDataRBS* BFLocalKeyGenerator_META_DATA;

+ (SUPEntityMetaDataRBS*)metaData
{
    if (BFLocalKeyGenerator_META_DATA == nil) {
 	   	BFLocalKeyGenerator_META_DATA = [[BFLocalKeyGeneratorMetaData alloc] init];
	}
	
	return BFLocalKeyGenerator_META_DATA;
}

- (SUPClassMetaDataRBS*)getClassMetaData
{
    return [[self class] metaData];
}

+ (int64_t)generateId
{
    return [[BFSMP_TesterDB delegate] generateLocalId];
}

static BFLocalKeyGenerator *instance = nil;
 
+ (BFLocalKeyGenerator*)instance
{
    @synchronized(self) {
        if (instance == nil) {
            // Singleton is never released
            instance = [[super allocWithZone:NULL] init];
             SUPKeyGeneratorPK* pk = [[[SUPKeyGeneratorPK alloc] init] autorelease];
             [pk setRemoteId:@"*"];
             [pk setBatchId:1];
             BFLocalKeyGenerator* batch = (BFLocalKeyGenerator*)[instance find:pk];
             if(batch)
                 [instance copyAll:batch];
        }
    }
    return instance;
}

+ (id) designateObjectForRetain: (id)obj NS_RETURNS_RETAINED
{
    return obj;
}
+ (id)allocWithZone:(NSZone *)zone
{
    return [self designateObjectForRetain:[self instance]];
}
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
 
- (id)retain
{
    return self;
}
 
- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}
 
- (oneway void)release
{
    //do nothing
}
 
- (id)autorelease
{
    return self;
}

+ (NSString *)generateGuid
{
	return [SUPStringUtil guid32];
}

@end