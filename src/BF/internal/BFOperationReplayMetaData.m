
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

#import "BFOperationReplayMetaData.h"

#import "SUPRelationshipMetaData.h"
#import "SUPOperationMetaData.h"
#import "SUPParameterMetaData.h"
#import "SUPIndexMetaData.h"
#import "SUPAttributeMap.h"
#import "SUPOperationMap.h"
#import "SUPClassMap.h"
#import "SUPEntityMap.h"
#import "SUPDataType.h"
#import "BFOperationReplay.h"
#import "SUPObjectList.h"
#import "BFSMP_TesterDBMetaData.h"

@implementation BFOperationReplayMetaData

+ (BFOperationReplayMetaData*)getInstance
{
    return [[[BFOperationReplayMetaData alloc] init] autorelease];
}

- (id)init
{
    if (self = [super init]) {
		self.id = 3;
		self.name = @"OperationReplay";
		self.klass = [BFOperationReplay class];
 		self.allowPending = NO;;

		self.isClientOnly = YES;

		SUPObjectList *attributes = [SUPObjectList getInstance];
		SUPAttributeMetaDataRBS* a_remoteId = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			95:
			[SUPDataType forName:@"string"]:@"varchar(100)":@"remoteId":@"":@"a":
			@"":100:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_remoteId setColumn:@"a"];
		SUPAttributeMetaDataRBS* a_component = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			97:
			[SUPDataType forName:@"string"]:@"varchar(200)":@"component":@"":@"c":
			@"":200:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_component setColumn:@"c"];
		SUPAttributeMetaDataRBS* a_entityKey = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			98:
			[SUPDataType forName:@"string"]:@"varchar(256)":@"entityKey":@"":@"d":
			@"":256:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_entityKey setColumn:@"d"];
		SUPAttributeMetaDataRBS* a_attributes = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			99:
			[SUPDataType forName:@"string"]:@"LONG VARCHAR":@"attributes":@"":@"e":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_attributes setColumn:@"e"];
		SUPAttributeMetaDataRBS* a_operation = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			100:
			[SUPDataType forName:@"string"]:@"varchar(100)":@"operation":@"":@"f":
			@"":100:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_operation setColumn:@"f"];
		SUPAttributeMetaDataRBS* a_parameters = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			101:
			[SUPDataType forName:@"string"]:@"LONG VARCHAR":@"parameters":@"":@"g":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_parameters setColumn:@"g"];
		SUPAttributeMetaDataRBS* a_replayLog = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			102:
			[SUPDataType forName:@"string?"]:@"LONG VARCHAR":@"replayLog":@"":@"h":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_replayLog setColumn:@"h"];
		SUPAttributeMetaDataRBS* a_exception = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			103:
			[SUPDataType forName:@"string?"]:@"LONG VARCHAR":@"exception":@"":@"i":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:YES:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_exception setColumn:@"i"];
		SUPAttributeMetaDataRBS* a_completed = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			104:
			[SUPDataType forName:@"boolean"]:@"tinyint":@"completed":@"":@"j":
			@"":-1:0:0:
			@"null":NO:@"":
			NO:NO:NO:NO:NO:NO:
			GeneratedScheme_NONE:
			NO:SUPPersonalizationType_None:NO];
		[a_completed setColumn:@"j"];
		SUPAttributeMetaDataRBS* a_requestId = [SUPAttributeMetaDataRBS attributeMetaDataWith:
			96:
			[SUPDataType forName:@"long"]:@"decimal(20,0)":@"requestId":@"":@"b":
			@"":-1:0:0:
			@"null":NO:@"":
			YES:NO:NO:NO:NO:NO:
			GeneratedScheme_GLOBAL:
			NO:SUPPersonalizationType_None:NO];
		[a_requestId setColumn:@"b"];
 	
		[attributes addThis:a_remoteId];
		[attributes addThis:a_component];
		[attributes addThis:a_entityKey];
		[attributes addThis:a_attributes];
		[attributes addThis:a_operation];
		[attributes addThis:a_parameters];
		[attributes addThis:a_replayLog];
		[attributes addThis:a_exception];
		[attributes addThis:a_completed];
		[attributes addThis:a_requestId];
		self.attributes = attributes;
		
		SUPAttributeMap * attributeMap = [SUPAttributeMap getInstance];
   		[attributeMap setAttributes:attributes];
	   	self.attributeMap = attributeMap;

 		SUPOperationMetaData* o_saveErrorInfo_0 = [SUPOperationMetaData createOperationMetaData:1:(SUPString)@"saveErrorInfo":[SUPDataType forName:@"void"]:true];
		[o_saveErrorInfo_0 setIsStatic:NO];
		[o_saveErrorInfo_0 setIsCreate:NO];
		[o_saveErrorInfo_0 setIsUpdate:NO];
		[o_saveErrorInfo_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_findReadyToFinish_0 = [SUPOperationMetaData createOperationMetaData:2:(SUPString)@"findReadyToFinish":[SUPDataType forName:@"OperationReplay*"]:true];
		[o_findReadyToFinish_0 setIsStatic:YES];
		[o_findReadyToFinish_0 setIsCreate:NO];
		[o_findReadyToFinish_0 setIsUpdate:NO];
		[o_findReadyToFinish_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_refresh_0 = [SUPOperationMetaData createOperationMetaData:3:(SUPString)@"refresh":[SUPDataType forName:@"void"]:true];
		[o_refresh_0 setIsStatic:NO];
		[o_refresh_0 setIsCreate:NO];
		[o_refresh_0 setIsUpdate:NO];
		[o_refresh_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o__pk_0 = [SUPOperationMetaData createOperationMetaData:4:(SUPString)@"_pk":[SUPDataType forName:@"long?"]:true];
		[o__pk_0 setIsStatic:NO];
		[o__pk_0 setIsCreate:NO];
		[o__pk_0 setIsUpdate:NO];
		[o__pk_0 setIsDelete:NO]; 		
 		SUPOperationMetaData* o_save_0 = [SUPOperationMetaData createOperationMetaData:5:(SUPString)@"save":[SUPDataType forName:@"void"]:true];
		[o_save_0 setIsStatic:NO];
		[o_save_0 setIsCreate:NO];
		[o_save_0 setIsUpdate:NO];
		[o_save_0 setIsDelete:NO]; 		
 
  		SUPObjectList *operations = [SUPObjectList listWithCapacity:5];
 		[operations addThis:o_saveErrorInfo_0];
 		[operations addThis:o_findReadyToFinish_0];
 		[operations addThis:o_refresh_0];
 		[operations addThis:o__pk_0];
 		[operations addThis:o_save_0];
	 	self.operations = operations;
 	
		SUPOperationMap *operationMap = [SUPOperationMap getInstance];
		[operationMap setOperations:operations];
		self.operationMap = operationMap;		
		self.table = @"smp_tester_1_0_operationreplay";
		self.synchronizationGroup = @"system";

    
			
		[self.keyList add:a_requestId];


  self.superClassDefined = YES;
    }
    return self;
}

@end