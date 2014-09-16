//
//  SMPCallbackHandler.h
//  SMP Tester
//
//  Created by Brenton O'Callaghan on 15/09/2014.
//  Copyright (c) 2014 Bluefin Solutions Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUPApplicationCallback.h"

@interface SMPCallbackHandler : NSObject <SUPApplicationCallback>

+ (SMPCallbackHandler *)getInstance;

+ (NSMutableArray *)getLogMessages;

@end
