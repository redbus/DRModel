#define LOGS TRUE
#import "Log.h"
//
//  _DRModel.m
//
//  Created by Daniel Ricciotti on 1/21/10.
//  Copyright 2010 Daniel Ricciotti. All rights reserved.
//

#import "_DRModel.h"
#import "DRGetImageOperation.h"
#import "DRGetJSONOperation.h"

@interface _DRModel (hidden)
- (NSOperationQueue*)getOperationQueue:(poolID)pid;
@end

@implementation _DRModel
@synthesize diskPath;
@synthesize connectionTime;
@synthesize receivedData;
@synthesize connection;

- (id)init {
	if (self = [super init]) {
		// Initalizes Class
		queuePools = [[NSMutableDictionary alloc] init];
		NSMutableArray *tempArray = [[NSMutableArray alloc] init];
		for (int i=0; i<4; i++) {
			NSOperationQueue *loadOperationQueue = [[NSOperationQueue alloc] init];
			[tempArray insertObject:loadOperationQueue atIndex:i];
			[loadOperationQueue release];
		}
		// Create the default pool (specialPoolDontCare)
		[queuePools setObject:tempArray forKey:[NSString stringWithFormat:@"%d",specialPoolDontCare]];
    }
    return self;
}
- (void) testMethod {
	NSLog(@"Test method was called!");
}
- (void) dealloc {
	[queuePools removeAllObjects];
	[queuePools release];
	[super dealloc];
}
#pragma mark -
#pragma mark Public User Methods

- (NSOperationQueue*)getOperationQueue:(poolID)pid {
	// Return an operation pool from the specified pool identifier. If the pool is invalid then return a queue from the default pool.
	// If the default pool is invalid, return NIL
	NSMutableArray *qarr= [queuePools objectForKey:[NSString stringWithFormat:@"%d",pid]];
	if (qarr == nil) {
		NSLog(@"Invalid pool identifier %d, switching to pool %d", pid, specialPoolDontCare);
		qarr= [queuePools objectForKey:[NSString stringWithFormat:@"%d",specialPoolDontCare]];
		if (qarr == nil) {
			NSLog(@"%d pool is invalid! No queue to return",specialPoolDontCare);
			return nil;
		}
		pid = specialPoolDontCare;
	}
	NSOperationQueue *qtemp = (NSOperationQueue*)[qarr objectAtIndex:0];
	int minCount = [[qtemp operations] count];
	int minIndex = 0;
	for (int i=1; i<[qarr count]; i++) {
		qtemp = [qarr objectAtIndex:i];
		if ([[qtemp operations] count] < minCount) {
			minCount = [[qtemp operations] count];
			minIndex = i;
		}
	}
	NSOperationQueue *q = [qarr objectAtIndex:minIndex];
	return q;
}
- (void) addOperation:(NSOperation*)operation toPool:(poolID)poolID {
	NSOperationQueue *q = [self getOperationQueue:poolID];
	if (q != nil) {
		[q addOperation:operation];
	}
}
- (void) clearCache {}
- (void) prioritizePools {}
- (void) setPrimaryPool:(queueID)poolID {}
- (queueID) allocateQueue:(int)numberOfQueues {
	// getQueueIdentifier
	// Returns an identifier to be used by a group of queries. The number of queues to be alloacted for the identifier
	// is set by (int) numberOfQueues. The queues are deallocated by the calling code using deallocateQueueWithIdentifier:
	int qid;
	for(qid=0; qid<=specialPoolDontCare; qid++) {
		// Find the first un-used queue identifier
		NSMutableArray *qarr= [queuePools objectForKey:[NSString stringWithFormat:@"%d",qid]];
		if (qarr == nil)
			break;
	}
	if (qid == specialPoolDontCare)
		return qid;
	if (numberOfQueues < 1)
		numberOfQueues = 1;
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	for (int i=0; i<numberOfQueues; i++) {
		// Alloocate operation queues and add them to the pool
		NSOperationQueue *loadOperationQueue = [[NSOperationQueue alloc] init];
		[tempArray insertObject:loadOperationQueue atIndex:i];
		[loadOperationQueue release];
	}
	// Set the pool
	[queuePools setObject:tempArray forKey:[NSString stringWithFormat:@"%d",qid]];
	NSLog(@"Allocating pool %d with %d queues", qid, numberOfQueues);
	return qid;
}
- (void) deallocateQueueWithIdentifier:(queueID)identifier {
	if (identifier == specialPoolDontCare) {
		NSLog(@"Can't deallocate pool %d", identifier);
		return;
	}
	NSMutableArray *pool = [queuePools objectForKey:[NSString stringWithFormat:@"%d",identifier]];
	NSLog(@"Deallocating pool %d (%d queues)",identifier,[pool count]);
	if (pool != nil) {
		for (int i=0; i<[pool count]; i++) {
			NSOperationQueue *q = [pool lastObject];
			[q setSuspended:YES];
			[q cancelAllOperations];
			[pool removeLastObject];	// Release each queue in pool
		}
	}
	[queuePools removeObjectForKey:[NSString stringWithFormat:@"%d",identifier]];	// Release pool
	return;
}
- (void) setQueueStatus:(BOOL)enabled forIdentifier:(queueID)identifier {
	if (identifier == specialPoolDontCare)
		return;
	if (enabled)
		NSLog(@"Setting queue %d status to TRUE",identifier);
	else
		NSLog(@"Setting queue %d status to FALSE",identifier);
	NSMutableArray *pool = [queuePools objectForKey:[NSNumber numberWithInt:identifier]];
	if (pool != nil) {
		for (int i=0; i<[pool count]; i++) {
			NSOperationQueue *q = [pool objectAtIndex:i];
			[q setSuspended:enabled];
		}
	} else {
		NSLog(@"  Pool %d is NIL",identifier);
	}
}

@end
