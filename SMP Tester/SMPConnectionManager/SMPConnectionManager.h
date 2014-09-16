//
//  SMPConnectionManager.h
//  SMP Tester
//
//  Created by Brenton O'Callaghan on 15/09/2014.
//  Copyright (c) 2014 Bluefin Solutions Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUPCallbackHandler.h"

@interface SMPConnectionManager : NSObject <SUPCallbackHandler>

+ (void)beginRegistration;

// Subscribe to the package and do a sync.
+ (void)beginSync;

// Retrieve a count of all valid records in the MBO
+ (NSNumber *)beginFindAll;

// Delete the DB and crash the app to reset.
+ (void)reset;

@end
