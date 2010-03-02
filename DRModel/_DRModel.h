//
//  _DRModel.h
//
//  Created by Daniel Ricciotti on 1/21/10.
//  Copyright 2010 Daniel Ricciotti. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DRModelConstants.h"

@interface _DRModel : NSObject {
	NSMutableDictionary *queuePools;				// Pool (group) of NSOperationQueues
	NSMutableData *receivedData;
    NSDate *connectionTime;
    NSMutableString *diskPath;						// not used. This is supposed to be for the cache.
    NSURLConnection *connection;	
}
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSDate *connectionTime;
@property (nonatomic, assign) NSMutableString *diskPath;
@property (nonatomic, assign) NSURLConnection *connection;

- (queueID) allocateQueue:(int)numberOfQueues;
- (void) deallocateQueueWithIdentifier:(queueID)identifier;
- (void) setQueueStatus:(BOOL)enabled forIdentifier:(queueID)identifier;
- (void) setPrimaryPool:(queueID)poolID;
- (void) prioritizePools;
- (void) addOperation:(NSOperation*)operation toPool:(poolID)poolID;

- (void) testMethod;

@end
